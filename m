From: Nicolas GRAZIANO <nicolas.graziano@wanadoo.fr>
Subject: Re: [PATCH] hda driver, correct bug in model "auto"
Date: Wed, 27 Jul 2005 20:32:24 +0200
Message-ID: <42E7D338.60904@wanadoo.fr>
References: <42DD71DC.1090002@wanadoo.fr> <s5hirywlhdf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from postfix3-1.free.fr (postfix3-1.free.fr [213.228.0.44])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C6A141C5
	for <alsa-devel@alsa-project.org>; Wed, 27 Jul 2005 20:32:25 +0200 (MEST)
In-Reply-To: <s5hirywlhdf.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai a =E9crit :

>At Tue, 19 Jul 2005 23:34:20 +0200,
>Nicolas GRAZIANO wrote:
> =20
>
>>- Correct the channels order in model autodetection (not sure of this
>>part, I need validation)
>>   =20
>>
>
>I think this is not correct (although I'm not 100% sure, too).
>The association order is front/clfe/surround/side.
>(The comment in hda_codec.c is wrong.)
>
> =20
>
I make the modification because I was thinking than the order was
front/clfe/side/back (aka surround ?) and the text on back panel of my
motherboard (ASUS P5AD2) make me more confident (with my modification
the channels are at the right place). Can we check with an other
card/codec ?

an another question : the model full_dig correspond to the position on
back panel of my motherboard, can we make the selection of model automati=
c ?

lspci -vn for my card :

0000:00:1b.0 0403: 8086:2668 (rev 03)
        Subsystem: 1043:813d

thanks in advance,
Nicolas


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
