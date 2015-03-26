From: "Yang, Libin" <libin.yang@intel.com>
Subject: Add AZX_DCAPS_I915_POWEREWELL on SKL is OK?
Date: Thu, 26 Mar 2015 05:40:20 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D1962288A@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 6254226065A
 for <alsa-devel@alsa-project.org>; Thu, 26 Mar 2015 06:40:25 +0100 (CET)
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Is it OK to add AZX_DCAPS_I915_POWEREWELL for SKL in hda_intel.c?

SKL HDA controller is not in powerwell domain. But its 
HDMI codec is in the domain. My understanding is if the flag
is added here, it means the controller is in the domain. But I can't
find a good place to add a flag to indicate the HDMI codec need
the power domain.

Regards,
Libin
