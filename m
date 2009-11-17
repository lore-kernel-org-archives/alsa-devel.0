From: Michael Domanski <mx.mixer@gmail.com>
Subject: when i plugin my headphone the sound come out from
	speaker and headphone
Date: Tue, 17 Nov 2009 15:56:37 +0000
Message-ID: <cde6b8770911170756h38fd510bpc740338cc971f7bb@mail.gmail.com>
Reply-To: Mx.MixeR@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel-request@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

When I plugin my headphone the sound come out from speaker and headphone.
The speaker and headphone working in the same time.
I want my speaker to mute when headphone is plugged.

http://www.alsa-project.org/db/?f=841de9447634e7e35ae0171f968c70de253259af

mixer@mdomansky ~ $ sudo lspci |grep -i "multi\|audio\|040[0-3]"
00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio
Controller (rev 03)

mixer@mdomansky ~ $ sudo rmmod snd-hda-intel
mixer@mdomansky ~ $ sudo modprobe snd-hda-intel model=hp
WARNING: Deprecated config file /etc/modprobe.conf, all config files belong
into /etc/modprobe.d/.
WARNING: All config files need .conf: /etc/modprobe.d/alsa, it will be
ignored in a future release.

mixer@mdomansky ~ $ cat /proc/asound/cards
 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0x92400000 irq 22

mixer@mdomansky ~ $ speaker-test -c2 -D hw:0,0 -t wav -l1
^^^^^ sounds ok ^^^^^^






-- 
Sincerely,
Michael
+7 904 512 59 36
MasterWeb.PRO
