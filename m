From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ascenario: Add scenario support to	alsa-lib
Date: Thu, 1 Oct 2009 13:28:35 +0100
Message-ID: <20091001122835.GC14417@sirena.org.uk>
References: <1254390436-5283-1-git-send-email-stefan@datenfreihafen.org>
	<1254390436-5283-2-git-send-email-stefan@datenfreihafen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 83DD0103934
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 14:28:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1254390436-5283-2-git-send-email-stefan@datenfreihafen.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Ian Molton <ian@mnementh.co.uk>, alsa-devel@alsa-project.org, Graeme Gregory <gg@slimlogic.co.uk>, Stefan Schmidt <stefan@slimlogic.co.uk>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 01, 2009 at 11:47:15AM +0200, Stefan Schmidt wrote:

> It allows switching audio settings between scenarios or uses-cases like
> listening to music and answering an incoming phone call. Made of control
> aliasing for playback, capture master and switch as well as the option to
> post- and prefix a sequence of control changes avoiding pops and other
> unwanted noise. Some example programs will be available in alsa-utils.

Overall this looks good - it's certainly dealing with the issues we
currently have with separating routing control and 'end user' controls.

> +/** Scenario ID's
> + *
> + * Standard Scenario ID's - Add new scenarios at the end.
> + */

Extra 's here.

> +/**
> + * snd_scenario_reload - reload and reparse scenario configuration
> + * @scn: scenario
> + *
> + * Reloads and reparses sound card scenario configuration.
> + */
> +int snd_scenario_reload(struct snd_scenario *scn);

I guess the idea is that in the future this will be removed and the
scenario API will use inotify or similar to pick up changes.

One thing I think I'm missing with the API documentation here is a
separation between the API used for setting up scenarios and the API
used by random client applications - it's there, but it could be
underlined a bit more.  Probably putting the client application stuff at
the top of the header file would help here since the functions that more
people will use will be visible first.

> +/* load scenario i */
> +static int read_scenario_file(struct snd_scenario *scn)
> +{
> +	int fd, ret;
> +	FILE *f;
> +	char filename[MAX_FILE];
> +	struct scenario_info *info = &scn->scenario[scn->current_scenario];
> +
> +	sprintf(filename, "%s/%s/%s", ALSA_SCN_DIR, scn->card_name,
> +		info->file);

snprintf().

> +		if (strncmp(tbuf, "MasterPlaybackVolume", 20) == 0) {
> +			info->playback_volume_id = get_int(tbuf + 20);
> +			if (info->playback_volume_id < 0) {
> +				scn_error("%s: failed to get MasterPlaybackVolume\n",
> +					__func__);
> +				goto err;
> +			}
> +			continue;
> +		}

I don't see anywhere which supplies a default value for all these
control IDs.  A memset() of the allocated block should deal with that
I think since IIRC zero isn't a valid control ID.  It'd also be nice to
be able to use control names instead but that's something that could be
added later.

Thinking out loud here but I'm wondering if it might make sense to
replace the fixed list of controls that is there currently with
something string based which can remap the control names if required.
This would allow for (probably in the future) having the scenario pass
back a list of controls without the API having to cater for each
explicitly, which would allow for other things like hardware EQ controls
to be passed on to the scenario users if desired - this is useful when
you get things like systems with multiple EQs.

This would complicate the API, though, and so I think it would be better
left as-is until we get to the point of having something like a plugin
for rewriting the controls for applications so they don't need explicit
knowledge of scenarios.  At that point it would only impact the scenario
manager implementation which should deal with the complexity, at least
externally.

I'm also thinking that it could be good to add functions to identify
which PCMs on a card to use in the scenario, perhaps differentiated by
quality or something.  The CPU may have PCMs to multiple devices or with
differing capabilities and may want to switch between them depending on
scenario (and possibly stream).
