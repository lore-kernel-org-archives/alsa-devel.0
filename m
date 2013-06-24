From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 2/2] ALSA: hda - get realtime ELD info when
 codec suspended
Date: Mon, 24 Jun 2013 14:47:01 +0200
Message-ID: <51C83FC5.3090005@canonical.com>
References: <1372074324-13563-1-git-send-email-xingchao.wang@linux.intel.com>
 <1372074324-13563-2-git-send-email-xingchao.wang@linux.intel.com>
 <s5hmwqfvizc.wl%tiwai@suse.de>
 <46B810F6945F7C4788E11DCE57EC489011833B68@SHSMSX104.ccr.corp.intel.com>
 <s5hk3ljvhu2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id E43D426257D
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2013 14:47:04 +0200 (CEST)
In-Reply-To: <s5hk3ljvhu2.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Wang,
 Xingchao" <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

On 06/24/2013 02:00 PM, Takashi Iwai wrote:
> At Mon, 24 Jun 2013 11:56:21 +0000,
> Wang, Xingchao wrote:
>>
>>> -----Original Message-----
>>> From: Takashi Iwai [mailto:tiwai@suse.de]
>>> Sent: Monday, June 24, 2013 7:36 PM
>>> To: Wang Xingchao
>>> Cc: alsa-devel@alsa-project.org; Wang, Xingchao
>>> Subject: Re: [PATCH 2/2] ALSA: hda - get realtime ELD info when codec
>>> suspended
>>>
>>> At Mon, 24 Jun 2013 07:45:24 -0400,
>>> Wang Xingchao wrote:
>>>>
>>>> when controller/codec in runtime suspended mode, monitor hotplug would
>>>> not trigger unsolicited event.

And here's the original problem IMO: If you can't detect plug/unplug in 
runtime suspend mode, the runtime suspend mode is broken. Userspace 
relies on getting notification when a HDMI/DP connection is 
plugged/unplugged. If no unsol event is triggered, how is userspace 
notified?

This patch tries to power up codec and
>>>> hdmi driver would probe ELD info again.
>>>
>>> I don't know whether this is the wanted behavior.
>>> The proc file is supposed to read the driver's status, not to trigger anything.
>>>
>>
>> I explained in another mail what the patch fix. In the real case, when HDMI monitor removed,
>> Eld# still hold monitor information because the codec/controller is in suspend mode atm and has no chance to refresh eld.
>
> And this is no bug, per se.  The proc file shows the driver's current
> status, not the hardware's raw status.

Well, the codec proc file shows the hardware's raw status (which 
includes powering up the codec), perhaps it would be more consistent if 
the eld proc file did the same?

>> Even when controller/codec waken up, it will not refresh eld# as gfx side hand
> led hdmi hotplut when audio driver suspended.
>
> ... and this is actually the bug.
> But, it's still unclear why the jack detection callback isn't called
> at resume.

Well, I haven't double checked, but is there anyone actually calling it? 
Just setting a jack to dirty does not cause any action in itself.

And btw, even if the proc file might show old information, we also have 
the ELD bytes ctrl, which IMO should always correctly return 0 if 
there's nothing connected.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
