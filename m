From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: wrong decibel data?
Date: Sat, 10 Apr 2010 08:27:09 +0800
Message-ID: <v2i4f3252891004091727q3cda9536v6b811df88f836627@mail.gmail.com>
References: <q2s98391a7b1004021121sde36d074m8a70acc142f95d93@mail.gmail.com>
	<r2i4f3252891004051846xc6ef1834habaf4f9db3bdd384@mail.gmail.com>
	<q2z98391a7b1004060101kd5ffef92tf4d98faa62a3ad5b@mail.gmail.com>
	<q2l4f3252891004071905l553da6a0he8b53448524fc94d@mail.gmail.com>
	<z2s98391a7b1004080542ud4af307l992ac9636d9aa508@mail.gmail.com>
	<u2w4f3252891004081611tc0293e7fzb6312ca188eacdc1@mail.gmail.com>
	<s2l98391a7b1004090030vd55faadew6ae97c85a7a4b379@mail.gmail.com>
	<r2u4f3252891004090649p3f327273x3af60905a06045fe@mail.gmail.com>
	<r2o98391a7b1004090659s3493aa86gb47819d4f2e9c742@mail.gmail.com>
	<h2i98391a7b1004091135u5519f86w31e7d85ed83e2f67@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D1751037F3
	for <alsa-devel@alsa-project.org>;
	Sat, 10 Apr 2010 02:27:10 +0200 (CEST)
Received: by pvg12 with SMTP id 12so2219392pvg.38
	for <alsa-devel@alsa-project.org>; Fri, 09 Apr 2010 17:27:09 -0700 (PDT)
In-Reply-To: <h2i98391a7b1004091135u5519f86w31e7d85ed83e2f67@mail.gmail.com>
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

2010/4/10 Nicolo' Chieffo <nicolo.chieffo@gmail.com>

> DMBEASURE
>
> There's still no way to run the measurement with "pulse" because of
> the previous error:Iteration 1, level is 0 (-inf dB).
>    Volume level measured (0) was too high or too low.
>   Please adjust mixer so that initial level is between 0.8 and 0.97.
>   Test run canceled.
> Are you sure that the test has sense using the pulse device?
>
> "./dbmeasure plug:front plug_front.csv" works, but seems to never end:
>   Iteration 3297, level is 0.0414072 (-27.6585 dB).
>   Iteration 3298, level is 0.0414074 (-27.6584 dB).
>   Iteration 3299, level is 0.0414064 (-27.6587 dB).
>   Iteration 3300, level is 0.041406 (-27.6587 dB).
>   .....
>
>
> "./dbmeasure hw:0 hw.csv" fails with this message: "Cannot set sample
> format: Invalid argument"
>

The DR range of software ( 16 bits audio data ) need to be same as the range
of hardware volume control if you want  ths slider move at same scale

i.e. if PA only use one hardware volume control of  -48dB to 0 but the DR
range of 16 bits audio is 96dB , PA have to scale up the dB value by two

The best way is of course to sum the DB range of  all  hardware volume
controls in the audio path of the codec  to get a DB range of value close to
-96dB to 0 (i.e. need to use the value of the Volume Knob widget )

However the softvol plugin is in the software side , you have to verify the
step of the solfware volume control "PCM Playback volume" behave as it
expected

The easy way is to play a full amplitude of sine wave to "front" device and
record it using an analog loop cable with 0dB capture gain , try to lower
the PCM volume and observe the amplitude of the recorded sine wave is
decreased at the correct ratio
