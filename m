From: Joachim Blaabjerg <styx@gentoo.org>
Subject: Fwd: [Alsa-user] VIA VT8235 (ALC201) problems
Date: Wed, 16 Oct 2002 16:28:19 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200210161628.19666.styx@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I'm forwarding this to -devel, just in case you guys know something that th=
e=20
folks on -user don't.

I guess I should mention that I sometimes get this error message while=20
attempting to play sound (not always, though):

ALSA lib pcm_hw.c:398:(snd_pcm_hw_prepare) SNDRV_PCM_IOCTL_PREPARE failed:=
=20
Device or resource busy

Some times I get that error, although the sound continues to play. FWIW, I =
use=20
Linux 2.4.19 with a huge patchset (sys-kernel/lolo-sources i Gentoo/Portage=
).

This might be very irrelevant and uninteresting, but I tried getting it to=
=20
work again just now, and this quote is a bit incorrect:

> It tends to play sounds very, very slowly, and 1/10 second samples over a=
nd=20
> over again (perhaps 20 times).

It's more like 0.5 second samples that are played five times. :P

Best Regards,

=2D---------  Forwarded Message  ----------

Subject: [Alsa-user] VIA VT8235 (ALC201) problems
Date: Wednesday 16 October 2002 15:49
=46rom: Joachim Blaabjerg <styx@gentoo.org>
To: alsa-user@lists.sourceforge.net

Hi,

I recently bought an EPoX 8K5A2 motherboard, with an onboard ALC201 sound
chip. This motherboard utilizes VIA's new VT8235 south bridge (as opposed to
VT8233 in most other recent VIA chipset boards), which I think may be the
cause of my sound problems. I've tried various ALSA drivers with little or =
no
success; neither of via82cxxx_audio, snd-via686a or snd-intel8x0 will load
(init_module: No such device).

There is however one driver that does load: snd-via8233. Sadly, this driver
fails to produce anything but noise. It tends to play sounds very, very
slowly, and 1/10 second samples over and over again (perhaps 20 times).

I've looked at the RealTek site, and they offer driver downloads. This is
 just a repackaging of alsa-driver-0.9.0_rc3 (which I am using), and a
 prewritten modules.conf that utilises the snd-via8233 module.

Has anyone had any luck with this sound chip/motherboard?

Best Regards,


=2D------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm
_______________________________________________
Alsa-user mailing list
Alsa-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-user

=2D------------------------------------------------------



-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm
