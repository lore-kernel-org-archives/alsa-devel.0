From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 2/2] ALSA: hda - get realtime ELD info when
 codec suspended
Date: Tue, 25 Jun 2013 11:43:28 +0200
Message-ID: <51C96640.2020103@canonical.com>
References: <1372074324-13563-1-git-send-email-xingchao.wang@linux.intel.com>
 <1372074324-13563-2-git-send-email-xingchao.wang@linux.intel.com>
 <s5hmwqfvizc.wl%tiwai@suse.de>
 <46B810F6945F7C4788E11DCE57EC489011833B68@SHSMSX104.ccr.corp.intel.com>
 <s5hk3ljvhu2.wl%tiwai@suse.de> <51C83FC5.3090005@canonical.com>
 <s5h38s7vf2v.wl%tiwai@suse.de> <51C94A80.70709@canonical.com>
 <s5hobauzkse.wl%tiwai@suse.de> <51C95CA3.7000001@canonical.com>
 <46B810F6945F7C4788E11DCE57EC4890118344E1@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BB8C26524C
 for <alsa-devel@alsa-project.org>; Tue, 25 Jun 2013 11:43:29 +0200 (CEST)
In-Reply-To: <46B810F6945F7C4788E11DCE57EC4890118344E1@SHSMSX104.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Wang, Xingchao" <xingchao.wang@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 06/25/2013 11:33 AM, Wang, Xingchao wrote:
> Hi David,
>
>
>> -----Original Message-----
>> From: alsa-devel-bounces@alsa-project.org
>> [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of David Henningsson
>> Sent: Tuesday, June 25, 2013 5:02 PM
>> To: Wang, Xingchao
>> Cc: Takashi Iwai; alsa-devel@alsa-project.org
>> Subject: Re: [alsa-devel] [PATCH 2/2] ALSA: hda - get realtime ELD info when
>> codec suspended
>>
>> On 06/25/2013 09:55 AM, Takashi Iwai wrote:
>>> At Tue, 25 Jun 2013 09:45:04 +0200,
>>> David Henningsson wrote:
>>>>> There is a low power mode that allows the jack detection, but this
>>>>> is different from the aggressive power-saving with runtime D3.
>>>>
>>>> If "aggressive power-saving with runtime D3" is the same as
>>>> AZX_DCAPS_PM_RUNTIME, this is also enabled for analog codecs
>>>> connected to a Lynx point controller.
>>>>
>>>> It looks like userspace have problems getting notifications for e g
>>>> headphone insertion on Lynx point controllers, so this is not only an
>>>> HDMI/DP problem?
>>>
>>> Yes.
>>>
>>>> Trying to read up a little on this, there seem to be an option to set
>>>> the WAKEEN register to have jack detection working even when the
>>>> controller is in D3. (refer HDA specification 4.5.9.2:
>>>> Codec Wake From System S0, Controller D3.) But it seems we do not
>>>> (yet) use this feature. Is this something that could/should be
>>>> implemented to fix the jack detection problems that seems to be
>>>> happening otherwise?
>>>
>>> It sounds feasible, at least for traditional jack detection of analog
>>> pins.  But I'm not sure whether this would help for the Intel graphics
>>> case.  Just need testing.
>>
>> Xingchao, what are your thoughts about using WAKEEN to wakeup both Lynx
>> point and Haswell HDMI?
>
> That's okay for me, I would do some test on that. do you have some test cases?
> That would help me verify them when enable WAKEEN feature.

Since we still enable the legacy jack feature through /dev/input/event*, 
the easiest way to test would probably to run evtest (which is in the 
Ubuntu repositories). Find the correct /dev/input/event file by checking 
dmesg (or just trying them one by one), then run "sudo evtest 
/dev/input/<filename>".

Now check if you get events correctly on HDMI/DP/Headphone/Mic/etc plug 
and unplug, even if the controller is runtime suspended.

Also note that WAKEEN should probably be disabled during system S3, 
because we don't want to wake up the entire computer just because 
somebody unplugs his headphone, right?

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
