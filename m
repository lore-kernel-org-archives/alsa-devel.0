From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 0/3] Make HDMI ELD usable with hotplug
Date: Mon, 18 Feb 2013 14:50:49 +0100
Message-ID: <512231B9.6000408@canonical.com>
References: <1361193073-7199-1-git-send-email-david.henningsson@canonical.com>
 <s5h4nh9hhi6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C8E926506E
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2013 14:50:50 +0100 (CET)
In-Reply-To: <s5h4nh9hhi6.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, fengguang.wu@intel.com, pierre-louis.bossart@linux.intel.com, Wang Xingchao <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

On 02/18/2013 02:35 PM, Takashi Iwai wrote:
> At Mon, 18 Feb 2013 14:11:10 +0100,
> David Henningsson wrote:
>>
>> I'm experimenting with using ELD information in PulseAudio and found
>> that it didn't work very well with hotplugging.
>> Neither the proc file nor the ELD kcontrol was cleared correctly after
>> unplug, and there was no way (except polling) to find out when ELD
>> has become available.
>
> Did you try Xingchao's patch for drm/i915?  It's queued in
> drm-intel-next:
>
>      commit 7b9f35a6dd72f89452c58bbdbaf063027bf857ec
>      Author: Wang Xingchao <xingchao.wang@intel.com>
>      Date:   Tue Jan 22 23:25:25 2013 +0800
>
>      drm/i915: HDMI/DP - ELD info refresh support for Haswell

Thanks for the hint. I'm currently developing not on a Haswell machine, 
but an (I think) Arrandale that I bought a few years ago. So I guess 
this patch does not have any effect on my hw?


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
