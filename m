From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 2/2] Improve hw_params documentation
Date: Wed, 16 Nov 2011 22:20:07 +0100
Message-ID: <4EC42907.80104@ladisch.de>
References: <20111116195607.GI30602@foghorn.codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 280B324453
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 22:20:21 +0100 (CET)
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 3E38020EA1
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 16:20:17 -0500 (EST)
In-Reply-To: <20111116195607.GI30602@foghorn.codeweavers.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>, Andrew Eikum <aeikum@codeweavers.com>
List-Id: alsa-devel@alsa-project.org

Andrew Eikum wrote:
> +++ b/include/pcm.h
> @@ -44,8 +44,20 @@ extern "C" {
>
>  /** PCM generic info container */
>  typedef struct _snd_pcm_info snd_pcm_info_t;
> -/** PCM hardware configuration space container */
> +
> +/** PCM hardware configuration space container
> + *
> + *  snd_pcm_hw_params_t is an opaque structure which contains a set of possible
> + *  PCM hardware configurations. For example, a given instance might include a
> + *  range of buffer sizes, a range of period sizes, and a set of several sample
> + *  formats. Some subset of all possible combinations these sets may be valid,
> + *  but not necessarily any combination will be valid.
> + *
> + *  No validation is done by the various snd_pcm_hw_params_set* functions.

These functions do validate the value that the application is trying to set
and adjust all other dependent limits.


Regards,
Clemens
