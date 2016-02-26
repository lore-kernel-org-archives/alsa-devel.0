From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 1/4] ASoC: wm9713: add binding for WM9713
	codec
Date: Fri, 26 Feb 2016 02:33:49 +0100
Message-ID: <87povkuuf6.fsf@belgarion.home>
References: <1455979079-9030-1-git-send-email-robert.jarzmik@free.fr>
 <20160220171459.GA18327@sirena.org.uk> <871t87z1gz.fsf@belgarion.home>
 <20160220195925.GF18327@sirena.org.uk> <87twl3xgud.fsf@belgarion.home>
 <20160220211659.GG18327@sirena.org.uk> <878u2fxbp9.fsf@belgarion.home>
 <20160221014920.GK18327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr
 [80.12.242.126])
 by alsa0.perex.cz (Postfix) with ESMTP id 016AB2606F5
 for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2016 02:33:53 +0100 (CET)
In-Reply-To: <20160221014920.GK18327@sirena.org.uk> (Mark Brown's message of
 "Sun, 21 Feb 2016 10:49:20 +0900")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Takashi Iwai <tiwai@suse.com>, linux-arm-kernel@lists.infradead.org, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie@kernel.org> writes:

>> > It will eumerate the AC'97 bus by itself and does not need the CODEC to
>> > be described.
>
>> I think I still don't get it.
>
>> So let's rephrase it another way : how will the function wm9713_probe() be
>> called, ie. what is the possible function backtrace leading to that call ?
>
> It will not be called, the generic AC'97 code will be used.

Ok, if it's not called no code in sound/soc/codecs/wm9713.c will be used, right
?
In that case wm9713_set_dai_clkdiv() will never be used, nor will the
wm9713_audio_map or wm9713_dapm_widgets be created, which will break all
userspace programs relying on these mixers and DAPM routes.

Or am I missing something ?

>> Do you have a devicetree example somewhere, with (ac97 host, audio codec) pair I
>> can have a look at to understand ?
>
> Some Atmel boards do this IIRC, as does the AACI driver (via AMBA but
> same effect).
I suppose you mean sound/arm/aaci.c, which is more a platform_data like driver
(if I understood the integrator code correctly).

I suppose we can achieve comparable result with sound/arm/pxa2xx-ac97.c, but as
to know if the functionality will be comparable to sound/soc/pxa/pxa2xx-ac97.c,
it's hard to say. If I count the DMA requestors, I see 5 in the sound/soc
version, and 2 in sound/arm.

That makes me believe the sound/arm version is inferior.

Cheers.

-- 
Robert
