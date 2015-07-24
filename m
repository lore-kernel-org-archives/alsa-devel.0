From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH v1] ALSA: hda- Add headset mic pin quirk
 for a Dell device
Date: Fri, 24 Jul 2015 09:15:07 +0200
Message-ID: <55B1E5FB.1080702@canonical.com>
References: <1437713442-6061-1-git-send-email-woodrow.shen@canonical.com>
 <s5hio9avyen.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 134C726056B
 for <alsa-devel@alsa-project.org>; Fri, 24 Jul 2015 09:15:07 +0200 (CEST)
In-Reply-To: <s5hio9avyen.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, woodrow.shen@canonical.com
Cc: alsa-devel@alsa-project.org, 1475553@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org



On 2015-07-24 08:54, Takashi Iwai wrote:
> On Fri, 24 Jul 2015 06:50:42 +0200,
> woodrow.shen@canonical.com wrote:
>>
>> From: Woodrow Shen <woodrow.shen@canonical.com>
>>
>> Fix the headset mic that will not work on Dell desktop machine.
>> BugLink: https://bugs.launchpad.net/bugs/1475553
>> Signed-off-by: Woodrow Shen <woodrow.shen@canonical.com>
>
> I have repeatedly received patches with the very same subject and with
> the very similar content but without further explanation.  It's too
> confusing.
>
> Please look through the git commit history of this file, and re-read
> your patch.  Then, consider a more useful subject / description, and
> resubmit the patch.

Hi Takashi,

We're doing enablement of machines and several of them need pin quirks 
in order to have the headset mic working. Since these machines are 
pre-release, we are not allowed to make the final name of the machine 
public (e g, "Dell XPS 13"). For the same reason, we cannot give you 
alsa-info either.

Given this constraint, how do you suggest we improve the subject / 
description? Or should we wait to submit upstream until the machine has 
been released to the market?

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
