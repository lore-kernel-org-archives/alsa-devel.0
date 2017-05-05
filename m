From: "Tang, FuweiX" <fuweix.tang@intel.com>
Subject: Re: [PATCH] topology: Fix issue in parsing routes when
 generating topology binary
Date: Fri, 5 May 2017 07:35:08 +0000
Message-ID: <4EA7469CB35F3E469BD19CD7FB228ACB950C8E@CDSMSX101.ccr.corp.intel.com>
References: <1493967122-13036-1-git-send-email-fuweix.tang@intel.com>
 <s5ha86rbwa4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FD7226687D
 for <alsa-devel@alsa-project.org>; Fri,  5 May 2017 09:35:25 +0200 (CEST)
In-Reply-To: <s5ha86rbwa4.wl-tiwai@suse.de>
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
Cc: "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "Lin,
 Mengdong" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Friday, May 5, 2017 3:25 PM
> To: Tang, FuweiX <fuweix.tang@intel.com>
> Cc: alsa-devel@alsa-project.org; liam.r.girdwood@linux.intel.com; Lin,
> Mengdong <mengdong.lin@intel.com>
> Subject: Re: [PATCH] topology: Fix issue in parsing routes when generating
> topology binary
> 
> On Fri, 05 May 2017 08:52:02 +0200,
> fuweix.tang@intel.com wrote:
> >
> > From: Fuwei Tang <fuweix.tang@intel.com>
> >
> > We missed parsing the index value, which is used as a use case
> > indicator, when processing the route objects.
> >
> > This patch fixes the bug.
> >
> > Signed-off-by: Fuwei Tang <fuweix.tang@intel.com>
> > Tested-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> > ---
> >  src/topology/dapm.c | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/src/topology/dapm.c b/src/topology/dapm.c index
> > 13aa1c4..2fa387f 100644
> > --- a/src/topology/dapm.c
> > +++ b/src/topology/dapm.c
> > @@ -381,7 +381,7 @@ done:
> >  }
> >
> >
> > -static int tplg_parse_routes(snd_tplg_t *tplg, snd_config_t *cfg)
> > +static int tplg_parse_routes(snd_tplg_t *tplg, snd_config_t *cfg, int
> > +index)
> >  {
> >  	snd_config_iterator_t i, next;
> >  	snd_config_t *n;
> > @@ -399,7 +399,7 @@ static int tplg_parse_routes(snd_tplg_t *tplg,
> snd_config_t *cfg)
> >  		elem = tplg_elem_new_route(tplg);
> >  		if (!elem)
> >  			return -ENOMEM;
> > -
> > +		elem->index = index;
> >  		line = elem->route;
> >
> >  		err = tplg_parse_line(val, line);
> > @@ -419,7 +419,8 @@ int tplg_parse_dapm_graph(snd_tplg_t *tplg,
> snd_config_t *cfg,
> >  	snd_config_iterator_t i, next;
> >  	snd_config_t *n;
> >  	int err;
> > -	const char *graph_id;
> > +	const char *graph_id, *val = NULL;
> > +	int index;
> >
> >  	if (snd_config_get_type(cfg) != SND_CONFIG_TYPE_COMPOUND) {
> >  		SNDERR("error: compound is expected for dapm graph
> definition\n");
> > @@ -436,8 +437,14 @@ int tplg_parse_dapm_graph(snd_tplg_t *tplg,
> snd_config_t *cfg,
> >  			continue;
> >  		}
> >
> > +		if (strcmp(id, "index") == 0) {
> > +			if (snd_config_get_string(n, &val) < 0)
> > +				return NULL;
> 
> This function should return an error code.

I'm sorry about that, I will do so.

Thanks
Fuwei


> 
> 
> Takashi
