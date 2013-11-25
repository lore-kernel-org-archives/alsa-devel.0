From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: HD-audio runtime PM
Date: Mon, 25 Nov 2013 07:32:57 +0100
Message-ID: <5292EF19.1040900@canonical.com>
References: <s5hli0gmyxt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 311A5261A28
 for <alsa-devel@alsa-project.org>; Mon, 25 Nov 2013 07:32:59 +0100 (CET)
In-Reply-To: <s5hli0gmyxt.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: "Lin, Mengdong" <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

On 11/22/2013 12:57 PM, Takashi Iwai wrote:
> Hi,
> 
> after my previous fix, the runtime PM seems working stably finally.
> However, there seem still some glitches:
> 
> 1. The wakeup via jack or HDMI/DP detection doesn't seem to work on my
>   test machines.  WAKEEN is set properly.  And its value can be read
>   correctly at the point of runtime resume, too.

Hi and thanks for working on this.

I've been trying to reproduce the above, but I can't seem to activate
runtime PM at all. I can't seem to get a callback to runtime_suspend,
and further investigation shows that
/sys/class/sound/card0/power/runtime_status shows "unsupported".

And this is on 3.13-rc1, and there *shouldn't* be any Ubuntu specific
stuff or configuration in that kernel.

Any ideas? (Sorry if this is a newbie question..)


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
