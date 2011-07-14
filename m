From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Specifying the default buffer-size for
	snd-hda-intel
Date: Thu, 14 Jul 2011 14:13:48 +0800
Message-ID: <CAN8cciY3eA0FVSUsHCed=M=UTQFrObvR1az7mAnNTo4ciuJ2Zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f50.google.com (mail-fx0-f50.google.com
	[209.85.161.50])
	by alsa0.perex.cz (Postfix) with ESMTP id 12A7610392D
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Jul 2011 08:37:59 +0200 (CEST)
Received: by fxh2 with SMTP id 2so485139fxh.9
	for <alsa-devel@alsa-project.org>; Wed, 13 Jul 2011 23:37:58 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

> +config SND_HDA_PREALLOC_SIZE
> +	int "Pre-allocated buffer size for HD-audio driver"
> +	range 0 32768
> +	default 64
> +	help
> +	  Speficies the default pre-allocated buffer-size in kB for
> +	  HD-audio driver.  A larger buffer (e.g. 2048) is preferred
> +	  for systems with PulseAudio.  The default 64 is chosen just
> +	  from the compatibility reason.
> +

+	range 0 32768
-      range 64 32768

It seem that the minimum range cannot be zero

Does current PA server still work with sound drivers with  64K buffer  ?
