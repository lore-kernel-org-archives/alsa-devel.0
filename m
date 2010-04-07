From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: wrong decibel data?
Date: Thu, 8 Apr 2010 07:38:25 +0800
Message-ID: <s2m4f3252891004071638h7d9a2195h68ff44100fd30ab6@mail.gmail.com>
References: <q2s98391a7b1004021121sde36d074m8a70acc142f95d93@mail.gmail.com>
	<r2i4f3252891004051846xc6ef1834habaf4f9db3bdd384@mail.gmail.com>
	<q2z98391a7b1004060101kd5ffef92tf4d98faa62a3ad5b@mail.gmail.com>
	<l2y4f3252891004061734w9b710450ic6661ff8b2e630f9@mail.gmail.com>
	<v2t98391a7b1004070117z37c270f8ze8519c99894a07f8@mail.gmail.com>
	<y2g98391a7b1004070517sf35fe274q1d011982b55a508e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f178.google.com (mail-pz0-f178.google.com
	[209.85.222.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 073D11038CF
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Apr 2010 01:38:26 +0200 (CEST)
Received: by pzk8 with SMTP id 8so888681pzk.16
	for <alsa-devel@alsa-project.org>; Wed, 07 Apr 2010 16:38:26 -0700 (PDT)
In-Reply-To: <y2g98391a7b1004070517sf35fe274q1d011982b55a508e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/4/7 Nicolo' Chieffo <nicolo.chieffo@gmail.com>

> This is what I'm doing:
> - got a jack-jack audio cable
> - connected the headphone to the mic
> - open alsamixer and put everything to 0 dB
> - verified that the pass-throw works by using the sound recorder
>
> ./dbmeasure plughw:0 dbmeasure_hw.log
>
> exits with this error:
>

Have you ask  the author of "dbmeasure" ?


>
> Iteration 1, level is 0 (-inf dB).
> Volume level measured (0) was too high or too low.
> Please adjust mixer so that initial level is between 0.8 and 0.97.
> Test run canceled.
>
>
> I've also tried to put the mic level at 100% (22.50 dB) but the output
> is the same.
>

your card seem to support 16/20/24bits

if you right shift your 16/24 bits digital audio by 16/24 bits , the digital
data are always zero
so any software atten on a 16/24bits sound card is still a finite negative
number dB instead of -inf  dB

that 's why the professional user prefer 32bits sound card
