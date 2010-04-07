From: "Nicolo' Chieffo" <nicolo.chieffo@gmail.com>
Subject: Re: wrong decibel data?
Date: Wed, 7 Apr 2010 14:17:54 +0200
Message-ID: <y2g98391a7b1004070517sf35fe274q1d011982b55a508e@mail.gmail.com>
References: <q2s98391a7b1004021121sde36d074m8a70acc142f95d93@mail.gmail.com>
	<r2i4f3252891004051846xc6ef1834habaf4f9db3bdd384@mail.gmail.com>
	<q2z98391a7b1004060101kd5ffef92tf4d98faa62a3ad5b@mail.gmail.com>
	<l2y4f3252891004061734w9b710450ic6661ff8b2e630f9@mail.gmail.com>
	<v2t98391a7b1004070117z37c270f8ze8519c99894a07f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f219.google.com (mail-ew0-f219.google.com
	[209.85.219.219])
	by alsa0.perex.cz (Postfix) with ESMTP id BD1B210392A
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Apr 2010 14:18:14 +0200 (CEST)
Received: by ewy19 with SMTP id 19so475085ewy.22
	for <alsa-devel@alsa-project.org>; Wed, 07 Apr 2010 05:18:14 -0700 (PDT)
In-Reply-To: <v2t98391a7b1004070117z37c270f8ze8519c99894a07f8@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is what I'm doing:
- got a jack-jack audio cable
- connected the headphone to the mic
- open alsamixer and put everything to 0 dB
- verified that the pass-throw works by using the sound recorder

./dbmeasure plughw:0 dbmeasure_hw.log

exits with this error:

Iteration 1, level is 0 (-inf dB).
Volume level measured (0) was too high or too low.
Please adjust mixer so that initial level is between 0.8 and 0.97.
Test run canceled.


I've also tried to put the mic level at 100% (22.50 dB) but the output
is the same.
