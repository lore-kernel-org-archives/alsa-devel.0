From: Friedrich Ewaldt <Friedrich.Ewaldt@gmx.de>
Subject: SiS748/963L + CMI9739, no IRQs from card?
Date: Thu, 04 Dec 2003 22:32:26 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FCFA7EA.2050708@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I've described my problem some days ago on the user list, but it seems 
like no user knows a solution to this -- which is no big surprise as the 
hardware I'm using is quite new.
Perhaps one of the developers can help out.

Here a short summary of the problem:
(details, logs, etc. can be found in my previous messages:
http://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg10537.html
http://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg10562.html
)

* Alsa rc1

* ASrock Mainboard K7S8XE with SiS748/963L + CMI9739 onboard sound

* modules loaded without problems
(snd-intel8x0, snd-ac97-codec, ...)

* soundcard is correctly(?) detected: alsamixer shows:
SiS SI7012, C-Media Electronics CMI9739

* mixer is working fine (I can control e.g. the volume of CD analog input)

* PCM playback blocks: applications seem to wait for interrupt from 
soundcard. When running e.g. aplay,
proc/asound/card0/pcm0p/sub0/state shows

state: RUNNING
trigger_time: 1070397701.434501000
tstamp      : 1070397750.192659000
delay       : 7194
avail       : 4806
avail_max   : 0
-----
hw_ptr      : 4804
appl_ptr    : 11998

and hw_ptr doesn't change over time. I have no sound daemon running. 
Before starting aplay the sub0/state was 'closed'.

* same behaviour with oss-layer, alsa, alsa mmap. xmms hangs when I hit 
the play button.

* No PCM sound is output

* /proc/interrupts shows no IRQs sent from soundcard:
...
2:          0          XT-PIC  cascade
5:          0          XT-PIC  usb-ohci, ehci_hcd, SiS SI7012
8:          1          XT-PIC  rtc
...

Is there anything else I could try? Any additional debugging information 
I can provide besides the info in the 2 user-list mails mentioned above?
Thanks in advance for any help!




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
