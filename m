From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: Re: snd soc spi read/write
Date: Fri, 5 Aug 2011 16:00:52 +0800
Message-ID: <CAHG8p1BSW1_enLqJL4fxxHvTd3MdwmS+Av+zy4i23BH+TuhJqw@mail.gmail.com>
References: <CAHG8p1AsKZdVvTj-ydWhDCEKjJcx9Q82srEOVZS45Q5J486YBw@mail.gmail.com>
	<20110804103558.GA25976@opensource.wolfsonmicro.com>
	<CAHG8p1AeeqL+Cj-4V4NwQpD33H4ogV0rfekHjMqfvG7wQ49fCA@mail.gmail.com>
	<20110805054210.GB16956@opensource.wolfsonmicro.com>
	<CAHG8p1AkbrfX3dkLw=MNf24V3peMB33z-vLdVyzRxvGmSNTWSg@mail.gmail.com>
	<20110805063414.GB20809@opensource.wolfsonmicro.com>
	<CAHG8p1BBza_M_Cgrq2O2U+Xc-=rPHeNBKMD_KwfZsLX5Npz9jA@mail.gmail.com>
	<20110805072908.GA28149@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 48077103986
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Aug 2011 10:00:53 +0200 (CEST)
Received: by qwf7 with SMTP id 7so110222qwf.38
	for <alsa-devel@alsa-project.org>; Fri, 05 Aug 2011 01:00:52 -0700 (PDT)
In-Reply-To: <20110805072908.GA28149@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
> Why are you replying off-list? =A0You should implement 16x8 SPI reads in
> the core stuff I'd expect, then disable cache for the CODEC.
>

Sorry, I just forgot to CC.
I wonder if rbtree compress type can support this kind of sparse register?
And should the patch aginst 3.0 or 3.2?
