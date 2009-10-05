From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: Re: [PATCH] ascenario: Add scenario support to alsa-lib
Date: Mon, 5 Oct 2009 11:35:02 +0200
Message-ID: <20091005093502.GC3983@excalibur.local>
References: <1254390436-5283-1-git-send-email-stefan@datenfreihafen.org>
	<1254390436-5283-2-git-send-email-stefan@datenfreihafen.org>
	<20091001122835.GC14417@sirena.org.uk>
	<20091001131948.GA5936@excalibur.local>
	<20091001150849.GE5936@excalibur.local>
	<20091005082747.GA3983@excalibur.local>
	<alpine.LNX.2.00.0910051111220.31529@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="KDt/GgjP6HVcx58l"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirius.lasnet.de (sirius.lasnet.de [78.47.116.19])
	by alsa0.perex.cz (Postfix) with ESMTP id E73A024369
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Oct 2009 11:35:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0910051111220.31529@eeebox2.perex-int.cz>
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
Cc: Graeme Gregory <gg@slimlogic.co.uk>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Ian Molton <ian@mnementh.co.uk>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org


--KDt/GgjP6HVcx58l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

On Mon, 2009-10-05 at 11:14, Jaroslav Kysela wrote:
> On Mon, 5 Oct 2009, Stefan Schmidt wrote:
> 
> >On Thu, 2009-10-01 at 17:08, Stefan Schmidt wrote:
> >>
> >>For an updated patch with all your comments inlcuded see below.
> >
> >Here is another update on this patch. Fixed a problem I introduced in the last
> >iteration and changed the config tokens from MasterPlaybackVolume to Master
> >Playback Volume, etc. That's based on a siggestion from Mark which we had
> >offlist. Let me quote it here to explain the good reasoning behind it.
> 
> Question: What's the IDs (integers) returned with
> snd_scenario_get_master_playback_volume() etc. functions?

That is part of the code Liam wrote, but let me answer it (and maybe Liam chime
in if it is wrong or needs more explanation).

It's just the numid of an alsa control which should be used as master playback,
etc in this scenario. It aliases the function we can use with ascenario to the
real ones in alsa which can bedifferent for different scenarios.

> Please, include also some test configuration files to review the
> configuration syntax.

Attached. default.conf is the main configuration file located at
/etc/alsa/scenario/default.conf

playback_hs is an example of scenario syntax and playback_hs_sequence is an
example of the sequence syntax. Both file names are referenced from default.conf
and located under
/etc/alsa/scenario/default/

regards
Stefan Schmidt

--KDt/GgjP6HVcx58l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="default.conf"

# Test scenario configuration for Machine X
# Author: Joe Bloggs <joe@bloggs.com>
# lines beginning with # are comments

Section "Scenario"

# scenario unique name (mandatory)
	Identifier = "playback speaker"

# scenario file name (mandatory)
	File = "playback_spk"

# scenario audio quality of service (optional) - HIFI, VOICE or SYSTEM
	QoS = HIFI

# alias for master playback volume (optional)
	Master Playback Volume = 8

# alias for master playback switch (optional)
	Master Playback Switch = 2

# alias for master capture volume (optional)
	Master Capture Volume = 3

# alias for master capture switch (optional)
	Master Capture Switch = 4

EndSection

Section "Scenario"

# scenario unique name (mandatory)
	Identifier = "playback headphones"

# scenario file name (mandatory)
	File = "playback_hp"

# scenario audio quality of service (optional) - HIFI, VOICE or SYSTEM
	QoS = HIFI

# alias for master playback volume (optional)
	Master Playback Volume = 10

# alias for master playback switch (optional)
	Master Playback Switch = 20

# alias for master capture volume (optional)
	Master Capture Volume = 30

# alias for master capture switch (optional)
	Master Capture Switch = 40

# Sequencer to allow pre and post scenario changes (optional)
	PreSequenceFile = "playback_hp_sequence"
	PostSequenceFile = "playback_hp_sequence"
EndSection

Section "Scenario"

# scenario unique name (mandatory)
	Identifier = "playback headset"

# scenario file name (mandatory)
	File = "playback_hs"

# scenario audio quality of service (optional) - HIFI, VOICE or SYSTEM
	QoS = HIFI

# alias for master playback volume (optional)
	Master Playback Volume = 1

# alias for master playback switch (optional)
	Master Playback Switch = 2

# alias for master capture volume (optional)
	Master Capture Volume = 3

# alias for master capture switch (optional)
	Master Capture Switch = 4

# Sequencer to allow pre and post scenario changes (optional)
	PreSequenceFile = "playback_hs_sequence"
	PostSequenceFile = "playback_hs_sequence"
EndSection


--KDt/GgjP6HVcx58l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=playback_hs

1:'Capture Volume':2:65536,65536
2:'Capture Switch':1:1
3:'Master Playback Volume':2:52429,52429
4:'Master Playback Switch':1:1

--KDt/GgjP6HVcx58l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=playback_hs_sequence

# comment
kcontrol "Master Playback Volume" = "23"
kcontrol "Master Playback Switch" = "1"
msleep = 1000000 # fofoof
kcontrol "Master Playback Volume" = "42"

--KDt/GgjP6HVcx58l
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--KDt/GgjP6HVcx58l--
