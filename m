From: Olof <olof@baah.se>
Subject: Re: Information request - writing a driver for a
	virtual soundcard
Date: Wed, 18 Aug 2010 21:44:05 +0200
Message-ID: <AANLkTimkXD-LMULa4vdMHMSw7Q2aLjHZTuEgm2ts7fYs@mail.gmail.com>
References: <AANLkTiksDnhg=kBupJ1uQO_vXq+8q-tk+TXwAwgtRaSm@mail.gmail.com>
	<20100818191510.GL17833@buzzloop.caiaq.de>
	<AANLkTi=EO295r9BpmR105gYLRsjFhG3_kiD81mHTSLKP@mail.gmail.com>
	<20100818193354.GM17833@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 2B37C1037E3
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Aug 2010 21:44:06 +0200 (CEST)
Received: by ewy21 with SMTP id 21so670831ewy.38
	for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2010 12:44:05 -0700 (PDT)
In-Reply-To: <20100818193354.GM17833@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> I still don't understand where the actual audio material has its origin,
> or where it should be sent to, respectively.

Origin is anything the user would choose to play on a "normal" system.
Pure sound from CD, mp3, ogg, wma played with xmmls, totem movie
player etc. Any application used to play sound on a Linux box. The PCM
stream would be compressed and transmitted over TCP/IP to the
smartphone which would play it on its output.

Thanks,
Olof
