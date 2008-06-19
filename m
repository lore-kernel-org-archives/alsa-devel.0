From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH 2/2] ad1848: replace duplicated constants
 in cs4231
Date: Thu, 19 Jun 2008 19:56:39 +0200
Message-ID: <20080619195639.7d96b068.krzysztof.h1@poczta.fm>
References: <20080615124128.48486ddc.krzysztof.h1@poczta.fm>
	<s5hy75194ev.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id 4874E2441A
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Jun 2008 19:53:24 +0200 (CEST)
In-Reply-To: <s5hy75194ev.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel <alsa-devel@alsa-project.org>, Rene Herman <rene.herman@keyaccess.nl>
List-Id: alsa-devel@alsa-project.org

On Thu, 19 Jun 2008 11:10:00 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Sun, 15 Jun 2008 12:41:28 +0200,
> Krzysztof Helt wrote:
> > 
> > From: Krzysztof Helt <krzysztof.h1@wp.pl>
> > 
> > Use AD1848 register names in the cs4231 library as well.
> > 
> > Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> Please fix to be checkpatch.pl clean at the next repost.
> 
> WARNING: line over 80 characters
> #438: FILE: sound/isa/cs423x/cs4231_lib.c:525:
> +		snd_cs4231_dout(chip, AD1848_LEFT_INPUT, chip->image[AD1848_LEFT_INPUT]);
> ...
> total: 0 errors, 60 warnings, 1319 lines checked
> 

I have fixed all errors except too long lines, because most of them are in
the macros CS4231_DOUBLE and CS4231_SINGLE (mixer elements definitions).
Should I break these definitions as well?

I have gone berserk with the changes and done three patches till now:
1. Move isa/cs423x/cs4231_lib.c to isa/wss/wss_lib.c
2. Renamed cs4231.h to wss.h
3. Renamed all cs4231_lib function cs4231_foo() into wss_foo().

The next step is to use snd_wss (former snd_cs4231) into the ad1848_lib
functions then slowly assimilate the whole ad1848_lib into the wss_lib.

Question: should I also fix any checkpatch errors/warnings in the first
two patches (move file and rename file)?

Regards,
Krzysztof

----------------------------------------------------------------------
Gdzie warto jechac na urlop? Sprawdz!
kliknij >>> http://link.interia.pl/f1e32
