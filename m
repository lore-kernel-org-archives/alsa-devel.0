From: "Jan Anders" <angreifen@gmail.com>
Subject: Re: [snd-bt87x] Prolink PixelView PlayTV
Date: Mon, 28 Apr 2008 15:06:59 +0200
Message-ID: <27da43c40804280606i321d4166mf933f65f67ab5c56@mail.gmail.com>
References: <27da43c40804271746h3992cea5rd4626ec6b8776ec3@mail.gmail.com>
	<s5hlk2yi7qh.wl%tiwai@suse.de> <4815ADF4.1080208@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.191])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C19A244AD
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Apr 2008 15:07:00 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id f40so9078421fka.0
	for <alsa-devel@alsa-project.org>; Mon, 28 Apr 2008 06:06:59 -0700 (PDT)
In-Reply-To: <4815ADF4.1080208@ladisch.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

>  This records from an analog input.
>  Does recording from the digital input device (hw:2,0) work?

I am not at home right now, but I tried it via ssh and it failed:

 % arecord -D hw:2,0 -f S16_LE -c2 -r64000 -t wav bla.wav
 Recording WAVE 'bla.wav' : Signed 16 bit Little Endian, Rate 64000 Hz, Stereo
 arecord: pcm_read:1348: read error: Input/output error

Recording analog mono works fine remotely.

Regards,
-Jan
