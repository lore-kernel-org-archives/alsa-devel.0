From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: ASoC: Multiplexing CODECs together
Date: Mon, 10 Sep 2012 10:01:00 +0000
Message-ID: <A551BDF323A45B48ACE6A404AA16A1C412785E17@TOP-EX01.TOPIC.LOCAL>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp102.mer-nm.internl.net (smtp102.mer-nm.internl.net
 [217.149.192.138])
 by alsa0.perex.cz (Postfix) with ESMTP id E7774265062
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2012 12:03:50 +0200 (CEST)
Received: from amavisd-new (mailscanner12.mer-nm.internl.net [217.149.192.127])
 by smtp102.mer-nm.internl.net (Postfix) with ESMTP id 944263FDAC
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2012 12:03:50 +0200 (CEST)
Received: from smtp102.mer-nm.internl.net ([217.149.192.138])
 by amavisd-new (mailscanner12.mer-nm.internl.net [217.149.192.159])
 (amavisd-new, port 10024)
 with ESMTP id 6Up1Mz+mszB1 for <alsa-devel@alsa-project.org>;
 Mon, 10 Sep 2012 12:03:50 +0200 (CEST)
Received: from TOP-EX02.topic.local (82-204-13-181.dsl.bbeyond.nl
 [82.204.13.181]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by smtp102.mer-nm.internl.net (Postfix) with ESMTPS
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2012 12:03:48 +0200 (CEST)
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
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I'm using multiple TI codecs and an OMAP-L138.

So far, I've been able to use a single codec. I've changed the davinci-mcasp.c code to respond to "set_tdm_slot", which I now use to tell it which serializers must be activated for capture and playback. This works fine now, any codec on any serializer port can be used independently now.

I want to take the next step and have two codecs "mixed" together, so that two codecs form a  4-channel ADC device. They are all running on the same clocks.

My idea so far is to create a "multiplex" codec driver, which exports mixer controls to tell it which real codecs to activate. No problem so far. Now when an application starts capture from the multiplex, it should call the "real" codecs (e.g. set_hw_params). This poses several problems, because the structs passed to the calls contain information that is irrelevant for the codec(s) that must actually do the work.
Creating a multiplex codec, as opposed to say a dai, made sense to me because an application can "select" it.

So my question is, Am I on the right track here? Or should I forget about the codec multiplex driver, because I have to write something completely?

Or is this not the correct list to ask this kind of questions? In which case I'd be happy to learn where I might get some tips?


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
