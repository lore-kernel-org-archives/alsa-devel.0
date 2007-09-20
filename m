From: "J. Scott Merritt" <Scott@PragmaSoft.com>
Subject: Re: When to start the capture device?
Date: Thu, 20 Sep 2007 10:11:30 -0400
Message-ID: <20070920101130.39b76613.Scott@PragmaSoft.com>
References: <005101c7fb13$511e5040$aea4c380@dream.eng.uci.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from starfish.geekisp.com (mail.geekisp.com [216.168.135.169])
	by alsa0.perex.cz (Postfix) with ESMTP id 28F4A2443C
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Sep 2007 16:06:13 +0200 (CEST)
In-Reply-To: <005101c7fb13$511e5040$aea4c380@dream.eng.uci.edu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Sheng (Sean) Liu" <shengl@uci.edu>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 19 Sep 2007 16:17:55 -0700
"Sheng \(Sean\) Liu" <shengl@uci.edu> wrote:


> 1. The control point here the start threshold, which defines the number of
> frames of space/data necessary to start the device automatically. If set to
> some value other than zero for playback, it is necessary to prefill the
> playback buffer before the device will start. If set to zero, the first data
> written to the device (or first attempt to read from a capture stream) will
> start the device. 
>  
> My question: what does he means on " If set to zero"? Does anyone know which
> parameter of which API should be set to zero?

I believe this would be snd_pcm_sw_params_set_start_threshold.
 
> 2. You can also start the device explicitly using snd_pcm_start, but this
> requires buffer prefilling in the case of the playback stream. If you
> attempt to start the stream without doing this, you will get -EPIPE as a
> return code, indicating that there is no data waiting to deliver to the
> playback hardware buffer.
>  
> My question: Is there anything to be done before calling snd_pcm_start in
> the case of capturing stream? If there is, what are they?

I use:
   snd_pcm_open
   SetUpHwParams ()  ... /* lots of snd_pcm_hw_params_set ... calls */
   SetUpSwParams () ...  /* lots of snd_pcm_sw_params_set ... calls */
   snd_pcm_prepare
   snd_pcm_start

Best regards, Scott.
