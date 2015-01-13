From: "Lu, Han" <han.lu@intel.com>
Subject: Re: [PATCH - UCM 1/2] control: add hexadecimal parse
Date: Tue, 13 Jan 2015 03:02:02 +0000
Message-ID: <B51200AC81AB024499A3C2C9A1BB90A8336E84@SHSMSX101.ccr.corp.intel.com>
References: <1421040077-3494-1-git-send-email-han.lu@intel.com>
 <s5hzj9o1lqn.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id DE5E8261469
 for <alsa-devel@alsa-project.org>; Tue, 13 Jan 2015 04:02:25 +0100 (CET)
In-Reply-To: <s5hzj9o1lqn.wl-tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

BR,
Han Lu

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Monday, January 12, 2015 3:50 PM
> To: Lu, Han
> Cc: alsa-devel@alsa-project.org
> Subject: Re: [PATCH - UCM 1/2] control: add hexadecimal parse
> 
> At Mon, 12 Jan 2015 13:21:16 +0800,
> han.lu@intel.com wrote:
> >
> > From: "Lu, Han" <han.lu@intel.com>
> >
> > Signed-off-by: Lu, Han <han.lu@intel.com>
> >
> > diff --git a/src/control/ctlparse.c b/src/control/ctlparse.c index
> > 978977d..92e2f95 100644
> > --- a/src/control/ctlparse.c
> > +++ b/src/control/ctlparse.c
> > @@ -59,7 +59,10 @@ static long get_integer(const char **ptr, long min,
> long max)
> >  		goto out;
> >
> >  	s = p;
> > -	val = strtol(s, &p, 10);
> > +	if (*p == '0' && (*(p+1) == 'x' || *(p+1) == 'X'))
> > +		val = strtol(s, &p, 16);
> > +	else
> > +		val = strtol(s, &p, 10);
> 
> Just pass 0 to the base of strtol() instead of 10.  That'll do everything.
> 
Thank you, I have validated it and resend the patch.
> 
> Takashi
