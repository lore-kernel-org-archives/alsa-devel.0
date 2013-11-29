From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [RFC] ALSA: add new alsa control byte extended
Date: Fri, 29 Nov 2013 11:10:43 +0100
Message-ID: <52986823.1050600@perex.cz>
References: <1385699397-18662-1-git-send-email-vinod.koul@intel.com>	<s5hbo13fy6c.wl%tiwai@suse.de>	<20131129074459.GE8834@intel.com>	<s5hzjoneft5.wl%tiwai@suse.de>	<52986123.5040004@perex.cz>
 <s5hsiufedxu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F84A265558
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2013 11:10:44 +0100 (CET)
In-Reply-To: <s5hsiufedxu.wl%tiwai@suse.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Date 29.11.2013 10:48, Takashi Iwai wrote:
> At Fri, 29 Nov 2013 10:40:51 +0100,
> Jaroslav Kysela wrote:
>>
>> Date 29.11.2013 10:08, Takashi Iwai wrote:
>>> At Fri, 29 Nov 2013 13:14:59 +0530,
>>> Vinod Koul wrote:
>>>>
>>>> On Fri, Nov 29, 2013 at 08:46:03AM +0100, Takashi Iwai wrote:
>>>>> At Fri, 29 Nov 2013 09:59:57 +0530,
>>>>> Vinod Koul wrote:
>>>>>>
>>>>>> As discussed in the last Audio uConf we need to improve byte controls to allow
>>>>>> larger size data to be sent to DSPs  The modern DSPs require alsa byte controls
>>>>>> size which far exceeds the today 512bytes limit. In order for usermode to send
>>>>>> larger sizes (few 100s of KBs) along with size information we add extended byte
>>>>>> control interface which sends any size bytes parameter buffer for DSPs to use
>>>>>> Obviosly the size must be supported by the device and would be required to
>>>>>> inform the max size allowed for the control.
>>>>>
>>>>> My primary question is -- must this be a control element?
>>>> I think yes. With controls we have an easy way to send parameter bytes and a
>>>> good support from both kernel and usermode, so leveraging that would make sense.
>>>
>>> But it means that we have to extend / fix allover places using the
>>> control elements.  And the variable size isn't handled there, so far.
>>> It's the biggest concern.
>>>
>>> For example, how would you read such a control element?  Currently,
>>> all the control element values have the same static size, so the data
>>> is just there to read.  OTOH, if you read data with an unknown size,
>>> you have to query the size at first, allocate the buffer, then read
>>> the data.  It's a completely different flow.
>>>
>>>> Mostly here the limit of 512 is hitting folks and IMO arbitrarily increasing
>>>> size doesn't help. For DSPs the algorithm coefficients can be larger 
>>>
>>> Well, it's basically a kind of abuse of control elements, IMO...
>>
>> I basically agree, but... I believe that these chunks can be divided to
>> the 512 limit using continuous indexes (kcontrol->count) and a simple
>> rule in the driver "write all to a DSP when the last control (index) is
>> touched" may be enough. No API extensions are required. The question is:
>> Do you rellay need 100+KB for coefficients? Do you expect to handle
>> these data in standard tools like alsactl?
> 
> Yeah, I suggested a similar workaround when the issue came up ago
> (IIRC, it was about WM codecs).  But it's certainly ugly, indeed.

I wouldn't mark it as ugly, because the overhead is small in this
solution (except the allocated space for the whole message in the hw
driver). But if these large data are static and they are not expected to
be saved (alsactl), the control API may be extended using a new ioctl or
the hwdep interface with some custom tools may be used.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
