From: "Dr. med. =?iso-8859-15?q?G=FCnther?= Montag" <Safari.Doktor@addcom.de>
Subject: Re: env LD_PRELOAD=/usr/lib/libaoss.so ....
Date: Thu, 16 Oct 2003 17:56:10 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310161756.10517.Safari.Doktor@addcom.de>
References: <200310161413.28379.Safari.Doktor@addcom.de> <s5hu169gwgh.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: Quoted-Printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hu169gwgh.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net, hfterm-hackers@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hallo Takashi!
> ~/.asoundrc.  simply add
>
> 	pcm.dsp0 pcm.default
>
Thanks! It helped one step more!
Now:
***
hfkernel[1488]: hfkernel 0.4.2 starting...
hfkernel[1488]: Your soundcard is full duplex capable.
Good; the reference time will be
derived from the sample clock, which should be accurate within +-20ppm.
So I hope your soundcard uses 'real' crystals instead of cheap ceramic
resonators. Adjust the clock with the soundcard correction factor.
ALSA lib pcm_plug.c:727:(snd_pcm_plug_hw_refine_schange) Unable to find a=
n=20
usable access for 'dsp0'
hfkernel[1488]: error: probe_oss: mmap: ibuf: PROT_READ: Invalid argument

***
without success I  tried the things in the oss-emulatiuon.txt with echoin=
g=20
direct or block or non-block into /proc/asound/card0/pcm0c/oss etc.
in all variations.
Any more ideas?

> you can generate the document via doxygen.
> the already formatted html is found at
> 	http://www.alsa-project.org/alsa-doc/alsa-lib
>
Thanks, I found it, the doc is great, i must & will dig into it...
G=FCnther

Safari.Doktor@addcom.de


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
