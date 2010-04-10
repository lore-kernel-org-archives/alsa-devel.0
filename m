From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: wrong decibel data?
Date: Sat, 10 Apr 2010 17:27:38 +0800
Message-ID: <h2r4f3252891004100227q1eca2166z280ebcf3f7a122e0@mail.gmail.com>
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
Received: from mail-pz0-f178.google.com (mail-pz0-f178.google.com
	[209.85.222.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 480EA24366
	for <alsa-devel@alsa-project.org>;
	Sat, 10 Apr 2010 11:35:52 +0200 (CEST)
Received: by pzk8 with SMTP id 8so1907pzk.16
	for <alsa-devel@alsa-project.org>; Sat, 10 Apr 2010 02:35:51 -0700 (PDT)
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

The sum the dB range of these two hardware volume controls are already -96dB
to 0 as same as the DR of 16 bits digital audio data is 96dB

the point is that PA developer think the dB range of the pulseaudio master
volume control is -inf dB to 0dB

    control.18 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 1
        comment.range '0 - 64'
        comment.dbmin -4800
        comment.dbmax 0
        iface MIXER
        name 'Master Playback Volume'
        value 27
    }

    control.7 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 64'
        comment.dbmin -4800
        comment.dbmax 0
        iface MIXER
        name 'Headphone Playback Volume'
        value.0 64
        value.1 64
    }
