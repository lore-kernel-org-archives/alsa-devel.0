From: Domen Puncer <domen@coderock.org>
Subject: snd_mpu401_uart: hang when trying to play .mid
Date: Sun, 5 Sep 2004 11:22:35 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040905092234.GA3605@masina.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hi.

"hang" here means: not even alt+sysrq+p responds

I tried to play some .mid files with kmid, I wouldn't be suprised if
it didn't work, but it *hanged* the computer!

2 messages appeared on console (retyped):
cmd: 0xff failed at 0x20 (status = 0x50, data = 0x0)
cmd: 0x3f failed at 0x20 (status = 0x3f, data = 0x3)

These messages come from mpu401_uart.c:snd_mpu401_uart_cmd
It seems like commands MPU401_RESET and MPU401_ENTER_UART fail,
but code continues, ignoring that.

At this point it might be clear to alsa developers why/when hang
occours, if not I'll provide more data next weekend.



kernel: 2.6.9-rc1-bk7

modules:
snd_trident            42344  1 
snd_util_mem            3904  1 snd_trident
snd_mpu401_uart         7040  1 snd_trident
snd_ens1371            22760  0 
snd_rawmidi            22820  2 snd_mpu401_uart,snd_ens1371
snd_ac97_codec         66064  2 snd_trident,snd_ens1371
(don't have the ens1371 card inside, at the moment)

domen@masina:~/kernel/a$ cat /proc/asound/cards 
0 [SI7018         ]: SI7018 - SiS SI7018
                     SiS SI7018 PCI Audio at 0xd800, irq 11
domen@masina:~/kernel/a$ cat /proc/asound/devices 
  1:       : sequencer
  0: [0- 0]: ctl
  8: [0- 0]: raw midi
 17: [0- 1]: digital audio playback
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
 33:       : timer



	Domen


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
