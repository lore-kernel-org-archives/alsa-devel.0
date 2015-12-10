From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: HDMI Repoll after pm?
Date: Thu, 10 Dec 2015 13:59:59 +0100
Message-ID: <5669774F.3060709@canonical.com>
References: <56694A4F.8070104@canonical.com> <s5htwnq7hpf.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 90F1D265238
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2015 13:59:58 +0100 (CET)
In-Reply-To: <s5htwnq7hpf.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 2015-12-10 10:53, Takashi Iwai wrote:
> On Thu, 10 Dec 2015 10:47:59 +0100,
> David Henningsson wrote:
>>
>> Hi Takashi,
>>
>> A recent change in sound.git seems to have introduced some repoll after
>> pm. Is this an intentional change? I don't think it's wrong per se (it
>> stops after 6 repolls), but it breaks my hda-emu tester when "list" does
>> not return the expected input.
>
> Hm, there is no such an intended change.

After testing some more, I've found that reverting e90247f9 (Split ELD 
update code from hdmi_present_sense) fixes the issue, so it seems like 
this commit indeed contains a functional change...

>> ...notice how the last two lines are somewhat unexpected output for a
>> "list" command, but I can make my tool more robust in case you confirm
>> this is an expected change.
>
> When the list may trigger some runtime PM, the jack status report
> itself should have been present at resume in earlier version, too.
> Do you see the repoll there?

To clarify, it's not power up or power down, it's flush_delayed_work 
that runs after every hda-emu command that causes "list" to also report 
the jack status.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
