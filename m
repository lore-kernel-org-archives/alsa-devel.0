From: "Paul Kavan" <pkavan@gmail.com>
Subject: Re: Using aplay and arecord on an ARM
Date: Wed, 20 Jun 2007 14:48:24 -0500
Message-ID: <61c0054e0706201248n4a0fbad8r76bc4fc6710bf1f5@mail.gmail.com>
References: <61c0054e0706191237n666fd422wcf13f874f108e64a@mail.gmail.com>
	<s5hwsxyaa5r.wl%tiwai@suse.de>
	<61c0054e0706200912m1779bef8gfab9da178bd888b4@mail.gmail.com>
	<75b66ecd0706200916i2105cb49xf40313e0440bc821@mail.gmail.com>
	<61c0054e0706200918pbc56676h60640cb08de633b8@mail.gmail.com>
	<s5htzt2a938.wl%tiwai@suse.de>
	<61c0054e0706201004o2aac3328me0912debd94feba2@mail.gmail.com>
	<f5boh6$nc4$1@sea.gmane.org>
	<61c0054e0706201209q717489ddvb07f43ee60476fc@mail.gmail.com>
	<467981F9.3090301@endrelia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 387AF243AF
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jun 2007 21:48:25 +0200 (CEST)
Received: by mu-out-0910.google.com with SMTP id w8so273301mue
	for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2007 12:48:24 -0700 (PDT)
In-Reply-To: <467981F9.3090301@endrelia.com>
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
To: Frank Mandarino <fmandarino@endrelia.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Frank:

> gives me a slightly distorted sine wave that has a period of half of
> > what I would expect.
>
> Better than no sound :)  At least something is getting through ALSA and
> ASoC to your codec.


Very true indeed. It was nice hearing a sine wave come out....even if it was
not ready for prime time.

You may need to adjust the RCMR, RFRM, TCMR, TFRM register settings in
> sound/soc/at91/at91-ssc.c to send the data in the mode that your codec
> expects.  I have only tested I2S and DSP_A modes with S16_LE data.  It's
> fairly easy to add new modes.


I will do this. I can probe the clock and data lines to make sure they are
looking like what I expect and then look to the modes to see what I need to
change in the directories.


> Here is the bare-bones config file that I was using before I added a
> second sound device:
>
> pcm.!default {
>     type hw
>     card 0
> }
> pcm.hw {
>     type hw
>     card 0
>     device 0
>     subdevice 0
> }
> ctl.!default {
>     type hw
>     card 0
> }
> ctl.hw {
>     type hw
>     card 0
> }


I will give this conf a whirl and see what it does.

Thanks.

Paul



-- 
***************************************
Paul David Kavan
Project Engineer
GRH Electronics, Inc.
402-734-4900
pkavan@gmail.com
***************************************
