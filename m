From: Matthias Reichl <hias@horus.com>
Subject: Re: [PATCH] ASoC: soc-core: Fix null pointer
 dereference in soc_find_component
Date: Tue, 15 Jan 2019 22:11:37 +0100
Message-ID: <20190115211137.rhdyjadu7fppp3p4@lenny.lan>
References: <1547194442-1487-1-git-send-email-rohitkr@codeaurora.org>
 <d8726e9a-3477-a573-8c1a-dd8245068802@linux.intel.com>
 <4886ed21-65d2-159d-afcd-bb26dcde636e@linux.intel.com>
 <20190115000610.GM11073@sirena.org.uk>
 <796a856c-a9a6-022d-da63-947279090198@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.horus.com (mail.horus.com [78.46.148.228])
 by alsa0.perex.cz (Postfix) with ESMTP id D5553266834
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2019 22:11:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <796a856c-a9a6-022d-da63-947279090198@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, vinod.koul@linaro.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, Ajit Pandey <ajitp@codeaurora.org>, linux-kernel@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, srinivas.kandagatla@linaro.org, asishb@codeaurora.org, Rohit kumar <rohitkr@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 15, 2019 at 01:35:07PM -0600, Pierre-Louis Bossart wrote:
> =

> On 1/14/19 6:06 PM, Mark Brown wrote:
> > On Fri, Jan 11, 2019 at 03:49:08PM -0600, Pierre-Louis Bossart wrote:
> > =

> > > Adding some traces I can see that the the platform name we use doesn'=
t seem
> > > compatible with your logic. All the Intel boards used a constant plat=
form
> > > name matching the PCI ID, see e.g. [1], which IIRC is used to bind
> > > components. Liam, do you recall in more details if this is really req=
uired?
> > That's telling me that either snd_soc_find_components() isn't finding
> > components in the same way that we do when we bind things which isn't
> > good or we're binding links without having fully matched everything on
> > the link which also isn't good.
> > =

> > Without a system that shows the issue I can't 100% confirm but I think
> > it's the former - I'm fairly sure that those machines are relying on the
> > component name being initialized to fmt_single_name() in
> > snd_soc_component_initialize().  That is supposed to wind up using
> > dev_name() (which would be the PCI address for a PCI device) as the
> > basis of the name.  What I can't currently see is how exactly that gets
> > bound (or how any of the other links avoid trouble for that matter).  We
> > could revert and push this into cards but I would rather be confident
> > that we understand what's going on, I'm not comfortable that we aren't
> > just pushing the breakage around rather than fixing it.  Can someone
> > with an x86 system take a look and confirm exactly what's going on with
> > binding these cards please?
> =

> Beyond the fact that the platform_name seems to be totally useless,
> additional tests show that the patch ('ASoC: soc-core: defer card probe
> until all component is added to list') adds a new restriction which
> contradicts existing error checks.
> =

> None of the Intel machine drivers set the dailink "cpu_name" field but use
> the "cpu_dai_name" field instead. This was perfectly legit as documented =
by
> the code at the end of soc_init_dai_link()

This should be fixed by the patch
"ASoC: core: Don't defer probe on optional, NULL components" which Mark
already applied to his tree. See
http://mailman.alsa-project.org/pipermail/alsa-devel/2019-January/144323.ht=
ml

Maybe the defer card probe logic needs to be extended to also check if
dai_link_name had already been registered (either cpu or cpu_dai_name
needs to be set), not 100% sure which problem the defer card probe patch
was trying to solve.

so long,

Hias

> =

> =A0=A0=A0 /*
> =A0=A0=A0 =A0* At least one of CPU DAI name or CPU device name/node must =
be
> =A0=A0=A0 =A0* specified
> =A0=A0=A0 =A0*/
> =A0=A0=A0 if (!link->cpu_dai_name &&
> =A0=A0=A0 =A0=A0=A0 !(link->cpu_name || link->cpu_of_node)) {
> =A0=A0=A0 =A0=A0=A0 dev_err(card->dev,
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 "ASoC: Neither cpu_dai_name nor cpu_name/of=
_node are set for
> %s\n",
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 link->name);
> =A0=A0=A0 =A0=A0=A0 return -EINVAL;
> =A0=A0=A0 }
> =

> The code contributed by Qualcomm only checks for cpu_name, which prevents
> the init from completing.
> =

> So if we want to be consistent, the new code should be something like:
> =

> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index b680c673c553..2791da9417f8 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1154,7 +1154,7 @@ static int soc_init_dai_link(struct snd_soc_card
> *card,
> =A0=A0=A0=A0=A0=A0=A0=A0 * Defer card registartion if cpu dai component i=
s not added to
> =A0=A0=A0=A0=A0=A0=A0=A0 * component list.
> =A0=A0=A0=A0=A0=A0=A0=A0 */
> -=A0=A0=A0=A0=A0=A0 if (!soc_find_component(link->cpu_of_node, link->cpu_=
name))
> +=A0=A0=A0=A0=A0=A0 if (!link->cpu_dai_name && !soc_find_component(link->=
cpu_of_node,
> link->cpu_name))
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EPROBE_DEFER;
> =

> =A0=A0=A0=A0=A0=A0=A0 /*
> =

> or try to call soc_find_component with both cpu_name or cpu_dai_name, if
> this makes sense?
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
