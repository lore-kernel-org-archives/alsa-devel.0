From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: wrong decibel data?
Date: Fri, 9 Apr 2010 08:49:40 +0800
Message-ID: <h2q4f3252891004081749y9ee82029jba8087222d79e6a0@mail.gmail.com>
References: <q2s98391a7b1004021121sde36d074m8a70acc142f95d93@mail.gmail.com>
	<r2i4f3252891004051846xc6ef1834habaf4f9db3bdd384@mail.gmail.com>
	<q2z98391a7b1004060101kd5ffef92tf4d98faa62a3ad5b@mail.gmail.com>
	<q2l4f3252891004071905l553da6a0he8b53448524fc94d@mail.gmail.com>
	<z2s98391a7b1004080542ud4af307l992ac9636d9aa508@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f178.google.com (mail-pz0-f178.google.com
	[209.85.222.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 16A7A243FA
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Apr 2010 02:49:41 +0200 (CEST)
Received: by pzk8 with SMTP id 8so1842828pzk.16
	for <alsa-devel@alsa-project.org>; Thu, 08 Apr 2010 17:49:41 -0700 (PDT)
In-Reply-To: <z2s98391a7b1004080542ud4af307l992ac9636d9aa508@mail.gmail.com>
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

2010/4/8 Nicolo' Chieffo <nicolo.chieffo@gmail.com>

> I'm sorry but I found out that I gave you wrong values of "amixer -D
> pulse": I just discovered that when I lower the alsa master volume, in
> some occasions the PCM volume goes to 99%, so now I will put it to
> 100% and check the pulse volume again.
>
> 0 dB    =  65536 [100%]
> -3 dB   =  57520 [88%]
> -6 dB   =  52057 [79%]
> -12 dB =  41034 [63%]
> -24 dB =  26090 [40%]
> -48 dB = 10151 [15%]


You have to ask PA developer since  "PCM" is a softvol control with access
'user' and dbmin -51dB

    control.24 {
        comment.access 'read write user'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 255'
        comment.tlv '0000000100000008ffffec1400000014'
        comment.dbmin -5100
        comment.dbmax 0
        iface MIXER
        name 'PCM Playback Volume'
        value.0 255
        value.1 255
    }


HDA-Intel.pcm.front.0 {
	@args [ CARD ]
	@args.CARD {
		type string
	}
	type softvol
	slave.pcm {
		type hw
		card $CARD
	}
	control {
		name "PCM Playback Volume"
		card $CARD
	}
}
