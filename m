From: alsa-devel.20.pris@spamgourmet.com
Subject: Re: HDA or AC97 for Nvidia MCP61S?
Date: Fri, 30 Nov 2007 01:47:48 -0200
Message-ID: <74eb4bb50711291947j19061286na3af8608718ae667@mail.gmail.com>
References: <74eb4bb50711130834u5a6801daga4837be299a3f9c1@mail.gmail.com>
	<s5hmythfg4k.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gourmet.spamgourmet.com (gourmet.spamgourmet.com
	[216.75.35.164]) by alsa0.perex.cz (Postfix) with ESMTP id B473024454
	for <alsa-devel@alsa-project.org>; Fri, 30 Nov 2007 04:48:01 +0100 (CET)
Received: from gourmet.spamgourmet.com (localhost.localdomain [127.0.0.1])
	by gourmet.spamgourmet.com (8.13.8/8.13.7) with ESMTP id lAU3lso5025390
	for <alsa-devel@alsa-project.org>; Fri, 30 Nov 2007 03:47:55 GMT
Received: (from jqh1@localhost)
	by gourmet.spamgourmet.com (8.13.8/8.13.8/Submit) id lAU3lpFm025229
	for alsa-devel@alsa-project.org; Fri, 30 Nov 2007 03:47:51 GMT
In-Reply-To: <s5hmythfg4k.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11/14/07, Takashi Iwai - tiwai@suse.de wrote:

> >
> > as I already reported on another email I'm having problems with my sound:
> >
> > http://thread.gmane.org/gmane.linux.alsa.devel/49412
>
> Did you try my suggestion?
>

Yes Takashi,

I finally tried your suggestion.

To be more exact, I followed the instructions at the following
address, using the newest driver version of course(1.0.15):

https://help.ubuntu.com/community/HdaIntelSoundHowto

So, I downloaded and installed 1.0.15 of alsa-driver, alsa-lib and alsa-utils.

I tried the following configurations in /etc/modprobe.d/alsa-base:

options snd-hda-intel model=3stack-660
options snd-hda-intel model=3stack-660-digout

Rebooted, no luck.

After that I installed the latest driver snapshot: alsa-driver-hg20071129
Note that in this case I didn't reinstall alsa-lib and alsa-utils but
kept the 1.0.15 version that I had just installed.

Results: avi files play and I hear the music sound fine, but when
people speak, it is all garbled and low volume. Again, the soundtrack
works but not the talking.

Any help is appreciated!

Roland
