From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH v2] drm/i915: set proper N/CTS in modeset
Date: Tue, 13 Oct 2015 15:42:57 +0200
Message-ID: <561D0A61.3090802@canonical.com>
References: <1443144972-81982-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 22094261A3B
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2015 15:42:58 +0200 (CEST)
In-Reply-To: <1443144972-81982-1-git-send-email-libin.yang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, "Yang, Libin" <libin.yang@intel.com>
List-Id: alsa-devel@alsa-project.org



On 2015-09-25 03:36, libin.yang@intel.com wrote:
> @@ -24,8 +24,18 @@
>   #ifndef _I915_COMPONENT_H_
>   #define _I915_COMPONENT_H_
>
> +/* MAX_PORT is the number of port
> + * It must be sync with I915_MAX_PORTS defined i915_drv.h
> + * 5 should be enough as only HSW, BDW, SKL need such fix.
> + */
> +#define MAX_PORTS 5
> +
>   struct i915_audio_component {
>   	struct device *dev;
> +	/**
> +	 * @aud_sample_rate: the array of audio sample rate per port
> +	 */
> +	int aud_sample_rate[MAX_PORTS];

Just a quick question as I was trying to understand the code:

aud_sample_rate seems only set and get on the i915 side, never on the 
hda side.

In short, why is this variable here, and not in e g, as a single integer 
in the intel_digital_port struct?

That way we also avoid the possibility of MAX_PORTS becoming out of sync 
with the i915 side.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
