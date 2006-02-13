From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: using /dev/dsp to test a driver
Date: Mon, 13 Feb 2006 23:05:16 +0000
Message-ID: <1139871916.9759.26.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp2.homechoice.co.uk (sc-outsmtp2.homechoice.co.uk [81.1.65.36])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id EB0B11AC
	for <alsa-devel@alsa-project.org>; Tue, 14 Feb 2006 00:05:18 +0100 (MET)
Received: from bossclass (bossclass [192.168.62.105])
	by localhost.localdomain (8.13.4/8.13.1) with ESMTP id k1DN5GKc016763
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2006 23:05:17 GMT
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I have been unable to get the alsa-utils to work on my Dreamcast and so
I am using snd-pcm-oss and /dev/dsp to test the driver eg

cat somefile > /dev/dsp

It seems to work -- at least several of the callbacks are being
triggered (see the end of the email). Is there anything in particular I
should be aware of?

And what is the flow of execution in the driver?

If hw_params is used to allocate the DMA buffer, which call back should
I use to actually start the DMA transfer?

Thanks

Adrian

Fragment below shows open and hw_params callbacks both being called -
not sure where to go next though!

/ # cat dialog.tar.gz > /dev/dsp
ALSA /home/adrian/aica/aica/snd_card_aica.c:151: In snd_aicapcm_pcm_open
ALSA /home/adrian/aica/aica/snd_card_aica.c:176:
snd_aicapcm_pcm_hw_params
ALSA /home/adrian/aica/aica/snd_card_aica.c:179: returned
Unable to handle kernel paging request at virtual address 00007fe9
pc = 8c0fac6c
*pde = 00000000
Oops: 0001 [#1]

Pid : 1174, Comm:                  cat
PC is at memset+0x18/0x4c
PC  : 8c0fac6c SP  : 8cd33e8c SR  : 40008100 TEA : c011eb24    Not
tainted
R0  : 00000001 R1  : 00000001 R2  : 00000001 R3  : 00000008
R4  : 00007fea R5  : 00000080 R6  : 00007ffe R7  : c015b8e5
R8  : 00008000 R9  : ffffffea R10 : c015b8f4 R11 : 0000023c
R12 : 8ca42400 R13 : 8c3a30c0 R14 : 00000003
MACH: 0000024a MACL: 00040000 GBR : 00000000 PR  : c0154892

Call trace:
[<c015e27e>] snd_pcm_oss_change_params+0xe1e/0x1060 [snd_pcm_oss]
[<c015e686>] snd_pcm_oss_make_ready+0x66/0x80 [snd_pcm_oss]
[<c01618e6>] snd_pcm_oss_write+0xc6/0x2e0 [snd_pcm_oss]
[<8c063f08>] vfs_write+0x128/0x180
[<8c064034>] sys_write+0x34/0xa0
[<8c0051bc>] syscall_call+0xc/0xe
[<8c064000>] sys_write+0x0/0xa0

Segmentation fauALSA /home/adrian/aica/aica/snd_card_aica.c:187:
snd_aicapcm_pcm_prepare
lt
ALSA /home/adrian/aica/aica/snd_card_aica.c:161: In
snd_aicapcm_pcm_close




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
