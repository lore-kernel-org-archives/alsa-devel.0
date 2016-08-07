From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 04/39] ALSA: seq: copy ioctl data from
	user	space to kernel stack
Date: Sun, 7 Aug 2016 12:15:02 +0200
Message-ID: <c647ef16-f993-6c29-b8f0-18337ea32d4d@ladisch.de>
References: <1470563355-18368-1-git-send-email-o-takashi@sakamocchi.jp>
 <1470563355-18368-5-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id E9A67265B8F
 for <alsa-devel@alsa-project.org>; Sun,  7 Aug 2016 12:16:38 +0200 (CEST)
In-Reply-To: <1470563355-18368-5-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> Data from user space is once copied to kernel stack, then operated and
> copied to user space, in a consistent manner. This manner forces all ioctl
> operations to copy the data from/to user space, even if it's read-only or
> write-only. Thus, it has an overhead for simpler ioctl commands.

The ioctl code itself already contains information about the direction
and size of the data to be copied (and in theory, these values are
correct).  See dispatch_ioctl() in drivers/firewire/core-cdev.c for an
example.


Regards,
Clemens
