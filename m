From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 0/4] ALSA: hda beep clean up
Date: Wed, 04 Jul 2012 09:43:23 +0200
Message-ID: <4FF3F41B.2050107@perex.cz>
References: <1341331397-21182-1-git-send-email-tiwai@suse.de>
	<4FF31E7B.8030906@perex.cz> <4FF34FA9.10806@perex.cz>
	<s5h62a45cms.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	by alsa0.perex.cz (Postfix) with ESMTP id EE47C2444D
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jul 2012 09:41:49 +0200 (CEST)
In-Reply-To: <s5h62a45cms.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Date 4.7.2012 07:16, Takashi Iwai wrote:
> At Tue, 03 Jul 2012 22:01:45 +0200,
> Jaroslav Kysela wrote:
>>
>> Date 3.7.2012 18:31, Jaroslav Kysela wrote:
>>> Date 3.7.2012 18:03, Takashi Iwai wrote:
>>>> Hi,
>>>>
>>>> this is a series of small cleanups of HD-audio beep code.
>>>> Since the keyboard driver already handles the simultaneous outputs
>>>> from the multiple input beep instances, there is no merit to have
>>>> beep_mode=2 option to switch the beep input device.
>>>
>>> Acked-by: Jaroslav Kysela <perex@perex.cz>
>>
>> While I acked this, I vaguely remember now, that the event duplication
>> (simultaneous outputs) caused some issues on some Lenovo notebooks.
>>
>> When the pcspkr and HDA beep generator is connected to the same output
>> (integrated speakers), it may cause some issues (bad beep quality -
>> frequency etc.).
>>
>> I looked to the input code, and the kd_mksound() calls
>> input_handler_for_each_handle(), thus the event is duplicated to all
>> beep generators, right?
> 
> Right.
> 
>> The beep_mode=2 was introduced to let users to help with this issue with
>> a comfortable way.
> 
> Not really.  At the time this was introduced, the keyboard driver took
> only a single input handle exclusively, namely only the last
> registered one.  Thus playing on both had never happened until
> recently.

OK, thanks for the clarification. The question is, if it's the desired
behaviour. Multiple outs can cause some harmonic effects. It would be
nice, if the input layer can turn on/off (filter) the beep events at
runtime separately for all registered drivers. The setup can be handled
using sysfs or so..

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
