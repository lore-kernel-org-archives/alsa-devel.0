From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [RFC PATCH 1/1] ALSA: hda - add a timer to find
 and suspend idle codecs
Date: Tue, 14 Aug 2012 12:08:44 +0200
Message-ID: <502A23AC.1000405@perex.cz>
References: <1344967003-5470-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F937265E5B
 for <alsa-devel@alsa-project.org>; Tue, 14 Aug 2012 11:36:25 +0200 (CEST)
In-Reply-To: <1344967003-5470-1-git-send-email-mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@intel.com
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Date 14.8.2012 19:56, mengdong.lin@intel.com wrote:
> From: Mengdong Lin <mengdong.lin@intel.com>
> 
> (sorry, this patch is resent with title updated)
> 
> 
> This patch sets up a timer to monitor changes of the parameter 'power_save'
> and suspend any idle codecs if power save is re-enabled by the user.
> 
> A codec won't be suspended if it becomes idle when power save is disabled. And it
> will remain unsuspended if power save is enabled later but no further user
> operations comes. So a timer is used here to find and suspend such idle codecs
> when power save is re-enabled.
> 
> Now the timer has a fixed interval of 1 second.

I would prefer to create a sysfs file to track the writes rather than
using this timer hack.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
