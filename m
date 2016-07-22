From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH] topology: Fix the missing referenced elem
 ptr when merging private data
Date: Fri, 22 Jul 2016 01:48:41 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F84BA87279@shsmsx102.ccr.corp.intel.com>
References: <1469084447-30740-1-git-send-email-mengdong.lin@linux.intel.com>
 <57913273.7010507@sakamocchi.jp> <57913B93.6070300@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 26104265312
 for <alsa-devel@alsa-project.org>; Fri, 22 Jul 2016 03:48:46 +0200 (CEST)
In-Reply-To: <57913B93.6070300@sakamocchi.jp>
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
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, "mengdong.lin@linux.intel.com" <mengdong.lin@linux.intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "Nc, Shreyas" <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Sakamoto [mailto:o-takashi@sakamocchi.jp]
> Sent: Friday, July 22, 2016 5:16 AM

> > It's better to split to two patches for the different aims.
> > Accumulating patches to log history is preferable, as long as you have
> > concrete wills to improve codes, I believe.

Okay. I split them in v2.

> >
> >> diff --git a/src/topology/data.c b/src/topology/data.c index
> >> 768fc27..397f6a5 100644
> >> --- a/src/topology/data.c
> >> +++ b/src/topology/data.c
> >> @@ -1050,6 +1050,7 @@ int tplg_copy_data(snd_tplg_t *tplg, struct
> tplg_elem *elem,
> >>  		" element '%s'\n", ref->id, elem->id);
> >>  		return -EINVAL;
> >>  	}
> >> +	ref->elem = ref_elem;
> >>
> >>  	tplg_dbg("Data '%s' used by '%s'\n", ref->id, elem->id);
> >>  	/* overlook empty private data */
> >
> > I wonder why the assignment is done in this line. This function still
> > includes some codes to return errors. In this case, it's better to
> > code the assignment in last part of the function.
> >
> > This is a public API. It's better not to touch application's objects
> > in invalid cases.
> 
> Oops. I overlooked. It's in src/topology/tplg_local.h and not a public API...
> Anyway, it's better to consider about the error cases for consistency of object
> state.

Yes. It's better to move to the end of this function, only on success.
Also fixed this in v2 series "topology: Fix for handling widgets' references"

Thanks for your review!
Mengdong
