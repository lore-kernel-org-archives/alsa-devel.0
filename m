From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH - UCM 1/2] control: enable octal and
	hexadecimal parse
Date: Tue, 13 Jan 2015 18:21:32 +0000
Message-ID: <1421173292.6402.67.camel@loki>
References: <1421118039-8075-1-git-send-email-han.lu@intel.com>
 <s5ha91mipvp.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 2903C260483
 for <alsa-devel@alsa-project.org>; Tue, 13 Jan 2015 19:22:29 +0100 (CET)
In-Reply-To: <s5ha91mipvp.wl-tiwai@suse.de>
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
Cc: han.lu@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2015-01-13 at 17:53 +0100, Takashi Iwai wrote:
> At Tue, 13 Jan 2015 11:00:38 +0800,
> han.lu@intel.com wrote:
> > 
> > From: "Lu, Han" <han.lu@intel.com>
> > 
> > Signed-off-by: Lu, Han <han.lu@intel.com>
> 
> Looks good to me.  Liam, any objection for this extension?
> 

Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>

> 
> thanks,
> 
> Takashi
> 
> > 
> > diff --git a/src/control/ctlparse.c b/src/control/ctlparse.c
> > index 978977d..acaf734 100644
> > --- a/src/control/ctlparse.c
> > +++ b/src/control/ctlparse.c
> > @@ -59,10 +59,10 @@ static long get_integer(const char **ptr, long min, long max)
> >  		goto out;
> >  
> >  	s = p;
> > -	val = strtol(s, &p, 10);
> > +	val = strtol(s, &p, 0);
> >  	if (*p == '.') {
> >  		p++;
> > -		strtol(p, &p, 10);
> > +		strtol(p, &p, 0);
> >  	}
> >  	if (*p == '%') {
> >  		val = (long)convert_prange1(strtod(s, NULL), min, max);
> > @@ -87,10 +87,10 @@ static long long get_integer64(const char **ptr, long long min, long long max)
> >  		goto out;
> >  
> >  	s = p;
> > -	val = strtol(s, &p, 10);
> > +	val = strtol(s, &p, 0);
> >  	if (*p == '.') {
> >  		p++;
> > -		strtol(p, &p, 10);
> > +		strtol(p, &p, 0);
> >  	}
> >  	if (*p == '%') {
> >  		val = (long long)convert_prange1(strtod(s, NULL), min, max);
> > -- 
> > 2.1.0
> > 
