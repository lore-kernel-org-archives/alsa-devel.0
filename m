From: Liam Girdwood <liam.r.girdwood@intel.com>
Subject: Re: [PATCH] topology: Add API to set a vendor specific
 version number
Date: Wed, 23 Sep 2015 10:24:22 +0100
Message-ID: <1443000262.6977.45.camel@loki>
References: <1442394433-31417-1-git-send-email-mengdong.lin@intel.com>
 <s5hio718qt2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id F18012652E1
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2015 11:25:48 +0200 (CEST)
In-Reply-To: <s5hio718qt2.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, mengdong.lin@linux.intel.com, "Koul,
 Vinod" <vinod.koul@intel.com>, mengdong.lin@intel.com, broonie@kernel.org, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

+ Vinod

On Wed, 2015-09-23 at 10:48 +0200, Takashi Iwai wrote:
> On Wed, 16 Sep 2015 11:07:13 +0200,
> mengdong.lin@intel.com wrote:
> > 
> > From: Mengdong Lin <mengdong.lin@intel.com>
> > 
> > This vendor-specific version number is optional. It will be written to
> > the 'version' field of each block header of the binary toplogy data file.
> > The vendor driver can check this number for further processing in kernel.
> > 
> > The topology ABI version number is still stored in the 'abi' field of
> > block headers.
> > 
> > Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
> > Reviewed-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> 
> Thanks, applied now.  But I have concern about topology ABI/API: have
> we stabilized it enough?  That is, are there any missing patches in
> the current kernel and alsa-lib/utils git trees that may lead to any
> API/ABI incompatibilities?

There are a couple of patches that are ABI changes afaik for PCM
config/capabilities.

Mengdong, can you point us to your latest code for alsa-lib and kernel
with the ABI updates. We can then review the final changes.

Vinod, Subhransu, please shout if there is anything missing from the
final ABI updates in Mengdongs alsa-lib/kernel branches.

Thanks

Liam

> 
> 
> Takashi


---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
