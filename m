From: Chris J Arges <chris.j.arges@canonical.com>
Subject: Re: [PATCH 0/4 v7] Scarlett mixer interface inclusion
Date: Thu, 13 Nov 2014 07:01:06 -0600
Message-ID: <5464AB92.6000109@canonical.com>
References: <s5hk332svu5.wl-tiwai@suse.de>	<1415815622-31015-1-git-send-email-chris.j.arges@canonical.com>
 <s5h1tp7r4ho.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 808B526524F
 for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2014 14:01:15 +0100 (CET)
In-Reply-To: <s5h1tp7r4ho.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, robin@gareus.org, clemens@ladisch.de, th55@gmx.de, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org



On 11/13/2014 12:36 AM, Takashi Iwai wrote:
> At Wed, 12 Nov 2014 12:06:58 -0600,
> Chris J Arges wrote:
>>
>> This is v5 of the patchset to merge what Tobias Hoffman and Robin Gareus have
>> done to enable the Focusrite Scarlett mixers for use with ALSA.
> 
> Already v7? :)
> 
> I applied the patch series now to for-next branch.
> If anything is missing, let's fix on top of that.
> 
> 
> thanks,
> 
> Takashi
> 
Takashi,
Thank you for your patience and help reviewing and applying this.
--chris j arges



> 
>>
>> [v3]
>>
>> I have split the commits into hopefully a logical series. First the original
>> quirk is reverted for one model of a Scarlett device. Next an additional
>> structure is added to be able to more easily reuse usb_mixer_elem_info.
>> After this mixer functions that were useful to this code were made public.
>> Finally the last patch adds the necessary functions to make this mixer work.
>>
>> [v4]
>>
>> This version removes the per-mixer control creation functions and uses a
>> generic function based on structure data. Macros used for control addition
>> are removed and the plain function is used instead. Hardcoded text block is
>> removed and macros to define strings are used instead. Hardcoded control
>> initialization has been removed.
>>
>> [v5]
>>
>> In this version, HW saving functionality has been removed in this initial
>> patchset. Macros for function calls are removed for readability. Strings for
>> enums are created dynamically using the info structures. String lengths for
>> controls are now all SNDRV_CTL_ELEM_ID_NAME_MAXLEN in length.
>>
>> [v6]
>>
>> Removed dead variables. Made names const char * const * again. Adjusted
>> scarlett_ctl_enum_* functions to be a bit clearer. Used strlcpy where
>> appropriate. Properly free two dimensional array.
>>
>> [v7]
>>
>> Generate strings directly in enum_info function instead of dynamically
>> allocating into another array and copying. Remove unnecessary initializations,
>> kfrees and use kmalloc instead of kmalloc_array. Update comments to reflect
>> current mixer functionality.
>>
>> Chris J Arges (4):
>>   Revert "ALSA: usb-audio: Add quirk for Focusrite Scarlett
>>   ALSA: usb-audio: Add private_data pointer to usb_mixer_elem_info
>>   ALSA: usb-audio: make set_*_mix_values functions public
>>   ALSA: usb-audio: Scarlett mixer interface for 6i6, 18i6, 18i8 and
>>     18i20
>>
>>  sound/usb/Makefile         |    1 +
>>  sound/usb/mixer.c          |   34 +-
>>  sound/usb/mixer.h          |    9 +
>>  sound/usb/mixer_quirks.c   |   18 +-
>>  sound/usb/mixer_scarlett.c | 1001 ++++++++++++++++++++++++++++++++++++++++++++
>>  sound/usb/mixer_scarlett.h |    6 +
>>  sound/usb/quirks-table.h   |   51 ---
>>  7 files changed, 1044 insertions(+), 76 deletions(-)
>>  create mode 100644 sound/usb/mixer_scarlett.c
>>  create mode 100644 sound/usb/mixer_scarlett.h
>>
>> -- 
>> 2.1.3
>>
> 
