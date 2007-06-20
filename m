From: "Paul Kavan" <pkavan@gmail.com>
Subject: Re: Using aplay and arecord on an ARM
Date: Wed, 20 Jun 2007 15:22:53 -0500
Message-ID: <61c0054e0706201322q280132c6n2d80a77f0c5f4d6b@mail.gmail.com>
References: <61c0054e0706191237n666fd422wcf13f874f108e64a@mail.gmail.com>
	<61c0054e0706200912m1779bef8gfab9da178bd888b4@mail.gmail.com>
	<75b66ecd0706200916i2105cb49xf40313e0440bc821@mail.gmail.com>
	<61c0054e0706200918pbc56676h60640cb08de633b8@mail.gmail.com>
	<s5htzt2a938.wl%tiwai@suse.de>
	<61c0054e0706201004o2aac3328me0912debd94feba2@mail.gmail.com>
	<f5boh6$nc4$1@sea.gmane.org>
	<61c0054e0706201209q717489ddvb07f43ee60476fc@mail.gmail.com>
	<467981F9.3090301@endrelia.com>
	<61c0054e0706201248n4a0fbad8r76bc4fc6710bf1f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 98A81243B9
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jun 2007 22:22:54 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id o2so425901uge
	for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2007 13:22:53 -0700 (PDT)
In-Reply-To: <61c0054e0706201248n4a0fbad8r76bc4fc6710bf1f5@mail.gmail.com>
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

> You may need to adjust the RCMR, RFRM, TCMR, TFRM register settings in
> > sound/soc/at91/at91- ssc.c to send the data in the mode that your codec
> > expects.  I have only tested I2S and DSP_A modes with S16_LE data.  It's
> > fairly easy to add new modes.
>
>
This is certainly part of the problem. I probed the clocks and the frame
sync lines and they are fine for the most part. However, I can tell from the
output that I need to change the default on TD0 to '1' for starters. I also
think that I need to change the format so that the atmel board reads on the
falling edge after sync. I think it already writes on the rising edge, but
will have to see. Also, the width of the sync is one period of the
bitclock....and I need at least two, so I will need to change that.

Fortunately, I have done a lot of grunt work already in writing my basic ssc
driver for that codec. Now I have to dig into at91-ssc.c to see how to
modify that.


> > pcm.!default {
> >     type hw
> >     card 0
> > }
> > pcm.hw {
> >     type hw
> >     card 0
> >     device 0
> >     subdevice 0
> > }
> > ctl.!default {
> >     type hw
> >     card 0
> > }
> > ctl.hw {
> >     type hw
> >     card 0
> > }
>
>
The bare bones conf is not working for me and I am getting:

/usr/share/alsa $ aplay -l
**** List of PLAYBACK Hardware Devices ****
ALSA lib conf.c:3949:(snd_config_expand) Unknown parameters 0
ALSA lib control.c:909:(snd_ctl_open_noupdate) Invalid CTL hw:0
aplay: device_list:213: control open (0): Invalid argument


For whatever reason, the default conf file is letting me use speaker-test,
so I can work on debugging the format for now.  I am using alsa-lib-1.0.14aand
alsa-utils-1.0.14, so I am not sure if that makes a difference. If anyone on
the list has a bare bones conf for a simple pcm codec, I would appreciate
some tips on why this one is not working.

Thanks Frank. I am gonna dig into at91-ssc.c now.

Paul
-- 
***************************************
Paul David Kavan
Project Engineer
GRH Electronics, Inc.
402-734-4900
pkavan@gmail.com
***************************************
