From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v2] ALSA: ASoC: McASP: add support for 24
 bit samples
Date: Tue, 9 Oct 2012 09:49:13 +0000
Message-ID: <A551BDF323A45B48ACE6A404AA16A1C412786E70@TOP-EX01.TOPIC.LOCAL>
References: <A551BDF323A45B48ACE6A404AA16A1C412786E53@TOP-EX01.TOPIC.LOCAL>,
 <5073F2CD.9010407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp103.mer-nm.internl.net (smtp103.mer-nm.internl.net
 [217.149.192.139])
 by alsa0.perex.cz (Postfix) with ESMTP id 02DBF264EEC
 for <alsa-devel@alsa-project.org>; Tue,  9 Oct 2012 11:52:30 +0200 (CEST)
In-Reply-To: <5073F2CD.9010407@gmail.com>
Content-Language: nl-NL
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Please just fix it, the fix is simply to move those "cases" a few lines down. The mcasp code in my tree is severely bashed because i'm using it to record from up to 8 codecs simultaneously...



Met vriendelijke groet / kind regards,

Mike Looijmans

TOPIC Embedded Systems
Eindhovenseweg 32-C, NL-5683 KH Best
Postbus 440, NL-5680 AK Best
Telefoon: (+31) - (0)499 - 33.69.79
Telefax: (+31) - (0)499 - 33.69.70
E-mail: mike.looijmans@topic.nl
Website: www.topic.nl

Dit e-mail bericht en de eventueel daarbij behorende bijlagen zijn uitsluitend bestemd voor de geadresseerde, zoals die blijkt uit het e-mail bericht en/of de bijlagen. Er kunnen gegevens met betrekking tot een derde instaan. Indien u als niet-geadresseerde dit bericht en de bijlagen ontvangt, terwijl u niet bevoegd of gemachtigd bent om dit bericht namens de geadresseerde te ontvangen, wordt u verzocht de afzender hierover direct te informeren en het e-mail bericht met de bijlagen te vernietigen. Ieder gebruik van de inhoud van het e-mail bericht, waaronder de daarbij behorende bijlagen, door een ander dan de geadresseerde is onrechtmatig jegens ons dan wel de eventueel in het e-mail bericht of de bijlagen voorkomende andere personen. TOPIC Embedded Systems is niet aansprakelijk voor enig
 erlei schade voortvloeiend uit het gebruik en/of acceptatie van dit e-mail bericht of de daarbij behorende bijlagen.

The contents of this message, as well as any enclosures, are addressed personally to, and thus solely intended for the addressee. They may contain information regarding a third party. A recipient who is neither the addressee, nor empowered to receive this message on behalf of the addressee, is kindly requested to immediately inform the sender of receipt, and to destroy the message and the enclosures. Any use of the contents of this message and/or the enclosures by any other person than the addressee or person who is empowered to receive this message, is illegal towards the sender and/or the aforementioned third party. TOPIC Embedded Systems is not  liable for any damage as a result of the use and/or acceptance of this message and as well as any enclosures.
________________________________________
Van: Daniel Mack [zonque@gmail.com]
Verzonden: dinsdag 9 oktober 2012 11:47
Aan: Mike Looijmans
CC: alsa-devel@alsa-project.org; Mark Brown
Onderwerp: Re: [alsa-devel] [PATCH v2] ALSA: ASoC: McASP: add support for 24 bit samples

On 09.10.2012 11:41, Mike Looijmans wrote:
> Sorry for the lack of quoting, but I onle get the digest.
>
> These are wrong:
>
> +       case SNDRV_PCM_FORMAT_U24_LE: +       case
> SNDRV_PCM_FORMAT_S24_LE:
>
> These pack a 24-bit sample value in a 32-bit word. The codec will
> send 32 bits to the McASP, and you should transfer 32 bits to the
> user, not just 24. Hence, SNDRV_PCM_FORMAT_S24_LE must be treated
> just like SNDRV_PCM_FORMAT_S32_LE.
>
> I've tested that on a DA850-alike board with several TLV320AIC3256
> codecs, treating them as 3-byte samples will reasult in invalid
> data.

Ok, thanks for reporting this. Would like to send a patch or want me to
fix it?


Daniel
