From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: pulseaudio module-udev-detect failure on	2.6.34-rc1
Date: Wed, 31 Mar 2010 17:50:02 +0800
Message-ID: <20100331095002.GA32638@localhost>
References: <20100331044016.GA17684@localhost> <s5htyrwbzcn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 08CF910380C
	for <alsa-devel@alsa-project.org>;
	Wed, 31 Mar 2010 11:50:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5htyrwbzcn.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lennart Poettering <lennart@poettering.net>
List-Id: alsa-devel@alsa-project.org

Takashi-san,

> I don't see this problem on 2.6.34-rc3.
> Did you change CONFIG_SYSFS_DEPRECATED* kconfig between 2.6.33 and 34?

Ah yes! Good catch!

CONFIG_SYSFS_DEPRECATED=y
CONFIG_SYSFS_DEPRECATED_V2=y

I was hoping to run the kernel on RHEL 5.4 ..

Thanks,
Fengguang
