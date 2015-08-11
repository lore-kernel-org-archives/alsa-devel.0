From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH v2 3/3] topology: A API calls to directly
 build	topology data from templates
Date: Tue, 11 Aug 2015 09:04:48 +0100
Message-ID: <1439280288.2427.5.camel@loki>
References: <1439230429-6173-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1439230429-6173-4-git-send-email-liam.r.girdwood@linux.intel.com>
 <s5htws62r6d.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id E4CFF2604D8
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2015 10:04:54 +0200 (CEST)
In-Reply-To: <s5htws62r6d.wl-tiwai@suse.de>
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
Cc: Mengdong Lin <mengdong.lin@intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2015-08-11 at 09:57 +0200, Takashi Iwai wrote:
> > @@ -34,6 +34,10 @@
> >  #define ALSA_TPLG_DIR        ALSA_CONFIG_DIR "/topology"
> >  #define ARRAY_SIZE(x) (sizeof(x) / sizeof(x[0]))
> >  
> > +#define container_of(ptr, type, member) ({                      \
> > +      const typeof( ((type *)0)->member ) *__mptr = (ptr);    \
> > +     (type *)( (char *)__mptr - offsetof(type,member) );})
> 
> This is a pretty common macro, so I prefer having it in
> include/local.h.

I'll also move ARRAY_SIZE() to local.h too since it's common.

Liam
