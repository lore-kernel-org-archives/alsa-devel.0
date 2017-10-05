From: "Wischer, Timo (ADITG/ESB)" <twischer@de.adit-jv.com>
Subject: SEGFault when optininal
	snd_ctl_ext_callback::read_event() not set
Date: Thu, 5 Oct 2017 12:03:14 +0000
Message-ID: <B0FB33DC1499054591F62C0EF1E013D7684A3E0F@HI2EXCH01.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E8ED266A73
 for <alsa-devel@alsa-project.org>; Thu,  5 Oct 2017 14:03:24 +0200 (CEST)
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
 by smtp1.de.adit-jv.com (Postfix) with ESMTP id 8E7103C017F
 for <alsa-devel@alsa-project.org>; Thu,  5 Oct 2017 14:03:23 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
 by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FhXHIcsaPL7E for <alsa-devel@alsa-project.org>;
 Thu,  5 Oct 2017 14:03:14 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by smtp1.de.adit-jv.com (Postfix) with ESMTPS id DB8B33C015E
 for <alsa-devel@alsa-project.org>; Thu,  5 Oct 2017 14:03:14 +0200 (CEST)
Content-Language: en-US
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

Hi all,

snd_ctl_ext_callback::read_event() callback is mentioned as optional
(see http://git.alsa-project.org/?p=3Dalsa-lib.git;a=3Dblob;f=3Dinclude/con=
trol_external.h;h=3D12958e70a5230de9c74029c641a395a2073c8646;hb=3Drefs/head=
s/master#l239)

but there is no NULL check and the NULL pointer will be called if the read_=
event function callback pointer is not set.
(see http://git.alsa-project.org/?p=3Dalsa-lib.git;a=3Dblob;f=3Dsrc/control=
/control_ext.c;h=3D56552fa1aa0ef0e6383abf4029b63944a841c2c4;hb=3Drefs/heads=
/master#l419)

I think a default function has to be provided which will be called when the=
 callback is not set or the read_event() callback should not be marked as o=
ptional.

What is your opinion?





Best regards



Timo Wischer

 =


Advanced Driver
Information Technology GmbH

Engineering Software Base (ADITG/ESB) =


Robert-Bosch-Str. 200

31139 Hildesheim

Germany

 =


Tel. +49 5121 49 6938

Fax +49 5121 49 6999

twischer@de.adit-jv.com



ADIT is a joint venture company of Robert Bosch GmbH/Robert Bosch Car Multi=
media GmbH and DENSO Corporation

Sitz: Hildesheim, Registergericht: Amtsgericht Hildesheim HRB 3438  =


Gesch=E4ftsf=FChrung: Wilhelm Grabow, Ken Yaguchi
