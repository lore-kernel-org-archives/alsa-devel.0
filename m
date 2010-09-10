From: Felix Homann <fexpop@web.de>
Subject: Re: [PATCH] ALSA: usb-audio: Assume first
 control	interface is for audio
Date: Fri, 10 Sep 2010 19:15:25 +0200
Message-ID: <4C8A67AD.5040309@web.de>
References: <1283418795-3319-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vwp5738.webpack.hosteurope.de (vwp5738.webpack.hosteurope.de
	[83.169.30.203]) by alsa0.perex.cz (Postfix) with ESMTP id 3234C24534
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 19:15:24 +0200 (CEST)
In-Reply-To: <1283418795-3319-1-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks,

that's very useful for the mixer in the Fast Track Ultra!

Am 02.09.2010 11:13, schrieb Daniel Mack:
> +	/*
> +	 * For devices with more than one control interface, we assume the
> +	 * first contains the audio controls. We might need a more specific
> +	 * check here in the future.
> +	 */
> +	if (!chip->ctrl_intf)
> +		chip->ctrl_intf = alts;
>
>   	if (err>  0) {
>   		/* create normal USB audio interfaces */
>
