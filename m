From: Pavel Roskin <proski@gnu.org>
Subject: Re: integration of via668 and via8233 drivers
Date: Fri, 6 Sep 2002 03:08:40 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0209060225290.4125-100000@portland.hansa.lan>
References: <s5hr8g8l8gw.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hr8g8l8gw.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello!

> > > hmm, this recalls some posts on l-k ml in the last year.
> > > it might be a hardware problem, namely, VIA motherboards.
> > > is your motherboard KT266A?
> > 
> > No, it's KT-133.
> 
> does this info help?
> 
> 	http://www.networking.tzo.com/net/software/readmes/techvl019d.htm

It's a Windows driver that changes some registers of the chipset.  It also
reloads those registers after the sleep, so they are not saved in the
hardware, so there is no way this driver can affect ALSA drivers under
Linux kernel.  The Linux kernel 2.4.20-pre5 that I'm using has some
VIA-specific code, which does something similar to that Windows driver.  
Anyway, all this is most likely irrelevant.

Binary search shows that the driver from "2002/07/19 17:00 UTC" is fine, 
but 15 minutes later, at "2002/07/19 17:15 UTC", the driver is already 
broken.

The diff between those time pints is fairly large, since "Scatter-Gather 
PCM access" was introduced in between:

revision 1.20
date: 2002/07/19 17:10:53;  author: tiwai;  state: Exp;  lines: +157 -206
added the support of sg buffer pcm

However, I can take the old (17:00) via686 driver and compile it with the
new (17:15) source tree, and everything is fine.  My interpretation is
that it's not the introduction of Scatter-Gather PCM access that broke the
driver.  It's porting of the via686 driver to Scatter-Gather that caused
the problem.

The "helicopter sound" can be reproduced with the "play" test from the 
oss-test suite.  The sound is different if I run the test more than once.

It's interesting that the problem seems to mostly affect some programs but
not the others.  That's what I tested with the new, broken driver:

timidity -Oe ode2joy.mid                           Bad
timidity -Od -o /dev/dsp ode2joy.mid               Ok
timidity -Ou -o /dev/audio ode2joy.mid             Ok
mpg321 -o esd bwv538.mp3                           Bad
mpg321 -o oss bwv538.mp3                           Ok
mpg321 -o alsa bwv538.mp3                          Ok
aplay cow.wav                                      Bad
sox cow.wav -t ossdsp /dev/dsp                     Ok
cat cow.au >/dev/audio                             Ok
xmms bwv538.mp3  (OSS driver)                      Bad
xmms bwv538.mp3  (eSound driver)                   Bad
timidity -Ou -o - ode2joy.mid | aplay -            Bad
timidity -Ow -o - ode2joy.mid | aplay -            Ok

-- 
Regards,
Pavel Roskin



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
