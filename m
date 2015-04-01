From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda_intel:
 add	AZX_DCAPS_I915_POWERWELL for skl
Date: Wed, 01 Apr 2015 09:31:12 +0200
Message-ID: <551B9EC0.2060308@canonical.com>
References: <1427440204-49331-1-git-send-email-libin.yang@intel.com>
 <s5hfv8q98lm.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19622F1C@SHSMSX103.ccr.corp.intel.com>
 <s5hegoa97jj.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19622F67@SHSMSX103.ccr.corp.intel.com>
 <s5ha8yy971s.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19622F84@SHSMSX103.ccr.corp.intel.com>
 <96A12704CE18D347B625EE2D4A099D1962E18F@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 5FB1B2604FC
 for <alsa-devel@alsa-project.org>; Wed,  1 Apr 2015 09:31:15 +0200 (CEST)
In-Reply-To: <96A12704CE18D347B625EE2D4A099D1962E18F@SHSMSX103.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Yang, Libin" <libin.yang@intel.com>, 'Takashi Iwai' <tiwai@suse.de>
Cc: "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



On 2015-03-30 04:47, Yang, Libin wrote:
>  From our silicon team's comment, it seems we need power on
> the powerwell when detecting and probing the HDMI codec.
>
> For the skl case (HDMI codec is in powerwell, while controller not),
> my thinking is:
>
> 1. power on the power well
> 2. read STATESTS to determine the codec_mask
> 3. if codec is not present, power off the power well
>      and remove the flag. (seems we need a new flag)
> 4. if codec is present, we will power on the power well
>      when dealing with HDMI codec.
>
> What do you think?

Side question - do you know if it's the same for braswell? I e, the HDMI 
codec is in the powerwell but the controller is not?

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
