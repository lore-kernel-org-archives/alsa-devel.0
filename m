From: "Jarkko Nikula" <jhnikula@gmail.com>
Subject: Re: [PATCH 1/8] ALSA: ASoC: tlv320aic3x add dsp_a,
	fix dsp_b
Date: Sat, 20 Dec 2008 18:02:33 +0200
Message-ID: <bd7b27490812200802o39072b3dj37df269ae1e288a0@mail.gmail.com>
References: <1229629006-4261-1-git-send-email-troy.kisky@boundarydevices.com>
	<1229629006-4261-2-git-send-email-troy.kisky@boundarydevices.com>
	<bd7b27490812190204p11bd383bmb64bf62c166f4476@mail.gmail.com>
	<494BE237.7020204@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 951CB1037E3
	for <alsa-devel@alsa-project.org>; Sat, 20 Dec 2008 17:02:34 +0100 (CET)
Received: by mu-out-0910.google.com with SMTP id w1so729203mue.2
	for <alsa-devel@alsa-project.org>; Sat, 20 Dec 2008 08:02:33 -0800 (PST)
In-Reply-To: <494BE237.7020204@boundarydevices.com>
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
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: cliff.cai@analog.com, alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com, broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 19, 2008 at 8:04 PM, Troy Kisky
<troy.kisky@boundarydevices.com>wrote:

> Jarkko Nikula wrote:
> > Is this correct? I'm looking the WM9713 spec and there DSP_A has the
> 1-bit
> > delay.
> >
> > But I like this idea to add another DSP format.
> >
> >
> > Jarkko
>
> I think you are correct. Thanks.
>
> But, the AIC23 and SSM2602 would then be backwards too.
>
>
And obviously omap-mcbsp.c too... grr, looks like I forgot to send a fix to
it when fixing aic3x (commit 4b7d283150b35db6e5e10f72606f603ff424c92a). Will
send a fix to omap-mcbsp, aic23 and osk5912 next week.

Yep, seems that SSM2602 should set the submode1 for DSP_B and submode2 for
DSP_A, not vice versa. Worth to check then bf5xx-i2s.c as well.


Jarkko
