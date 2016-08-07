From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 04/39] ALSA: seq: copy ioctl data from user
 space to kernel stack
Date: Sun, 7 Aug 2016 23:26:35 +0900
Message-ID: <57A7451B.4050102@sakamocchi.jp>
References: <1470563355-18368-1-git-send-email-o-takashi@sakamocchi.jp>
 <1470563355-18368-5-git-send-email-o-takashi@sakamocchi.jp>
 <c647ef16-f993-6c29-b8f0-18337ea32d4d@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id D55BA26058F
 for <alsa-devel@alsa-project.org>; Sun,  7 Aug 2016 16:26:45 +0200 (CEST)
In-Reply-To: <c647ef16-f993-6c29-b8f0-18337ea32d4d@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

On Aug 7 2016 19:15, Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> Data from user space is once copied to kernel stack, then operated and
>> copied to user space, in a consistent manner. This manner forces all ioctl
>> operations to copy the data from/to user space, even if it's read-only or
>> write-only. Thus, it has an overhead for simpler ioctl commands.
> 
> The ioctl code itself already contains information about the direction
> and size of the data to be copied (and in theory, these values are
> correct).  See dispatch_ioctl() in drivers/firewire/core-cdev.c for an
> example.

A nice idea.

_IOC_SIZE macro pick up 13 or 14 bits (architecture-dependent) in ioctl
command, which represents the size of argument. In my patch, the size of
'union ioctl_arg' is 188 (x86/x32) or 192 (x86_64) and there's enough
rest of the size field. So we can pick up the size from ioctl command by
the macro because the size represents the maximum bytes of argument for
all of sequencer ioctls.

I'll post revised version tomorrow. Thanks ;)


Takashi Sakamoto
