From: "Nickolay V. Shmyrev" <nshmyrev@yandex.ru>
Subject: snd_intel8x0m and semaphore warning
Date: Wed, 05 Jan 2005 01:56:34 +0300
Message-ID: <1104879394.3516.30.camel@shadow.local>
Mime-Version: 1.0
Content-Type: text/plain
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
To: alsa-devel@lists.sourceforge.net
Cc: Sasha Khapyorsky <sashak@smlink.com>
List-Id: alsa-devel@alsa-project.org

Hi I know there was problems with sound card driver snd_intel8x0, now
very often problem is the same kind of warning with snd_intel8x0m modem
driver:

codec_semaphore: semaphore is not ready [0x1][0x701300]
codec_write 1: semaphore is not ready for register 0x54

My configuration - Toshiba A50 laptop with Fedora Core 3 from box

lspci:

0000:00:1f.6 Modem: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
AC'97 Modem Controller (rev 03) (prog-if 00 [Generic])
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at 1800 [size=256]
        I/O ports at 1480 [size=128]
        Capabilities: [50] Power Management version 2

cards:

0 [I82801DBICH4   ]: ICH - Intel 82801DB-ICH4
                     Intel 82801DB-ICH4 at 0x18080800, irq 11
1 [Modem          ]: ICH-MODEM - Intel 82801DB-ICH4 Modem
                     Intel 82801DB-ICH4 Modem at 0x1800, irq 11

I am using slmodemd-2.9.10 compiled with alsa support and when I am
dialing to ISP i have warnings above. I am not alone with that problem,
for example, see http://linux.seindal.dk/index.php?itemid=61

Could someone help me in debugging and correcting those warnings?



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
