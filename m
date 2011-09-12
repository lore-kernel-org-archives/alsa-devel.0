From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Getting the actual HW sample rate
Date: Mon, 12 Sep 2011 22:29:46 +0200
Message-ID: <4E6E6BBA.3020904@ladisch.de>
References: <CAE3TgXHC+C6xBxD_A_qZUm8TtN0V3GBo7kKLxDkasOZ50WDH=Q@mail.gmail.com>	<4E68788D.8040306@ladisch.de>
	<CAE3TgXFj7i=H-0Z9wn5uOnhUOHnXe3wPD1MS9qZnUhjP32-0MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 587582438F
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Sep 2011 22:30:14 +0200 (CEST)
In-Reply-To: <CAE3TgXFj7i=H-0Z9wn5uOnhUOHnXe3wPD1MS9qZnUhjP32-0MA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Toy <rtoy@google.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Raymond Toy wrote:
> On Thu, Sep 8, 2011 at 1:10 AM, Clemens Ladisch <clemens@ladisch.de
> <mailto:clemens@ladisch.de>> wrote:
>
>     Add the SND_PCM_NO_AUTO_RESAMPLE flag when calling snd_pcm_open, or use
>     snd_pcm_hw_params_set_rate_resample.
>
> Some further experimentation with this has confused me.  I changed the
> sample code to call snd_pcm_hw_params_set_rate_resample with resample = 0.
>
> When I run the code without an .asoundrc (defaulting to pulse audio, I
> think), I get sample rrates : 1-192000.

The pulse plugin does not support this flag.


Regards,
Clemens
