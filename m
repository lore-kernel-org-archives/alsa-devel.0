From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/1] alsa-lib: fixed coverity reported
 issues under "REVERSE_INULL" checker.
Date: Thu, 17 Mar 2011 12:29:41 +0100
Message-ID: <4D81F0A5.7080604@ladisch.de>
References: <1300354087-755-1-git-send-email-sudarshan.bisht@nokia.com>
	<1300354087-755-2-git-send-email-sudarshan.bisht@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 92BD210382C
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2011 12:28:05 +0100 (CET)
In-Reply-To: <1300354087-755-2-git-send-email-sudarshan.bisht@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: sudarshan.bisht@nokia.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

sudarshan.bisht@nokia.com wrote:
> --- a/src/control/setup.c
> +++ b/src/control/setup.c
> @@ -398,7 +398,7 @@ static int snd_config_get_ctl_elem_value(snd_config_t *conf,
>  
>  static int add_elem(snd_sctl_t *h, snd_config_t *_conf, snd_config_t *private_data)
>  {
> -	snd_config_t *conf;
> +	snd_config_t *conf = NULL ;
>  	snd_config_iterator_t i, next;
>  	char *tmp;
>  	int iface = SND_CTL_ELEM_IFACE_MIXER;
> @@ -415,6 +415,7 @@ static int add_elem(snd_sctl_t *h, snd_config_t *_conf, snd_config_t *private_da
>  	err = snd_config_expand(_conf, _conf, NULL, private_data, &conf);
>  	if (err < 0)
>  		return err;
> +	assert(conf);
>  	snd_config_for_each(i, next, conf) {
>  		snd_config_t *n = snd_config_iterator_entry(i);
>  		const char *id;

The last parameter of snd_config_expand() is an output parameter, and
it is guaranteed that this parameter is set when the function succeeds.

If Coverity isn't able to derive this from the code, it might be
defensible to add annotations to snd_config_expand() to make the
semantics clear, but it is not acceptable to modify each caller just
to work around shortcomings in a tool.


Regards,
Clemens
