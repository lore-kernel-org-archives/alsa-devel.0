From: Chris Rankin <rankincj@yahoo.com>
Subject: alsamixer has stopped working with snd-usb-audio
Date: Mon, 8 Nov 2004 22:32:37 +0000 (GMT)
Message-ID: <20041108223237.96633.qmail@web52908.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

Is the alsamixer application still supposed to work
with snd-usb-audio? I have a USB webcam as a third
sound device, but its built-in microphone is no longer
accessible via alsamixer. However, it's still working
with amixer:

$ amixer -c2
Simple mixer control 'Mic',0
  Capabilities: cvolume cswitch cswitch-joined
  Capture channels: Mono
  Limits: Capture 0 - 3
  Mono: Capture 2 [67%] [on]

$ alsamixer -c2
No mixer elems found
 
Cheers,
Chris



	
	
		
___________________________________________________________ALL-NEW Yahoo! Messenger - all new features - even more fun! http://uk.messenger.yahoo.com


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
