From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH] V3,
	Convert bitfields in ASOC into full int width
Date: Wed, 23 Jul 2008 17:24:26 -0400
Message-ID: <9e4733910807231424q17db32bcvbb751b13cf862fef@mail.gmail.com>
References: <20080723195644.24806.52051.stgit@terra>
	<20080723211215.GA9895@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 0614D2484D
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jul 2008 23:24:27 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so1166602ywk.2
	for <alsa-devel@alsa-project.org>; Wed, 23 Jul 2008 14:24:26 -0700 (PDT)
In-Reply-To: <20080723211215.GA9895@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 7/23/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Jul 23, 2008 at 03:56:44PM -0400, Jon Smirl wrote:
>  > Convert bitfields in ASOC into full int width. This is a
>  > simple mechanical conversion. Two places in the DAPM code
>  > were fixed to properly use mask. Missing header for
>  > dapm_reg_event added. All codecs can build.
>
>
> AFAICT there are no substantial changes on top of what I already applied?

There are two more fixes in there in addition to the \.

tlv320aic3x uses a macro that exposed this missing header:

 /* dapm events */
+int dapm_reg_event(struct snd_soc_dapm_widget *w,
+                  struct snd_kcontrol *kcontrol, int event);
 int snd_soc_dapm_stream_event(struct snd_soc_codec *codec, char *stream,
       int event);
 int snd_soc_dapm_set_bias_level(struct snd_soc_device *socdev,

And this one in my changes that I missed:

       .put = snd_soc_put_volsw, \
       .private_value = (unsigned long)&(struct soc_mixer_control) \
-               {.reg = xreg, .shift = shift_left, .rshift = right_shift, \
+               {.reg = xreg, .shift = shift_left, .rshift = shift_right, \
                .max = xmax, .invert = xinvert} }
-- 
Jon Smirl
jonsmirl@gmail.com
