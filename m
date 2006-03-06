From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: kernel threads etc
Date: Mon, 06 Mar 2006 22:27:41 +0000
Message-ID: <1141684061.9230.15.camel__43922.8707728491$1141684133$gmane$org@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp1.homechoice.co.uk (sc-outsmtp1.homechoice.co.uk [81.1.65.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 8B441137
	for <alsa-devel@alsa-project.org>; Mon,  6 Mar 2006 23:27:45 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: linux-sh <linuxsh-dev@lists.sourceforge.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I have an interrupt handler in my sound driver that calls this:

dreamcastcard->sleep_aicahw = 1;
wake_up_interruptible(&aicahw);


which is meant to wake up this code in a workqueue:

do{
	wait_event_interruptible(aicahw, (dreamcastcard->sleep_aicahw > 0));
	if (dreamcastcard->sleep_aicahw == 2) return; /* end of the road
signalled */
	snd_printk("The AICA is awake\n");
	/* write to the lower or upper area of the ring buffer? */
	buffer_size= frames_to_bytes(runtime, runtime->buffer_size);
	if (buffer_size > 16384) transfer_size = 16384;
	else transfer_size = buffer_size;
	err = dma_xfer(0, runtime->dma_area, 0x11000 + (dreamcastcard->upper) *
0x4000, transfer_size, 5);
	if (err) goto dma_fail;
	dreamcastcard->upper = 0;
	dreamcastcard->sleep_aicahw = 0;
} while (1);


But while I know the interrupt is being fired and trapped (cheating with
printk), I never see the "The AICA is awake" - is there something wrong
with sleeping inside a kernel thread in this way or some other foible I
should be aware of?




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
