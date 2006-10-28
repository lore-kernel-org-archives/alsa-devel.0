From: "Konstantin Shaposhnikov" <k.shaposhnikov@gmail.com>
Subject: Test Patch6 for Conexant HD Audio on HP DV2000
Date: Sat, 28 Oct 2006 23:30:28 +0100
Message-ID: <b12092cb0610281530u5f80b124o1dc7bf3b2a7052c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I would like to help with testing of alsa driver for HDA Conexant chipset.

I have HP DV2000 notebook. Current version of alsa driver (1.013)
works almost fine, but there two issues that should be fixed:

1. When I plug-in headphone jack sound can be heard both from speakers
and headphones.
2. Internal microphone doesn't work (at least arecord doesn't record anything)

I've applied Test Patch6 for Conexant HD Audio
(http://cache.gmane.org//gmane/linux/alsa/devel/41540-001.bin) to
alsa-driver-1.0.13 but unfortunately above mentioned issues not yet
fixed.

It looks like patch tries to solve the first problem, and
cxt5047_hp_automute function is called when HP jack is plugged in or
plugged out, but following code in this function has no effect:
        snd_hda_codec_amp_update(codec, 0x14, 0, HDA_OUTPUT, 0,
         0x80, present ? 0x80 : 0);
  snd_hda_codec_amp_update(codec, 0x14, 1, HDA_OUTPUT, 0,
         0x80, present ? 0x80 : 0);

If you want me to perform some experiments on my notebook, I am glad to do it.
Any ideas how to fix decribed problems are appreciated.

Regards,
Konstantin
--
http://step-inside.org

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
