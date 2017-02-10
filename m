From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ALSA: x86: Ensure VLV bitwise operations
 are SOC specific
Date: Fri, 10 Feb 2017 16:54:00 -0600
Message-ID: <1a612c8b-0b03-46b9-8129-c99d5c524b72@linux.intel.com>
References: <CAFXWsS86Bc7LZfFzT6Wa_z1LDiZk1S2ArbOApa+dE9fmB0hdcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 6931D266D1A
 for <alsa-devel@alsa-project.org>; Fri, 10 Feb 2017 23:54:03 +0100 (CET)
In-Reply-To: <CAFXWsS86Bc7LZfFzT6Wa_z1LDiZk1S2ArbOApa+dE9fmB0hdcw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ian W MORRISON <ianwmorrison@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Jerome Anand <jerome.anand@intel.com>
List-Id: alsa-devel@alsa-project.org

On 2/9/17 9:33 PM, Ian W MORRISON wrote:
> The function vlv_display_irq_postinstall is used by both valleyview
> and cherryview irq handling. I915_LPE_PIPE_C_INTERRUPT is specific
> to cherryview so should be excluded from any valleyview associated
> bitwise operations.

it's a write indeed to a field that isn't defined but there is no 
matching read or action taken as a result of a write of that field. Does 
this solve a real problem or is this more to make the code more consistent?

>
> Signed-off-by: Ian W Morrison <linuxium@linuxium.com.au
> <mailto:linuxium@linuxium.com.au>>
> ---
>  drivers/gpu/drm/i915/i915_irq.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_irq.c
> b/drivers/gpu/drm/i915/i915_irq.c
> index f0880af..ee61808 100644
> --- a/drivers/gpu/drm/i915/i915_irq.c
> +++ b/drivers/gpu/drm/i915/i915_irq.c
> @@ -2940,9 +2940,10 @@ static void vlv_display_irq_postinstall(struct
> drm_i915_private *dev_priv)
>
>         WARN_ON(dev_priv->irq_mask != ~0);
>
> -       val = (I915_LPE_PIPE_A_INTERRUPT |
> -               I915_LPE_PIPE_B_INTERRUPT |
> -               I915_LPE_PIPE_C_INTERRUPT);
> +       val = I915_LPE_PIPE_A_INTERRUPT |
> +               I915_LPE_PIPE_B_INTERRUPT;
> +       if (IS_CHERRYVIEW(dev_priv))
> +               val |= I915_LPE_PIPE_C_INTERRUPT;
>
>         enable_mask |= val;
>
> --
> 1.9.1
