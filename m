From: Rudolf Marek <r.marek@sh.cvut.cz>
Subject: Re: [PATCH] ESS Solo1 IRQ issue take 2
Date: Sat, 22 Oct 2005 22:32:58 +0200
Message-ID: <435AA1FA.5070007@sh.cvut.cz>
References: <20051010085543.GB2369@elf.ucw.cz>	<20051010094629.12123.qmail@desitka.sh.cvut.cz> <s5hachha6j6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hachha6j6.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, pavel@suse.cz
List-Id: alsa-devel@alsa-project.org

>>I tried to disable the DMA crt on the soundcard in suspend routine
>>but it wont help. Perhaps userspace process is stopped and is not
>>delivering new data?! Will pci_disable_device also disable the DMA?
> 
> 
> No, you have to stop the stream explicitly in suspend.
> The following patch should fix this problem.

Hello,

Sorry for the delay. I tried the patch but still it is the same. The notebook is 333MHz, so
maybe userspace processes are stopped and it takes time before the drivers are stopped too?

Any other ideas?

Regards

Rudolf


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
