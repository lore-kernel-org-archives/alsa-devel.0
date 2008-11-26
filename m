From: "Keith A. Milner" <maillist@superlative.org>
Subject: Re: Build patch failure.
Date: Wed, 26 Nov 2008 00:44:38 +0000
Message-ID: <200811260044.38978.maillist@superlative.org>
References: <200811242310.29792.maillist@superlative.org>
	<492C62E4.1090202@audioscience.com>
	<200811252353.06825.maillist@superlative.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from virtuser.com (unknown [77.92.93.3])
	by alsa0.perex.cz (Postfix) with ESMTP id 1E82624152
	for <alsa-devel@alsa-project.org>; Wed, 26 Nov 2008 01:44:42 +0100 (CET)
Received: from [82.152.152.239] (helo=asmodeus.superlative.org)
	by apollo.safeukdns.net with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69) (envelope-from <maillist@superlative.org>)
	id 1L58WG-0004xr-Js
	for alsa-devel@alsa-project.org; Wed, 26 Nov 2008 00:44:40 +0000
In-Reply-To: <200811252353.06825.maillist@superlative.org>
Content-Disposition: inline
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

On Tuesday 25 November 2008 23:53:06 Keith A. Milner wrote:
> The alsa-driver-build.git looks equivalent to the alsa-driver git repo, but
> the sound-2.6.get is HUGE (I've not finished downloading it yet so I don't
> know if it's equivalent to kmirror but I suepct it isnt.

Answering my own question, now it's finished it appears to be a complete 
kernel tree, or at least the best part of it:

bash-3.2$ ls alsa-kmirror/drivers/
accessibility  connector  gpu         lguest     net       regulator  
telephony
acpi           cpufreq    hid         macintosh  nubus     rtc        thermal
amba           cpuidle    hwmon       Makefile   of        s390       uio
ata            crypto     i2c         mca        oprofile  sbus       usb
atm            dca        ide         md         parisc    scsi       uwb
auxdisplay     dio        idle        media      parport   serial     video
base           dma        ieee1394    memstick   pci       sh         virtio
block          edac       infiniband  message    pcmcia    sn         w1
bluetooth      eisa       input       mfd        pnp       spi        watchdog
cdrom          firewire   isdn        misc       power     ssb        xen
char           firmware   Kconfig     mmc        ps3       staging    zorro
clocksource    gpio       leds        mtd        rapidio   tc

Cheers,

-- 
Keith A. Milner
