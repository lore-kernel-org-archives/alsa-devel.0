From: Sudarshan Bisht <sudarshan.bisht@nokia.com>
Subject: Re: [PATCH 1/1] alsa-lib: fixed coverity reported
 issues under "FORWARD_NULL" checker.
Date: Mon, 21 Mar 2011 10:29:21 +0200
Message-ID: <1300696161.2311.14.camel@Sudarshan.research.nokia.com>
References: <1300354872-1443-1-git-send-email-sudarshan.bisht@nokia.com>
	<1300354872-1443-2-git-send-email-sudarshan.bisht@nokia.com>
	<4D81F9A7.4030007@ladisch.de>
	<1300439668.2435.1211.camel@Sudarshan.research.nokia.com>
	<4D836692.2020005@ladisch.de>
Reply-To: sudarshan.bisht@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da02.nokia.com (smtp.nokia.com [147.243.128.26])
	by alsa0.perex.cz (Postfix) with ESMTP id E68DF103856
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 09:31:08 +0100 (CET)
In-Reply-To: <4D836692.2020005@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-03-18 at 15:05 +0100, ext Clemens Ladisch wrote:
> Sudarshan Bisht wrote:
> > On Thu, 2011-03-17 at 13:08 +0100, ext Clemens Ladisch wrote:
> > > sudarshan.bisht@nokia.com wrote:
> > > > --- a/src/conf.c
> > > > +++ b/src/conf.c
> > > > @@ -3321,9 +3321,11 @@ static int snd_config_hooks_call(snd_config_t *root, snd_config_t *config, snd_c
> > > >  		snd_config_delete(func_conf);
> > > >  	if (err >= 0) {
> > > >  		snd_config_t *nroot;
> > > > -		err = func(root, config, &nroot, private_data);
> > > > -		if (err < 0)
> > > > -			SNDERR("function %s returned error: %s", func_name, snd_strerror(err));
> > > > +		if (func) {
> > > > +			err = func(root, config, &nroot, private_data);
> > > > +			if (err < 0)
> > > > +				SNDERR("function %s returned error: %s", func_name, snd_strerror(err));
> > > > +		}
> > > 
> > > The preceding "!func" and "err >= 0" checks already guarantee that
> > > func is valid.
> > 
> > But in case of "goto _err"  , "!func" and "err >= 0" are not going to be
> > checked.
> 
> "err >= 0" is checked, and in all error cases, err must be negative;
> if not, this is bug at that place and should be fixed before that goto.
> I now see that the TYPE_COMPOUND check forgets to set "err = -EINVAL;".
> 
Yes, now I got your point, and I will take care of this in all cases. 

> 
> Regards,
> Clemens
