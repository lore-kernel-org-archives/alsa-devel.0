From: "Lorenzo M. Catucci" <lorenzo@sancho.ccd.uniroma2.it>
Subject: intel8x0m doesn't work on acer tm 8000 centrino notebook
Date: Sun, 26 Dec 2004 14:10:36 +0100
Message-ID: <200412261410.36484.lorenzo@sancho.ccd.uniroma2.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Subject says it all, I tried both in-kernel (2.6.10) alsa drivers and 
1.0.8rc1, and I'm still getting those dreaded

Dec 26 13:54:21 ronzinante kernel:
   ALSA /mnt/virtuals/uml/alsa-driver-1.0.8rc1/alsa-kernel/pci/intel8x0m.c:402:
   codec_semaphore: semaphore is not ready [0x1][0x701300]
Dec 26 13:54:21 ronzinante kernel:
   ALSA /mnt/virtuals/uml/alsa-driver-1.0.8rc1/alsa-kernel/pci/intel8x0m.c:417:
   codec_write 1: semaphore is not ready for register 0x54

syslog messages when trying to use slmodem:

# slmodemd --alsa modem:1
SmartLink Soft Modem: version 2.9.10 Nov 27 2004 16:36:26
symbolic link `/dev/ttySL0' -> `/dev/pts/3' created.
modem `modem:1' created. TTY is `/dev/pts/3'
Use `/dev/ttySL0' as modem device, Ctrl+C for termination.

on the minicom console I try 

ati2
SmartLink Soft Modem, 2.9.10
Smart Link Ltd.
OK

and then 
atdt 06 555 5555
NO DIALTONE

and the above mentioned messages in syslog.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
