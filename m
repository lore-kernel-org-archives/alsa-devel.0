From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] ALSA: drivers: make array 'names' const,
 reduces object code size
Date: Mon, 27 Nov 2017 07:40:07 -0800
Message-ID: <1511797207.32426.41.camel@perches.com>
References: <20171127125851.10076-1-colin.king@canonical.com>
 <5A1C2760.1030704@bfs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay.hostedemail.com (smtprelay0171.hostedemail.com
 [216.40.44.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F617266DCC
 for <alsa-devel@alsa-project.org>; Mon, 27 Nov 2017 16:40:11 +0100 (CET)
In-Reply-To: <5A1C2760.1030704@bfs.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: wharms@bfs.de, Colin King <colin.king@canonical.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2017-11-27 at 15:55 +0100, walter harms wrote:
> Am 27.11.2017 13:58, schrieb Colin King:
> > From: Colin Ian King <colin.king@canonical.com>
> > Don't populate array 'names' on the stack but instead make them static.
> > Makes the object code smaller by 50 bytes:
[]
> > diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
[]
> > @@ -830,7 +830,7 @@ static int snd_dummy_capsrc_put(struct snd_kcontrol *kcontrol, struct snd_ctl_el
> >  static int snd_dummy_iobox_info(struct snd_kcontrol *kcontrol,
> >  				struct snd_ctl_elem_info *info)
> >  {
> > -	const char *const names[] = { "None", "CD Player" };
> > +	static const char *const names[] = { "None", "CD Player" };
> >  
> >  	return snd_ctl_enum_info(info, 1, 2, names);
> >  }
> 
> nitpick: while here
>    snd_ctl_enum_info(info, 1, ARRAY_SIZE(names), names);
> 
> just my 2 cents,

True, but that seems counter style for most uses of snd_ctl_enum_info

$ git grep -w snd_ctl_enum_info | grep -v ARRAY_SIZE | wc -l
159
$ git grep -w snd_ctl_enum_info | grep ARRAY_SIZE | wc -l
10

but most of those seem to choose variable amounts of a single
array.  Here, ARRAY_SIZE seems better to me too.

For another real nitpick, please prefer "const *" over "const*"

$ git grep -P "\*\s+const\b" | wc -l
7068
$ git grep -P "\*const\b" | wc -l
1801
