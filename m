From: Steve deRosier <derosier@pianodisc.com>
Subject: hw pause in USB
Date: Mon, 12 Dec 2005 17:43:17 -0800
Message-ID: <439E2735.4060700@pianodisc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

All,

When I have a USB pcm device attached and I press pause in my application, I get a "burp" of audio out of device.  Un-pausing is fine, but then my MIDI and audio are no longer synced up.  This happens in several different players in our system.  This doesn't happen when using the on-board audio (but we're recommending USB audio devices to some customers since the on-board audio may be somewhat noisy for certain configurations).  BTW, this happens on 6 different USB audio devices from different manufacturers.

When running my player via commandline and pressing pause, I get the following error message out of ALSA lib:

ALSA lib pcm_hw.c:535:(snd_pcm_hw_pause) SNDRV_PCM_IOCTL_PAUSE failed: Function not implemented

I'm guessing that the USB driver doesn't implement pause.

My program implements pause by calling snd_pcm_pause( hPCM, 1 );.

For drill:
# cat /proc/asound/cards
0 [rev50          ]: VIA686A - VIA 82C686A/B rev50
                     VIA 82C686A/B rev50 at 0xdc00, irq 10
1 [Opus7          ]: Serial - Serial midi (uart16550A)
                     Serial midi (uart16550A) at 0x3f8, irq 4 speed 115200 div 1 outs 3 ins 3 adaptor Generic droponfull 1
2 [AN1            ]: USB-Audio - HiFi Link AN1
                     XITEL HiFi Link AN1 at usb-0000:00:07.2-1, full speed
# cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.4 (Mon May 17 14:31:44 2004 UTC).
Compiled on Jun 23 2004 for kernel 2.6.7.

So, the questions:
* Is there a better way to implement pause in my client program?  
* Is the USB driver broken?  
* Does a more current USB driver fix this issue?  Yes, I know there are more current alsa releases; I ask this because upgrading and qualifying a new kernel and alsa lib on our device is not a trivial undertaking and if a more current USB driver doesn't absolutely fix it then I've got a serious time issue on my hands.
* Can anybody suggest any other workarounds?

Thanks,
- Steve


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
