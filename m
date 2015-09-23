From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH] topology: Add API to set a vendor
	specific	version number
Date: Wed, 23 Sep 2015 16:13:26 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F8496790BE@SHSMSX101.ccr.corp.intel.com>
References: <1442394433-31417-1-git-send-email-mengdong.lin@intel.com>
 <s5hio718qt2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 14F1B260423
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2015 18:13:40 +0200 (CEST)
In-Reply-To: <s5hio718qt2.wl-tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "mengdong.lin@linux.intel.com" <mengdong.lin@linux.intel.com>, "Prusty,
 Subhransu S" <subhransu.s.prusty@intel.com>, "broonie@kernel.org" <broonie@kernel.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: alsa-devel-bounces@alsa-project.org
> [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Takashi Iwai
> Sent: Wednesday, September 23, 2015 4:48 PM
> To: Lin, Mengdong
> Cc: mengdong.lin@linux.intel.com; alsa-devel@alsa-project.org;
> broonie@kernel.org; Prusty, Subhransu S; Girdwood, Liam R
> Subject: Re: [alsa-devel] [PATCH] topology: Add API to set a vendor specific
> version number
> 
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
> Thanks, applied now.  But I have concern about topology ABI/API: have we
> stabilized it enough?  That is, are there any missing patches in the current
> kernel and alsa-lib/utils git trees that may lead to any API/ABI
> incompatibilities?

Thank you, Takashi.

We'll upstream some topology ABI/API change soon (in 1 or 2 weeks), for DAI & DAI links.
There will be changes in the kernel and alsa-lib.

Regards
Mengdong
> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
