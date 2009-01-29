From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: CS4232 Playback bug on Tecra 500
Date: Thu, 29 Jan 2009 16:02:13 +0100
Message-ID: <20090129160213.dacde87d.krzysztof.h1@poczta.fm>
References: <405205790901212040s79ce94a4if4ff742a9c18bc67@mail.gmail.com>
	<20090122134150.f6d0e192.krzysztof.h1@poczta.fm>
	<405205790901220743k32d76edeh733b2dacfbf0497e@mail.gmail.com>
	<20090122172856.e39ae951.krzysztof.h1@poczta.fm>
	<s5h7i4n5mar.wl%tiwai@suse.de>
	<20090124092606.11f3660e.krzysztof.h1@poczta.fm>
	<s5hab9e5rky.wl%tiwai@suse.de>
	<20090126183315.68772c4d.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id A981E103897
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 15:58:50 +0100 (CET)
In-Reply-To: <20090126183315.68772c4d.krzysztof.h1@poczta.fm>
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
Cc: alsa-devel@alsa-project.org, Stanley Pinchak <stanley.pinchak@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 26 Jan 2009 18:33:15 +0100
Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:

> The problem is more complicated. The cs4236+ cards have two
> separate PNP bios ids! The problem here is that Linux kernel
> allows only one id per device. The ids are CS0010* for the CS0000*
> device and CS0110* for the CS0100* devices. The second device
> has only control port range (one io range).
> 
> I have prepared the patch which I tested on my Dell Latitude CPi
> laptop and now it properly discovers the CS4237B codec. Stanley,
> please test it as well.
> 

Takashi,

Please take a look at the patch which unifies the cs4232 and the cs4236+
driver code. It should solve all problems with the Crystal PnP BIOS chip
detection. At least, it solves this at my Dell laptop.

Regards,
Krzysztof

----------------------------------------------------------------------
Promocja w Speak Up. 3 miesiace angielskiego gratis.
Sprawdz teraz i wypelnij formularz! >> http://link.interia.pl/f2019
