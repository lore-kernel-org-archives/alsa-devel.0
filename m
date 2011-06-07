From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: Issues with HDSPM
Date: Tue, 07 Jun 2011 09:05:14 +0200
Message-ID: <4DEDCDAA.7050404@drcomp.erfurt.thur.de>
References: <20110606210425.0a4c2901@revell.mafea.no-ip.org>
	<20110607063305.GE17989@ltw.loris.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [85.14.220.160])
	by alsa0.perex.cz (Postfix) with ESMTP id E622924337
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jun 2011 09:05:31 +0200 (CEST)
In-Reply-To: <20110607063305.GE17989@ltw.loris.tv>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andre Schramm <andre.schramm@iosono-sound.com>
Cc: alsa-devel@alsa-project.org, fredrik.lingvall@gmail.com
List-Id: alsa-devel@alsa-project.org

On 06/07/2011 08:33 AM, Adrian Knoth wrote:

>> We're using CentOS 5 with 2.6.33.9-rt31.64.el5rt and ALSA 1.0.24
>> When switching to a PCI version of the card, the kernel completely
>> crashes on boot.

I just noticed that the driver in the 1.0.24 release tarball doesn't
contain the latest fixes we already have in the git repo.

I reckon the PCI version has an "unknown" revision ID. We added a
default case a couple of month ago to prevent the kernel from crashing:

	default:
		snd_printk(KERN_ERR "HDSPM: unknown firmware revision %x\n",
				hdspm->firmware_rev);
		return -ENODEV;
	}

I suggest you use this file instead of the 1.0.24 tarball:


http://git.alsa-project.org/?p=alsa-kernel.git;a=blob_plain;f=sound/pci/rme9652/hdspm.c;hb=HEAD

If you send me the revision ID of your PCI MADI card, I'll come up with
a patch.


HTH
