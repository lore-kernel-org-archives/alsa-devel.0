From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [RFC] Fix for conflict of HDMI and SPDIF IEC958
 controls
Date: Mon, 15 Oct 2012 12:58:33 +0200
Message-ID: <507BEC59.5030804@canonical.com>
References: <s5hpq4nk9b1.wl%tiwai@suse.de> <507BE0E4.4040106@canonical.com>
 <s5hipact4wf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 84797264F13
 for <alsa-devel@alsa-project.org>; Mon, 15 Oct 2012 12:58:33 +0200 (CEST)
In-Reply-To: <s5hipact4wf.wl%tiwai@suse.de>
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

On 10/15/2012 12:18 PM, Takashi Iwai wrote:
> At Mon, 15 Oct 2012 12:09:40 +0200,
> David Henningsson wrote:
>>
>> On 10/12/2012 05:18 PM, Takashi Iwai wrote:
>>> Hi,
>>>
>>> there is a long-standing problem in HD-audio regarding IEC958
>>> controls.  When both an SPDIF and an HDMI are created on the same
>>> card (e.g. one from analog codec and one from graphics chip), the
>>> driver assigns the IEC958 controls just with new indices, 0, 1, 2...
>>>
>>> The problem is that there is no way to connect between this index and
>>> the actual PCM device.  Currently, alsa-lib HDA-Intel.conf has a fixed
>>> configuration:
>>>     spdif  -> IEC958 xxx index=0, PCM dev=1
>>>     hdmi,0 -> IEC958 xxx index=0, PCM dev=3
>>>     hdmi,1 -> IEC958 xxx index=1, PCM dev=7
>>>     hdmi,2 -> IEC958 xxx index=2, PCM dev=8
>>>     hdmi,3 -> IEC958 xxx index=3, PCM dev=9
>>>
>>> So obviously spdif and the first hdmi conflict.
>>
>> If these mixer controls need to be set to specific value for
>> playback/capture to work, why isn't this logic handled entirely in
>> kernel space in the first place?
>>
>> I e, instead of relying on alsa-lib to setup "IEC958 Playback Default"
>> correctly for us, we always do what setting "IEC958 Playback Default"
>> would have done, but in the kernel directly instead.
>
> Hm, I don't get your point.  Could you elaborate?

Never mind. I missed that the mixer control is needed to transfer IEC958 
status bit information.

I guess it would be cleaner to somehow associate this information 
transfer to the pcm device rather than the control device, but maybe 
that suggestion is 10 years late or so :-)

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
