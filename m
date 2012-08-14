From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [RFC PATCH 1/1] ALSA: hda - add a timer to find
 and suspend idle codecs
Date: Tue, 14 Aug 2012 12:05:15 +0200
Message-ID: <502A22DB.5010503@canonical.com>
References: <1344967003-5470-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 63217265E1E
 for <alsa-devel@alsa-project.org>; Tue, 14 Aug 2012 11:35:29 +0200 (CEST)
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

On 08/14/2012 07:56 PM, mengdong.lin@intel.com wrote:
> From: Mengdong Lin <mengdong.lin@intel.com>
>
> This patch sets up a timer to monitor changes of the parameter 'power_save'
> and suspend any idle codecs if power save is re-enabled by the user.

Adding timers means are you adding wakeups to the CPU. That seems 
counterproductive if you're trying to save power...?

Is there no way to listen to a change event of some sort instead?

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
