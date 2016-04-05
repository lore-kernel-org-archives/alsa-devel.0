From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH v2 6/7] topology: Add support for
	parsing	vendor tuples
Date: Tue, 5 Apr 2016 15:38:41 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F84B9B24D4@shsmsx102.ccr.corp.intel.com>
References: <cover.1459321387.git.mengdong.lin@linux.intel.com>
 <6ceb0ce804d89c8d9cac5a1c80f1364041a8590f.1459321387.git.mengdong.lin@linux.intel.com>
 <s5hvb44770c.wl-tiwai@suse.de> <5703515C.3070506@linux.intel.com>
 <s5hegakzinu.wl-tiwai@suse.de> <57037D04.20604@linux.intel.com>
 <s5hzit8xuo1.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 62F5F2612CC
 for <alsa-devel@alsa-project.org>; Tue,  5 Apr 2016 17:38:47 +0200 (CEST)
In-Reply-To: <s5hzit8xuo1.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, Mengdong Lin <mengdong.lin@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Koul,
 Vinod" <vinod.koul@intel.com>, "Shah, Hardik T" <hardik.t.shah@intel.com>, "broonie@kernel.org" <broonie@kernel.org>, "Ughreja,
 Rakesh A" <rakesh.a.ughreja@intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "Prusty,
 Subhransu S" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: alsa-devel-bounces@alsa-project.org
> [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Takashi Iwai
> Sent: Tuesday, April 05, 2016 5:38 PM
> To: Mengdong Lin
> Cc: alsa-devel@alsa-project.org; Koul, Vinod; Lin, Mengdong;
> broonie@kernel.org; Ughreja, Rakesh A; Girdwood, Liam R; Shah, Hardik T;
> Prusty, Subhransu S
> Subject: Re: [alsa-devel] [PATCH v2 6/7] topology: Add support for parsing
> vendor tuples
> 
> On Tue, 05 Apr 2016 10:53:24 +0200,
> Mengdong Lin wrote:
> >
> >
> > On 04/05/2016 02:14 PM, Takashi Iwai wrote:
> > > On Tue, 05 Apr 2016 07:47:08 +0200,
> > > Mengdong Lin wrote:
> > >>
> > >>
> > >>
> > >> On 03/30/2016 03:35 PM, Takashi Iwai wrote:
> > >>> On Wed, 30 Mar 2016 09:11:17 +0200,
> mengdong.lin@linux.intel.com
> > >>> wrote:
> > >>>>
> > >>>> +		switch (type) {
> > >>>> +		case SND_SOC_TPLG_TUPLE_TYPE_UUID:
> > >>>> +			len = strlen(value);
> > >>>> +			if (len > 16 || len == 0) {
> > >>>> +				SNDERR("error: tuple %s: invalid uuid\n", id);
> > >>>> +				goto err;
> > >>>> +			}
> > >>>> +
> > >>>> +			memcpy(tuple->uuid, value, 16);
> > >>>
> > >>> This may still overflow :)
> > >>> How about simply using elem_copy_text()?
> > >>
> > >> Sorry for the late reply.
> > >>
> > >> Would you mind me using uuid_parse() here?
> > >> It can convert an input UUID string into the binary representation.
> > >>
> > >> An UUID string link "1b4e28ba-2fa1-11d2-883f-b9a761bde3fb" is user
> > >> friendly for the text conf file. But this will add dependency on libuuid.
> > >
> > > Additional dependency is no-go, especially when the required change
> > > is so trivial.  It's just a string copy, after all.
> > >
> >
> > Maybe we can just use strncpy(dest, src, 16), assuming the strncpy
> > will not try to write a "\0" at dest[16] that may cause overflow?
> 
> You seem to think of things more complicated than needed.
> 
> Just reread your code.  What if a shorter string value is passed there to
> memcpy() call?  That's what I suggested as an overflow.

I misunderstood your point and overlooked this bug. 
I should have checked the string length at first and then use the length in the memcpy.

Thanks again
Mengdong
