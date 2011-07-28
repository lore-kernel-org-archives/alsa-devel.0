From: Adrian Knoth <adi-5gjw4BGRu82yAo/rNOIehoJPQCENF9+z@public.gmane.org>
Subject: [LAD] [RME - hdsp] Multiface/Digiface/RPM detection
Date: Thu, 28 Jul 2011 22:31:07 +0200
Message-ID: <4E31C70B.5080300@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
List-Unsubscribe: <http://lists.linuxaudio.org/options/linux-audio-dev>,
	<mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxaudio.org/pipermail/linux-audio-dev>
List-Post: <mailto:linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
List-Help: <mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linuxaudio.org/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
Errors-To: linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
To: linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi!

I've recently added support for the RME RPM to hdspmixer. Unfortunately,
I don't have one, it's been done blindly with user feedback.

This very user now reports that he needs to upload the device firmware
from windows. I've checked hdsploader, and of course, it needs patching.
I'll take care in a second.

More surprisingly, though, the kernel wasn't able to upload the firmware
itself, because it fails to detect the RPM and hence tries to upload a
multiface firmware.

After reading the kernel source, I think the code in hdsp.c is wrong:

		if (hdsp_fifo_wait(hdsp, 0, HDSP_SHORT_WAIT)) {
			hdsp_write(hdsp, HDSP_control2Reg, HDSP_VERSION_BIT);
			hdsp_write(hdsp, HDSP_control2Reg, HDSP_S_LOAD);
			if (hdsp_fifo_wait(hdsp, 0, HDSP_SHORT_WAIT))
				hdsp->io_type = RPM;
			else
				hdsp->io_type = Multiface;
		} else {
			hdsp->io_type = Digiface;
		}


Who here owns a Digiface and can confirm or deny that the kernel
correctly detects it as Digiface? Same for Multiface, though I guess
since it's more or less the default, users wouldn't notice it.

What's wrong with the code above? I think all occurrences of
HDSP_control2Reg in hdsp_check_for_iobox need to be changed to
HDSP_controlRegister and the second hdsp_fifo_wait needs to be inverted.

But this is pure guesswork. If I come up with a patch, who here has a
RPM, Digiface or Multiface to test it?



TIA
