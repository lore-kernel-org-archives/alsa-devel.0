From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH v2 1/2] ASoC: core: Add API to use DMI name
 in sound card long name
Date: Mon, 09 Jan 2017 11:13:54 +0000
Message-ID: <1483960434.2570.51.camel@loki>
References: <cover.1483418875.git.mengdong.lin@linux.intel.com>
 <0827a46b8200cc3e053f8fc6b3b428eac90a3618.1483418875.git.mengdong.lin@linux.intel.com>
 <1483454417.4555.2.camel@loki>
 <F46914AEC2663F4A9BB62374E5EEF8F881A13073@shsmsx102.ccr.corp.intel.com>
 <1483471712.4063.17.camel@loki>
 <984e6c66-c1c9-c37b-f6b6-d357cd967d48@intel.com>
 <586C9E54.60201@linux.intel.com> <1483566423.2629.17.camel@loki>
 <586F3417.1010405@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 73A84266CC5
 for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2017 12:13:58 +0100 (CET)
In-Reply-To: <586F3417.1010405@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "Lin, Mengdong" <mengdong.lin@intel.com>, "Koul, Vinod" <vinod.koul@intel.com>, "broonie@kernel.org" <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2017-01-06 at 14:07 +0800, Mengdong Lin wrote:
> 
> On 01/05/2017 05:47 AM, Liam Girdwood wrote:
> > On Wed, 2017-01-04 at 15:03 +0800, Mengdong Lin wrote:
> >>
> >> On 01/04/2017 04:09 AM, Pierre-Louis Bossart wrote:
> 
> >> So we'll keep the manufacturer name.
> >>
> >> And let's put the "Product version" as well if available, Liam?
> >
> > Yes, lets keep the manufacturer name. I agree with Pierre in that we
> > dont want meaningless directories names.
> 
> Okay. Thanks for your confirmation!
> 
> > Creating a directory structures
> > like
> >
> > 1) manufacturer/product/board OR
> > 2) manufacturer/product OR
> > 3) manufacturer/board
> >
> > (2 or 3 if board or product is NULL)
> >
> > are fine by me and make finding the correct card simpler. You could even
> > replace the . with / in your longname to save the string conversion
> > later on.
> >
> > Liam
> 
> May we keep the flat directory structure for UCM files?

This may lead to really long file names and a very crowded master
directory.

> 
> For the same manufacturer, its DMI vendor name could change, e.g. "Intel 
> Inc." or "Intel Corporation". In addition, there may be changes caused 
> by using upper case or low case characters. Since we don't want to 
> maintain a mapping table and just do verbatim copy of DMI info, it's 
> hard to group all the products/boards of one manufacturer into one UCM 
> directory. So I feel it may be better to keep the simple flat directory 
> structure.

This wont matter if we have > 1 directory for Intel or Dell etc, as it's
obvious in the naming. No mapping needed.

Liam

> 
> Thanks
> Mengdong
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
