From: "Feilmeier Daniel (Ask De)" <feilmeierd@askgroup.de>
Subject: ALSA / Soundcard latency
Date: Tue, 25 Apr 2017 07:00:40 +0000
Message-ID: <DBXPR06MB286900FD1B5EEF225F3A3B1C71E0@DBXPR06MB286.eurprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from askmail01.askgroup.it (askmail01.askgroup.it [89.96.89.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 38BA72668A2
 for <alsa-devel@alsa-project.org>; Tue, 25 Apr 2017 09:00:44 +0200 (CEST)
Received: from itsrvmail106.askgroup.it ([10.100.101.50]) by
 askmail01.askgroup.it with ESMTP id lpcoPidRb2T6N1i6 (version=TLSv1
 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NO) for
 <alsa-devel@alsa-project.org>; Tue, 25 Apr 2017 09:00:43 +0200 (CEST)
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

Hello,

My company is a supplier of car manufacturers. We develop and produce digit=
al audio amplifiers.



We would like to build our test setup for echo order cancelation

routines for our audio amplifiers with a

real- time Linux and ALSA.



We have very strong requirements regarding the maximum latency from

audio input via line in to audio output. We would like to achieve a

maximum latency < 1ms. The alsaloop example mentions a latency of 1 ms

which is on our test setup with the latest rt kernel from This M=E4chler

not working due to broken pipe errors. Is 1 ms feasible with a standard PC ?

Currently we still don=B4t know what the lowest possible latency using

ALSA is. We tried different soundcards and found out that they have an

internal FIFO, which seems to be one of the limiting factors. The min.

latency we can achieve is currently 5,6 ms, but this is still to high.

Is there any possibility to switch this FIFO off via ALSA ? Is it possible =
at

all to achieve such low latency values ?



Kind regards,


___________________________________________________________________________=
________

Feilmeier Daniel

R&D Software Electronics

Tel.:  +49-9962-2003-629
Fax.:  +49-9962-2003-79
E-Mail: FeilmeierD@askgroup.de<mailto:FeilmeierD@askgroup.de>


ASK Industries GmbH
Hauptstrasse 73
D-94559 Niederwinkling

HRG Straubing  HRB 10703
Geschaeftsfuehrer: Ruggero Marchetti   Franz Maier   Juergen Pledl
___________________________________________________________________________=
________
