From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [OSS] Add CXT48 to modem black list in ac97
Date: Thu, 14 Apr 2005 23:07:43 +1000
Message-ID: <20050414130743.GA18784__44227.3150234998$1113484217$gmane$org@gondor.apana.org.au>
References: <E1DInEA-0006md-00@gondolin.me.apana.org.au> <425D963C.5030202@latinsud.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from arnor.apana.org.au (arnor.apana.org.au [203.14.152.115])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 72FC9221
	for <alsa-devel@alsa-project.org>; Thu, 14 Apr 2005 15:09:36 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <425D963C.5030202@latinsud.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "SuD (Alex)" <sud@latinsud.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 13, 2005 at 11:59:24PM +0200, SuD (Alex) wrote:
> 
> As a result, if i insert "snd-intel8x0" it will detect a soundcard (pci 
> 0:0:1f.5), but if insert instead
> "snd-intel8x0M" it will detect a modem (pci 0:0:1f.6).
> If a modem is detected i get errors like: "MC'97 0 converters and GPIO 
> not ready (0x1)", and not sure how to test it.
> If i load both modules only the first will work. The second will give an 
> probe error -13 (EACCES?), because it has been marked as audio device, 
> but also marked as _SKIP_AUDIO (ac97_codec.c:1862), or viceversa.

Thanks for testing.

It would appear then that ALSA doesn't have a magic solution :)
It'll always treat the codec as a sound card when the sound module
is loaded.

Alan, you seem to be the one who added the original code to
i810_audio to skip the modem codecs.  Does this actually
do anything for OSS? That is, are there any modem drivers out
there that will work with OSS drivers?

If not, then I'd suggest that we simply remove the modem checks
from the OSS Code.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
