From: Guilherme <grlongo.ireland@gmail.com>
Subject: Re: segfault when setting swparams! help - SOLVED
Date: Fri, 19 Jun 2009 04:43:49 -0300
Message-ID: <4A3B41B5.7030600@gmail.com>
References: <1245369035.6830.27.camel@localhost>	<s5h1vpgg2d6.wl%tiwai@suse.de>	<4A3B3DFE.1090709@gmail.com>
	<s5hr5xgel28.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A553103893
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Jun 2009 09:43:12 +0200 (CEST)
Received: by qyk1 with SMTP id 1so2101757qyk.16
	for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2009 00:43:11 -0700 (PDT)
In-Reply-To: <s5hr5xgel28.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks Takashi.
Its solved the problem.

Tks!

-------------------

Guilherme Longo
Dept. Eng. da Computa=E7=E3o
Unaerp

Linux User - #484927

*Before Asking
http://www.istf.com.br/?page=3Dperguntas

!- I'd rather die on my feet than live on my knees -!



Takashi Iwai wrote:
> At Fri, 19 Jun 2009 04:27:58 -0300,
> Guilherme wrote:
>   =

>>                 //snd_pcm_hw_params_alloca(&hwparams);
>>                 //snd_pcm_sw_params_alloca(&swparams);
>>     =

>
> Uncomment these.
>
>
> Takashi
>
>   =
