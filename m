From: Ian W MORRISON <ianwmorrison@gmail.com>
Subject: Re: [PATCH] ALSA: x86: Ensure VLV bitwise operations
 are SOC specific
Date: Sat, 11 Feb 2017 10:49:17 +1100
Message-ID: <CAFXWsS8qseFmQdNctJ_pLo3L8+xM9fFtB5--dAJdR0d1WAANvw@mail.gmail.com>
References: <CAFXWsS86Bc7LZfFzT6Wa_z1LDiZk1S2ArbOApa+dE9fmB0hdcw@mail.gmail.com>
 <1a612c8b-0b03-46b9-8129-c99d5c524b72@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yb0-f195.google.com (mail-yb0-f195.google.com
 [209.85.213.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 15429265DB7
 for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2017 00:49:19 +0100 (CET)
Received: by mail-yb0-f195.google.com with SMTP id j82so1906706ybg.2
 for <alsa-devel@alsa-project.org>; Fri, 10 Feb 2017 15:49:19 -0800 (PST)
In-Reply-To: <1a612c8b-0b03-46b9-8129-c99d5c524b72@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Jerome Anand <jerome.anand@intel.com>
List-Id: alsa-devel@alsa-project.org

On 11 February 2017 at 09:54, Pierre-Louis Bossart <
pierre-louis.bossart@linux.intel.com> wrote:

> On 2/9/17 9:33 PM, Ian W MORRISON wrote:
>
>> The function vlv_display_irq_postinstall is used by both valleyview
>> and cherryview irq handling. I915_LPE_PIPE_C_INTERRUPT is specific
>> to cherryview so should be excluded from any valleyview associated
>> bitwise operations.
>>
>
> it's a write indeed to a field that isn't defined but there is no matching
> read or action taken as a result of a write of that field. Does this solve
> a real problem or is this more to make the code more consistent?
>
>
Certainly the later and only to the point of removing any opportunities for
problems to exist for the former. In trying to diagnose the '*ERROR* Atomic
update failure on pipe X' messages in 'dmesg' it was more of a straw grasp.


>
>> Signed-off-by: Ian W Morrison <linuxium@linuxium.com.au
>> <mailto:linuxium@linuxium.com.au>>
>> ---
>>  drivers/gpu/drm/i915/i915_irq.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/i915/i915_irq.c
>> b/drivers/gpu/drm/i915/i915_irq.c
>> index f0880af..ee61808 100644
>> --- a/drivers/gpu/drm/i915/i915_irq.c
>> +++ b/drivers/gpu/drm/i915/i915_irq.c
>> @@ -2940,9 +2940,10 @@ static void vlv_display_irq_postinstall(struct
>> drm_i915_private *dev_priv)
>>
>>         WARN_ON(dev_priv->irq_mask != ~0);
>>
>> -       val = (I915_LPE_PIPE_A_INTERRUPT |
>> -               I915_LPE_PIPE_B_INTERRUPT |
>> -               I915_LPE_PIPE_C_INTERRUPT);
>> +       val = I915_LPE_PIPE_A_INTERRUPT |
>> +               I915_LPE_PIPE_B_INTERRUPT;
>> +       if (IS_CHERRYVIEW(dev_priv))
>> +               val |= I915_LPE_PIPE_C_INTERRUPT;
>>
>>         enable_mask |= val;
>>
>> --
>> 1.9.1
>>
>
>
