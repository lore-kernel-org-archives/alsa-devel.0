From: krzysztof.h1@poczta.fm
Subject: Re: [PATCH] ALSA: wss_lib: fix AZT2320 probe.
Date: 05 Aug 2008 10:23:21 +0200
Message-ID: <20080805082321.6D34ACF19C@f21.poczta.interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id 3224C103826
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Aug 2008 10:23:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>, Takashi Iwai <tiwai@suse.de>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Krzysztof Helt <krzysztof.h1@poczta.fm>
List-Id: alsa-devel@alsa-project.org

> Hi Takashi
> 
> The attached is needed and sufficient to get AZT2320 back in line. 
> Trouble is with non-settable MIC gain bits on AZT2320 which fools
> snd_ad1848_probe() and makes snd-azt2320 fail to load after the wss_lib 
> merge.
> 
> Krzysztof should ACK/NAK this -- he was busy there with CS4248 and might 
> have other plans for it.
> 
> Krzysztof, do you? I'm rather itching to rewrite that function 
> otherwise. It's horrible.
> 

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

If you want to rewrite this function go for it. I'll try to solve cs4248 misdetection and forward you all details (or make a patch after your rewrite).

Kind regards,
Krzysztof

----------------------------------------------------------------------
Te newsy nakreca Cie na caly dzien!
Sprawdz >>> http://link.interia.pl/f1e94
