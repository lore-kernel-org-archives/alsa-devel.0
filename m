From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: Re: [PATCH] ascenario: Add scenario support to alsa-lib
Date: Wed, 7 Oct 2009 15:48:09 +0200
Message-ID: <20091007134809.GA14456@excalibur.local>
References: <20091005082747.GA3983@excalibur.local>
	<alpine.LNX.2.00.0910051111220.31529@eeebox2.perex-int.cz>
	<20091005093502.GC3983@excalibur.local>
	<alpine.LNX.2.00.0910060949070.31529@eeebox2.perex-int.cz>
	<s5hzl847w3q.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0910061048410.31529@eeebox2.perex-int.cz>
	<s5hvdis7txp.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0910061302330.31529@eeebox2.perex-int.cz>
	<alpine.LNX.2.00.0910061510320.31529@eeebox2.perex-int.cz>
	<s5hfx9w3a98.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirius.lasnet.de (sirius.lasnet.de [78.47.116.19])
	by alsa0.perex.cz (Postfix) with ESMTP id 8648E10386F
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Oct 2009 15:48:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hfx9w3a98.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Ian Molton <ian@mnementh.co.uk>, Graeme Gregory <gg@slimlogic.co.uk>, Stefan Schmidt <stefan@datenfreihafen.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hello.

On Tue, 2009-10-06 at 15:46, Takashi Iwai wrote:
> At Tue, 6 Oct 2009 15:33:39 +0200 (CEST),
> Jaroslav Kysela wrote:
> > 
> > On Tue, 6 Oct 2009, Jaroslav Kysela wrote:
> > 
> > My other proposals:
> > 
> > - remove all SND_SCN_ defines - they are quite use-case specific
> >    - the names should be just documented somewhere
> 
> Keeping the basic and common strings makes sense, I think.
> After all, the apps need to use the correct strings.

What would you put under basic and common strings? Remove all that are gsm, bt
or ip realted for now?

> > - represent QoS with string (name) rather than integer -
> >    QoS is also quite use-case specific

Hmm, what would that buy us?

> > - SND_SCN_INT_QOS may be SND_SCN_INT_QOS_POWER ?

Makes sense, done.

> > - what about to remove QOS and add universal parameter interface?
> >    something like:
> > 
> > int snd_scenario_set_parameter(snd_scenario_t *scn, char *type, char *value);
> 
> This sounds not bad, but let's argue first what parameters could be
> added in future.

Any concrete examples here? I'm not against a more generic interface, but I have
problems to see good use cases for it.

I implemented the snd_scenario_get_control_id() function you favoured over the
explicit functions. Also two more small patches posted in a new thread.

regards
Stefan Schmidt
