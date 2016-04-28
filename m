From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH 3/6] topology: Use generic pointer to
 realloc buffer for private data
Date: Thu, 28 Apr 2016 14:30:53 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F84BA01739@shsmsx102.ccr.corp.intel.com>
References: <cover.1461831763.git.mengdong.lin@linux.intel.com>
 <1dd0f08c152af476e3a5af48ce7de97cd759616a.1461831763.git.mengdong.lin@linux.intel.com>
 <5721CE64.4060803@perex.cz> <s5h7ffhu9bu.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 84EB326673D
 for <alsa-devel@alsa-project.org>; Thu, 28 Apr 2016 16:30:57 +0200 (CEST)
In-Reply-To: <s5h7ffhu9bu.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "mengdong.lin@linux.intel.com" <mengdong.lin@linux.intel.com>, "Shah,
 Hardik T" <hardik.t.shah@intel.com>, "Singh,
 Guneshwor O" <guneshwor.o.singh@intel.com>, "broonie@kernel.org" <broonie@kernel.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Thursday, April 28, 2016 9:55 PM
> To: Jaroslav Kysela
> Cc: mengdong.lin@linux.intel.com; alsa-devel@alsa-project.org;
> broonie@kernel.org; Girdwood, Liam R; Lin, Mengdong; Shah, Hardik T; Singh,
> Guneshwor O
> Subject: Re: [PATCH 3/6] topology: Use generic pointer to realloc buffer for
> private data
> 
> On Thu, 28 Apr 2016 10:48:36 +0200,
> Jaroslav Kysela wrote:
> >
> > Dne 28.4.2016 v 10:41 mengdong.lin@linux.intel.com napsal(a):
> > >  	priv_data_size = ref->data->size;
> > > +	elem->obj = realloc(elem->obj,
> > > +			elem->size + priv_data_size);
> > > +	if (!elem->obj)
> > > +		return -ENOMEM;
> >
> > This causes a memory leak when realloc fails. You should free the
> > original pointer when realloc() fails.
> 
> Right, and the bug (the leak) has been already present before the patch...
> 

Okay, we'll fix this. Thanks for pointing out this.

Regards
Mengdong
