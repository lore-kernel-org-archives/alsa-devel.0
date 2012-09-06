From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: About joining codecs together
Date: Thu, 6 Sep 2012 06:43:32 +0000
Message-ID: <A551BDF323A45B48ACE6A404AA16A1C412785C8E@TOP-EX01.TOPIC.LOCAL>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp103.mer-nm.internl.net (smtp103.mer-nm.internl.net
 [217.149.192.139])
 by alsa0.perex.cz (Postfix) with ESMTP id AB695265B63
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2012 08:46:17 +0200 (CEST)
Received: from amavisd-new (mailscanner13.mer-nm.internl.net [217.149.192.128])
 by smtp103.mer-nm.internl.net (Postfix) with ESMTP id 470363FDB3
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2012 08:46:17 +0200 (CEST)
Received: from smtp103.mer-nm.internl.net ([217.149.192.139])
 by amavisd-new (mailscanner13.mer-nm.internl.net [217.149.192.159])
 (amavisd-new, port 10024)
 with ESMTP id Pa1fQsL5HgCm for <alsa-devel@alsa-project.org>;
 Thu,  6 Sep 2012 08:46:16 +0200 (CEST)
Received: from TOP-EX02.topic.local (82-204-13-181.dsl.bbeyond.nl
 [82.204.13.181]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by smtp103.mer-nm.internl.net (Postfix) with ESMTPS
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2012 08:46:16 +0200 (CEST)
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

I have multiple codecs (TLV320AIC3256) connected to the McASP of an OMAP L138. I've adapted the drivers a bit so they work with my 2.6.37 kernel and the custom board (similar to a DA850).

Currently, I can only use one codec at a time. The mcasp is set up in the board config, and there it determines which AXR lines are active. Each codec is connected to another line. They run on the same clock lines.

Question:
- How can I forward information from the codec to the mcasp driver, to inform which AXR channel to enable? There seems to be no information exchange between them. When codec 1 is running, the mcasp driver must record from AXR1, and when codec2 is running, AXR2 and so on.


What I ultimately want to do is use two (or more) codecs for multichannel recording, so that I can use two codecs for a 4-channel recording. For the McASP side, this would simply mean enabling both AXR inputs (DAVINCI_MCASP_PDIR_REG) and then starting both codecs.

Questions:
- How does this work in user space? There are two codecs, which are to be configured independently, but there will be only one audio stream coming out.

I was thinking to create a sort of "multiswitch", a codec that by itself doesn't really do anything, but presents itself as a single codec with lots of channels. The actual commands will be delivered to the appropriate "real" codecs, so that you can record from the "switch", which then in turn enables two codecs and sets up the DAI to record both streams. Would that be possible at all? What are the alternatives?


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
