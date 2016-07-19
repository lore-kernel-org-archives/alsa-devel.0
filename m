From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH 3/3] topology: Check address and length
 before string copy
Date: Tue, 19 Jul 2016 15:10:30 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F84BA85170@shsmsx102.ccr.corp.intel.com>
References: <cover.1468917665.git.mengdong.lin@linux.intel.com>
 <d19561c620efa5ed81692a7441b8fa7354a800d4.1468917665.git.mengdong.lin@linux.intel.com>
 <578DF6A7.5050806@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 072C22691C3
 for <alsa-devel@alsa-project.org>; Tue, 19 Jul 2016 17:11:07 +0200 (CEST)
In-Reply-To: <578DF6A7.5050806@sakamocchi.jp>
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
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, "mengdong.lin@linux.intel.com" <mengdong.lin@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Sakamoto [mailto:o-takashi@sakamocchi.jp]
> Sent: Tuesday, July 19, 2016 5:45 PM
> To: mengdong.lin@linux.intel.com; alsa-devel@alsa-project.org;
> broonie@kernel.org
> Cc: tiwai@suse.de; Girdwood, Liam R; Lin, Mengdong
> Subject: Re: [PATCH 3/3] topology: Check address and length before string
> copy
> 
> Hi,
> 
> On Jul 19 2016 17:52, mengdong.lin@linux.intel.com wrote:
> > From: Mengdong Lin <mengdong.lin@linux.intel.com>
> >
> > Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
> 
> The cover letter addresses this patch fixes a compiler warning. In this case,
> it's better to write the message in commit message, I think. Like:
> http://mailman.alsa-project.org/pipermail/alsa-devel/2016-July/110097.ht
> ml
> 
> This is not just from my taste. Maintainers prefer. At least, blank commit
> messages are not preferrable in general.

Yes, that would be better. I'll fix this in v2 tomorrow.

Thanks
Mengdong

> 
> > diff --git a/src/topology/tplg_local.h b/src/topology/tplg_local.h
> > index 4d79aa7..cfde4cc 100644
> > --- a/src/topology/tplg_local.h
> > +++ b/src/topology/tplg_local.h
> > @@ -253,6 +253,9 @@ struct tplg_elem*
> tplg_elem_new_common(snd_tplg_t
> > *tplg,
> >
> >   static inline void elem_copy_text(char *dest, const char *src, int len)
> >   {
> > +	if (!dest || !src || !len)
> > +		return;
> > +
> >   	strncpy(dest, src, len);
> >   	dest[len - 1] = 0;
> >   }
> 
> 
> Regards
> 
> Takashi Sakamoto
