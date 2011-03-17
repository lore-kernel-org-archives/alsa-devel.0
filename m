From: Sudarshan Bisht <sudarshan.bisht@nokia.com>
Subject: Re: [PATCH 1/1] alsa-lib: fixed coverity reported
 issues under "REVERSE_INULL" checker.
Date: Thu, 17 Mar 2011 16:02:31 +0200
Message-ID: <1300370551.2435.74.camel@Sudarshan.research.nokia.com>
References: <1300354087-755-1-git-send-email-sudarshan.bisht@nokia.com>
	<1300354087-755-2-git-send-email-sudarshan.bisht@nokia.com>
	<4D81F0A5.7080604@ladisch.de>
Reply-To: sudarshan.bisht@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa01.nokia.com (smtp.nokia.com [147.243.1.47])
	by alsa0.perex.cz (Postfix) with ESMTP id 96EE024391
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2011 15:04:06 +0100 (CET)
In-Reply-To: <4D81F0A5.7080604@ladisch.de>
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

On Thu, 2011-03-17 at 12:29 +0100, ext Clemens Ladisch wrote:
> sudarshan.bisht@nokia.com wrote:
> > --- a/src/control/setup.c
> > +++ b/src/control/setup.c
> > @@ -398,7 +398,7 @@ static int snd_config_get_ctl_elem_value(snd_config_t *conf,
> >  
> >  static int add_elem(snd_sctl_t *h, snd_config_t *_conf, snd_config_t *private_data)
> >  {
> > -	snd_config_t *conf;
> > +	snd_config_t *conf = NULL ;
> >  	snd_config_iterator_t i, next;
> >  	char *tmp;
> >  	int iface = SND_CTL_ELEM_IFACE_MIXER;
> > @@ -415,6 +415,7 @@ static int add_elem(snd_sctl_t *h, snd_config_t *_conf, snd_config_t *private_da
> >  	err = snd_config_expand(_conf, _conf, NULL, private_data, &conf);
> >  	if (err < 0)
> >  		return err;
> > +	assert(conf);
> >  	snd_config_for_each(i, next, conf) {
> >  		snd_config_t *n = snd_config_iterator_entry(i);
> >  		const char *id;
> 
> The last parameter of snd_config_expand() is an output parameter, and
> it is guaranteed that this parameter is set when the function succeeds.
> 
> If Coverity isn't able to derive this from the code, it might be
> defensible to add annotations to snd_config_expand() to make the
> semantics clear, but it is not acceptable to modify each caller just
> to work around shortcomings in a tool.
Ok. 
> 
> 
> Regards,
> Clemens
