From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH 1/2] ALSA: hda - add PCI IDs for Intel
	Braswell
Date: Fri, 25 Jul 2014 01:06:39 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D19543F50@SHSMSX103.ccr.corp.intel.com>
References: <1406076938-97633-1-git-send-email-libin.yang@intel.com>
 <s5hwqb4jslx.wl%tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19543D84@SHSMSX103.ccr.corp.intel.com>
 <96A12704CE18D347B625EE2D4A099D19543F13@SHSMSX103.ccr.corp.intel.com>
 <s5hzjfynb91.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C499265728
 for <alsa-devel@alsa-project.org>; Fri, 25 Jul 2014 03:06:44 +0200 (CEST)
In-Reply-To: <s5hzjfynb91.wl%tiwai@suse.de>
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
Cc: "Lin, Mengdong" <mengdong.lin@intel.com>, "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Thursday, July 24, 2014 9:21 PM
> To: Yang, Libin
> Cc: 'alsa-devel@alsa-project.org'; Lin, Mengdong
> Subject: Re: [PATCH 1/2] ALSA: hda - add PCI IDs for Intel Braswell
> 
> At Thu, 24 Jul 2014 12:59:55 +0000,
> Yang, Libin wrote:
> >
> > Hi Takashi,
> >
> > After checking the HW, the HDMI audio codec doesn't support EPSS. If we
> force it to support runtime PM, there is risk. Besides, as the codec doesn't
> support EPSS, if we want to support runtime PM, simply add the
> AZX_DCAPS_PM_RUNTIME flag doesn't help. We must think out a method
> to ensure the driver enter pm runtime even the codec doesn't support.
> 
> Wait, is the controller for the generic codecs or dedicated to the embedded
> HDMI?  In the latter case, AZX_DCAPS_INTEL_PCM_NOPM is anyway wrong.
> For HDMI, we use different flags.

OK, I see. I will add the flags and have a test.

> 
> 
> Takashi
