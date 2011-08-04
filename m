From: hong zhang <henryzhang62@yahoo.com>
Subject: Has OMAP4 officially installed AIC31xx driver yet?
Date: Thu, 4 Aug 2011 14:56:53 -0700 (PDT)
Message-ID: <1312495013.47262.YahooMailClassic@web161719.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm4.bullet.mail.bf1.yahoo.com (nm4.bullet.mail.bf1.yahoo.com
	[98.139.212.163]) by alsa0.perex.cz (Postfix) with SMTP id 53DC624469
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Aug 2011 23:56:55 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Liam,
 
I am wondering if OMAP4 has officially installed AIC31xx driver or not. If yes, where can I get it? See following ,

I have one aic31xx driver but it has problems to be second sound card if use
sdp4430_snd_device = platform_device_alloc("soc-audio", -1); in sdp4430.c
omap4_snd_device = platform_device_alloc("soc-audio", 1); in omap4_panda_aic31xx.c

or 
sdp4430_snd_device = platform_device_alloc("soc-audio", 0); in sdp4430.c
omap4_snd_device = platform_device_alloc("soc-audio", 1); in omap4_panda_aic31xx.c

when mounting such as

Freeing init memory: 200K
init: ureadahead main process (796) terminated with status 5
Unable to handle kernel paging request at virtual address 72656767
pgd = dc3b4000
[72656767] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT SMP
last sysfs file: /sys/devices/virtual/block/ram11/removable
Modules linked in:
CPU: 0    Not tainted  (2.6.35.7-ctbu-5-ga320686-dirty #19)
PC is at snd_soc_info_enum_double+0x5c/0x6c
LR is at snd_ctl_elem_info_user+0xc0/0x1d8
pc : [<c0324204>]    lr : [<c0311bd0>]    psr: 80000113
sp : dc3c1d18  ip : dc3c1d30  fp : dc3c1d24
r10: dc040dc0  r9 : dc9f297c  r8 : 00000000
r7 : dcae1b80  r6 : c1105511  r5 : dc3c1d30  r4 : dc9f2800
r3 : 00000000  r2 : 72656767  r1 : 00000000  r0 : dc3c1d88
Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c53c7d  Table: 9c3b404a  DAC: 00000015

Thanks.

---Henry
