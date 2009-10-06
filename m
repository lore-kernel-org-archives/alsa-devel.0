From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: Re: [PATCH] ascenario: Add scenario support to alsa-lib
Date: Tue, 6 Oct 2009 12:29:53 +0200
Message-ID: <20091006102953.GA3181@dodger.lab.datenfreihafen.org>
References: <1254390436-5283-1-git-send-email-stefan@datenfreihafen.org>
	<1254390436-5283-2-git-send-email-stefan@datenfreihafen.org>
	<20091001122835.GC14417@sirena.org.uk>
	<20091001131948.GA5936@excalibur.local>
	<20091001150849.GE5936@excalibur.local>
	<20091005082747.GA3983@excalibur.local>
	<alpine.LNX.2.00.0910051111220.31529@eeebox2.perex-int.cz>
	<20091005093502.GC3983@excalibur.local>
	<alpine.LNX.2.00.0910060949070.31529@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirius.lasnet.de (sirius.lasnet.de [78.47.116.19])
	by alsa0.perex.cz (Postfix) with ESMTP id CFC6C24156
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 12:31:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0910060949070.31529@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Ian Molton <ian@mnementh.co.uk>, Graeme Gregory <gg@slimlogic.co.uk>, Stefan Schmidt <stefan@datenfreihafen.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hello.

On Tue, 2009-10-06 at 10:23, Jaroslav Kysela wrote:
> 
> 	Some ideas, proposal for further discussion...

Thanks for that.

> On Mon, 5 Oct 2009, Stefan Schmidt wrote:
> 
> >On Mon, 2009-10-05 at 11:14, Jaroslav Kysela wrote:
> >>On Mon, 5 Oct 2009, Stefan Schmidt wrote:
> >>
> >>>On Thu, 2009-10-01 at 17:08, Stefan Schmidt wrote:
> >>
> >>Question: What's the IDs (integers) returned with
> >>snd_scenario_get_master_playback_volume() etc. functions?
> >
> >That is part of the code Liam wrote, but let me answer it (and
> >maybe Liam chime in if it is wrong or needs more explanation).
> >
> >It's just the numid of an alsa control which should be used as
> >master playback, etc in this scenario. It aliases the function we
> >can use with ascenario to the real ones in alsa which can
> >bedifferent for different scenarios.
> 
> It's not very clear. The exported functions should be documented at
> least with doxygen.

They are documented with doxygen in ascenario.h. But I just see that not all
return values are described.

> Also, I would move all _get_ functions to one with this interface:
> 
> #define SND_SCENARIO_KEY_KCTL_MASTER_PLAYBACK_VOLUME	1
> .....
> 
> int snd_scenario_get(scenario, int key, void *result);
> 
> It will allow us to extend this interface without adding many
> functions in future, something like:
> 
> #define SND_SCENARIO_KEY_PCM_PLAYBACK			11
> .....

I understand your point about having a more generic function for this. The
design of ascenario was however fixed to only these four functions. They were
not added to copy the funtionality already in alsa-lib, but to offer a control
alias for the four most used functions under the same name over all scenarios.
(Liam, as always, jump in if I explain it wrong here as you did the design way
before I started to work on it.)

> Also, using numid's is not much ideal if something changes in the
> driver. I would prefer to use standard ctl IDs (string, index,
> interface - result should be snd_ctl_elem_id_t).

That's something Mark and Takashi alrerady brought up and we agreed on. Is this
something you want to have before a merge is considered or is this something you
would accept as follow-up patch?

> >>Please, include also some test configuration files to review the
> >>configurationsyntax.
> >
> >Attached. default.conf is the main configuration file located at
> >/etc/alsa/scenario/default.conf
> 
> Again, I would make configuration syntax compatible with other
> alsa-lib configuration files. The changes in the configuration files
> will be small and it will allow us to rewrite the code using parsers
> in alsa-lib.
> 
> Something like:
> 
> default.conf:
> 
> scenario."playback speaker" {
>   file playback_spk
>   qos HIFI
>   "Master Playback Volume" 8
> # should be rather something like:
>   kcontrol.'Master Playback Volume' "'Master Playback Volume':33"
> # or a short form might be implemented (:33 is ctl_id index, ctl_id.name
> # would be copied from the variable key name):
>   kcontrol.'Master Playback Volume' ":33"
>   ...
> }
> 
> scenario."playback headphones" {
>   ...
> }
> 
> About "playback_hs_*" files. It seems that the purpose of files is
> quite similar. I don't understand the reason to have 2 different
> descriptions.

Hmm, I'm not sure I get what you mean here. Do you mean that the post and pre
sequence files are similar? That could of course be different on different
hardware. It's not a must that we would use the same sequence before and after
the scenario to reduce the pops and other noise.

> Also, I would like to consider moving the parser from alsactl
> initialization code (see alsactl_init.c in alsa-utils package) to
> alsa-lib and use this parser also for these files. It gives much
> flexibility, although udev-like syntax is not ideal, I know. But we
> have full documentation in alsactl_init.xml, at least.

The configuration format may indeed be critical as changing it after a merge
would be painful. Besides the actual code changes it would cost a fiar amount of
time to test and debug these. Liam, what do you say about it?

regards
Stefan Schmidt
