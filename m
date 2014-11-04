From: Liam Girdwood <liam.r.girdwood@intel.com>
Subject: Re: [PATCH v2 0/5] ASoC: Intel: ACPI support and
 machines
Date: Tue, 04 Nov 2014 09:15:10 +0000
Message-ID: <1415092510.7168.9.camel@loki>
References: <1415079068-4979-1-git-send-email-vinod.koul@intel.com>
 <545889C4.5000509@linux.intel.com> <20141104082510.GC1870@intel.com>
 <545896DE.4030305@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D186D2605F2
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 10:15:34 +0100 (CET)
In-Reply-To: <545896DE.4030305@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Jarkko Nikula <jarkko.nikula@linux.jf.intel.com>, lgirdwood@gmail.com, tiwai@suse.de, broonie@kernel.org, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2014-11-04 at 11:05 +0200, Jarkko Nikula wrote:
> Hi
> 
> On 11/04/2014 10:25 AM, Vinod Koul wrote:
> > On Tue, Nov 04, 2014 at 10:09:40AM +0200, Jarkko Nikula wrote:
> >>
> >> I think there is need to have some consolidation with current
> >> byt-rt5640 and byt-max98090. Since existing drivers and this set are
> >> using the same ACPI IDs "80860F28" for the ADSP and "10EC5640" codec
> >> ACPIID for the machine driver probing these drivers won't work
> >> together.
> > Liam's suggestion was to remove the current driver when all the bits are
> > upstream

I think we need to keep the original driver around a bit longer until
the new driver is stable on rambi and other platforms the old driver
supports atm. A that point we can depricate the original driver with a
view to eventual removal.

> Yeah, I'm not against it but we must avoid regressions and perhaps try 
> to do seamless handover if possible. It's always more nice to find 
> regression in a small than big patch when bisecting :-)
> 

Liam

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
