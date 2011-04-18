From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [Alsa-devel]JACK will block audio application and
 audio application will also blcok JACK
Date: Tue, 19 Apr 2011 07:11:21 +0800
Message-ID: <BANLkTim-RwVVs93UA+etc-i8BjLsEYEYgw@mail.gmail.com>
References: <BANLkTi=u9OvWJkPXbxhg5tj_O9Mti9Jeew@mail.gmail.com>
	<BANLkTikSZMqJeRJ5EHZZShvskV-ccx08rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 5562E10381E
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Apr 2011 01:11:23 +0200 (CEST)
Received: by fxm5 with SMTP id 5so3554040fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 18 Apr 2011 16:11:22 -0700 (PDT)
In-Reply-To: <BANLkTikSZMqJeRJ5EHZZShvskV-ccx08rw@mail.gmail.com>
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

2011/4/18 cong fu <fc4976@gmail.com>

> Hi experts:
> I installed JACK and the GUI of it looks good.
>  But it seems it will block the "audio application" and "audio
> application" will also blcok it.
> That is to say:
> 1) If I started the JACK by:
> sudo /usr/bin/jackd -r -m -dalsa -dhw:0 -r44100 -p1024 -n2 -P
> Then I open my web brower and try to play a streaming song(play by
> flash), the song can't play!
>

Do you need to run "jackd" using "sudo" ?

This is normal when your sound card does not support hardware mixing

however both alsa-jack and alsa-pulse plugin are I/O plug

if web browser can use alsa "default" device through "alsa-pulse" plugin to
pulseaudio server

in theory the web browser can also use alsa "default" device through
"alsa-jack" plugin to jack server

assume that you don't use any OSS aplication any more
