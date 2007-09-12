From: "Krzysztof Helt" <krzysztof.h1@gmail.com>
Subject: Re: [PATCH] New Aztech Sound Galaxy driver.
Date: Wed, 12 Sep 2007 20:31:48 +0200
Message-ID: <8c74410a0709121131x2f89c27do2dc81e24c6acdcad@mail.gmail.com>
References: <46E1DD43.6060403@gmail.com>
	<20070911210704.e738bd61.krzysztof.h1@gmail.com>
	<46E6EAAC.1070804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by alsa0.perex.cz (Postfix) with ESMTP id 50BD724427
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Sep 2007 20:31:51 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so333272wag
	for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2007 11:31:50 -0700 (PDT)
In-Reply-To: <46E6EAAC.1070804@gmail.com>
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
To: Rene Herman <rene.herman@gmail.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Ram Kromberg <ramkromberg@mail.com>
List-Id: alsa-devel@alsa-project.org

On 9/11/07, Rene Herman <rene.herman@gmail.com> wrote:
>
> Yes, dumb cut & paste error from when it was split off into its own
> function; please change the four "return err;" exits in (that version of)
> snd_galaxy_probe() with "goto error;"
>

I fixed this as you wrote and now the driver works ok. I haven't
tested recording.

If you care the mixer controls I found that: "Line" is CD line and
"Aux1" is FM/wavetable.

This card returns DSP version 3.1 which is something better than SB
Pro. Maybe these AZT-1605 cards return earlier DSP version (but I do
not expect anything less than 3.0)

Regards,
Krzysztof
