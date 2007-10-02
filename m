From: James Pearson <james-p@moving-picture.com>
Subject: Re: alsa-driver-1.0.15rc2 build issues on RHEL4/CentOS4
Date: Tue, 02 Oct 2007 10:17:30 +0100
Message-ID: <47020CAA.4030101@moving-picture.com>
References: <46EA5F30.7000404@moving-picture.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moving-picture.com (mpc-26.sohonet.co.uk [193.203.82.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 05EDF2432F
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Oct 2007 11:17:30 +0200 (CEST)
Received: from minion.mpc.local ([172.16.11.112] helo=moving-picture.com)
	by moving-picture.com with esmtp (Exim 4.43) id 1Icdsg-0008An-Dl
	for alsa-devel@alsa-project.org; Tue, 02 Oct 2007 10:17:30 +0100
In-Reply-To: <46EA5F30.7000404@moving-picture.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

James Pearson wrote:
> alsa-driver-1.0.15rc2 won't build cleanly on RHEL4/CentOS4 (2.6.9 based 
> kernel).
> 
> I've included the relevant errors below after running:
> 
> configure --with-redhat
> make -i
>  
>    Building modules, stage 2.
>    MODPOST
> *** Warning: "class_device_destroy" 
> [/tmp/alsa-driver-1.0.15rc2/pci/asihpi/snd-asihpi.ko] undefined!
> *** Warning: "ac97_bus_type" 
> [/tmp/alsa-driver-1.0.15rc2/pci/ac97/snd-ac97-codec.ko] undefined!
> *** Warning: "platform_device_alloc" 
> [/tmp/alsa-driver-1.0.15rc2/drivers/snd-portman2x4.ko] undefined!
> *** Warning: "platform_device_add" 
> [/tmp/alsa-driver-1.0.15rc2/drivers/snd-portman2x4.ko] undefined!
> *** Warning: "platform_device_put" 
> [/tmp/alsa-driver-1.0.15rc2/drivers/snd-portman2x4.ko] undefined!
> *** Warning: "platform_device_alloc" 
> [/tmp/alsa-driver-1.0.15rc2/drivers/snd-mts64.ko] undefined!
> *** Warning: "platform_device_add" 
> [/tmp/alsa-driver-1.0.15rc2/drivers/snd-mts64.ko] undefined!
> *** Warning: "platform_device_put" 
> [/tmp/alsa-driver-1.0.15rc2/drivers/snd-mts64.ko] undefined!

Setting/changing the following in kconfig-vers 'fixes' the above:

SND_MTS64       2.6.10
SND_ASIHPI      2.6.10
SND_PORTMAN2X4  2.6.10
SND_CS5535AUDIO 2.6.10

(AC97_BUS is already set to 2.6.14 in rc3)

I don't know if all these build OK with 2.6.10 and above, but as 
RHEL4/CentOS4 is a 2.6.9 based kernel, then this works ...

James Pearson
