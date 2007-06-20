From: Frank Mandarino <fmandarino@endrelia.com>
Subject: Re: Using aplay and arecord on an ARM
Date: Wed, 20 Jun 2007 13:35:33 -0400
Message-ID: <f5boh6$nc4$1@sea.gmane.org>
References: <61c0054e0706191237n666fd422wcf13f874f108e64a@mail.gmail.com>	<61c0054e0706200739k2b934a9avbffb133937adba4c@mail.gmail.com>	<61c0054e0706200824v444d6c8dr6b6023b16043fa7@mail.gmail.com>	<61c0054e0706200827h389e2c6v46dfc544def95e82@mail.gmail.com>	<61c0054e0706200840k2b0f13c9q57581c380d39d2fc@mail.gmail.com>	<s5hwsxyaa5r.wl%tiwai@suse.de>	<61c0054e0706200912m1779bef8gfab9da178bd888b4@mail.gmail.com>	<75b66ecd0706200916i2105cb49xf40313e0440bc821@mail.gmail.com>	<61c0054e0706200918pbc56676h60640cb08de633b8@mail.gmail.com>	<s5htzt2a938.wl%tiwai@suse.de>
	<61c0054e0706201004o2aac3328me0912debd94feba2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 051E12437C
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jun 2007 20:14:16 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I14br-0000bm-2j
	for alsa-devel@alsa-project.org; Wed, 20 Jun 2007 20:08:51 +0200
Received: from bas17-toronto12-1168030042.dsl.bell.ca ([69.158.185.90])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2007 20:08:51 +0200
Received: from fmandarino by bas17-toronto12-1168030042.dsl.bell.ca with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2007 20:08:51 +0200
In-Reply-To: <61c0054e0706201004o2aac3328me0912debd94feba2@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Paul Kavan wrote:

...

> For alsa-libs:
> CC=arm-linux-gcc ./configure --target=arm-linux --host=i686-pc-linux-gnu
> --prefix=/usr

...

> However, I have been unable to achieve any kind of playback using
> speaker-test or aplay. The speaker pops like it wants to play, but I get the
> following when trying speaker test:
> 
> /dev/snd $ speaker-test -D default -r 8000 -f 1020 -F S8
> 
> speaker-test 1.0.14
> 
> Playback device is default
> Stream parameters are 8000Hz, S8, 1 channels
> Using 16 octaves of pink noise
> Rate set to 8000Hz (requested 8000Hz)
> Buffer size range from 64 to 32768
> Period size range from 32 to 8192
> Using max buffer size 32768
> Periods = 4
> was set period_size = 0
> was set buffer_size = 32768
> Unable to set sw params for playback: Invalid argument
> Setting of swparams failed: Invalid argument
> /dev/snd $
> 
> 
> Anyone know where I should look for the problem?

Hi Paul,

Try adding the option "--with-versioned=no" to the alsa-libs configure.

../fam
-- 
Frank Mandarino                                fmandarino(a)endrelia.com
Endrelia Technologies Inc.
Toronto, Ontario, Canada
