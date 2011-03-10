From: Jean-Yves Avenard <jyavenard@gmail.com>
Subject: Re: snd_pcm_hw_params_set_buffer_time_near: invalid
	argument
Date: Thu, 10 Mar 2011 11:53:49 +1100
Message-ID: <AANLkTikA0zJ4-4C1-YTVOZD5kcfoqbGhyzEPYEcE-hcU@mail.gmail.com>
References: <AANLkTik5sX_DWLsN3y_7ANpoF5rgeCNZY7gm=+rFhCsy@mail.gmail.com>
	<AANLkTimfZwH+dqsPZaifekmmctrARdE0DoK5nHoW1Fu_@mail.gmail.com>
	<AANLkTinNhknw6h81zkqhhXQwYyrKGs0mVjYpjYvZuNa=@mail.gmail.com>
	<AANLkTi=WkvaM+oLDAzyvcBzeg_kuB=33esFVXDZn1M48@mail.gmail.com>
	<AANLkTik+ecGzz+yCoYhYCxHEJrsof5Eo_cxgnEU84wZm@mail.gmail.com>
	<alpine.LNX.2.00.1103091326380.4805@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B0AE11039A5
	for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2011 01:53:50 +0100 (CET)
Received: by iwc10 with SMTP id 10so1103826iwc.38
	for <alsa-devel@alsa-project.org>; Wed, 09 Mar 2011 16:53:49 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1103091326380.4805@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Raymond Yau <superquad.vortex2@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi

On 9 March 2011 23:29, Jaroslav Kysela <perex@perex.cz> wrote:

> What is your dir argument (last one) for the near functions? If it's NULL or
> value is zero, it means you request the exact value which may not be
> available. Use -1 to request specified or smaller value or 1 to request
> specified or bigger value.

It is zero.

That still doesn't explain the difference in behaviour I'm seeing
between 400ms or 500ms request. Neither of those are possible with a
64kB buffer.

What you are describing isn't what is happening in practice:
Requesting 500ms with the dir=0 (or NULL) provides a buffer of 371ms.
So it doesn't return an exact value, not even close (I found that with
dir=0 or NULL always return a value equal or less than what is
requested. If less the value returned is the maximum allowed by the
prealloc value)

JY
