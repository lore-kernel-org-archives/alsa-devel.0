From: Frank Mandarino <fmandarino@endrelia.com>
Subject: Re: Using aplay and arecord on an ARM
Date: Wed, 20 Jun 2007 15:37:29 -0400
Message-ID: <467981F9.3090301@endrelia.com>
References: <61c0054e0706191237n666fd422wcf13f874f108e64a@mail.gmail.com>	
	<61c0054e0706200827h389e2c6v46dfc544def95e82@mail.gmail.com>	
	<61c0054e0706200840k2b0f13c9q57581c380d39d2fc@mail.gmail.com>	
	<s5hwsxyaa5r.wl%tiwai@suse.de>	
	<61c0054e0706200912m1779bef8gfab9da178bd888b4@mail.gmail.com>	
	<75b66ecd0706200916i2105cb49xf40313e0440bc821@mail.gmail.com>	
	<61c0054e0706200918pbc56676h60640cb08de633b8@mail.gmail.com>	
	<s5htzt2a938.wl%tiwai@suse.de>	
	<61c0054e0706201004o2aac3328me0912debd94feba2@mail.gmail.com>	
	<f5boh6$nc4$1@sea.gmane.org>
	<61c0054e0706201209q717489ddvb07f43ee60476fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tomts37-srv.bellnexxia.net (tomts37.bellnexxia.net
	[209.226.175.94])
	by alsa0.perex.cz (Postfix) with ESMTP id 727292439F
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jun 2007 21:37:38 +0200 (CEST)
Received: from toip36-bus.srvr.bell.ca ([67.69.240.37])
	by tomts37-srv.bellnexxia.net
	(InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP id
	<20070620193730.HMND12928.tomts37-srv.bellnexxia.net@toip36-bus.srvr.bell.ca>
	for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2007 15:37:30 -0400
In-Reply-To: <61c0054e0706201209q717489ddvb07f43ee60476fc@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Kavan <pkavan@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



Paul Kavan wrote:
> Frank:
> 
> 
>     Try adding the option "--with-versioned=no" to the alsa-libs configure. 
> 
> 
> That did the trick in terms of the sw params problem. With the default
> alsa.conf file, I can now get the speaker to make some noise. However,
> doing:
> 
> speaker-test -r8000 -f1000 -FS8 -tsine -l5
> 
> gives me a slightly distorted sine wave that has a period of half of
> what I would expect.

Better than no sound :)  At least something is getting through ALSA and
ASoC to your codec.

You may need to adjust the RCMR, RFRM, TCMR, TFRM register settings in
sound/soc/at91/at91-ssc.c to send the data in the mode that your codec
expects.  I have only tested I2S and DSP_A modes with S16_LE data.  It's
fairly easy to add new modes.


> 
> Frank, this is what I have for the small conf. I hope it is the right one:
> 
>
> pcm.!default {
>    type hw
>    card 0
> }
> pcm.hw {
>    type hw
>    card 0
>    device 0
>    subdevice 0
> }
> ctl.!default {
>    type hw
>    card 0
> }
> ctl.hw {
>    type hw
>    card 0
> }
> 
> 
> ctl.w6811 {
>        type hw
>        card 0
> }
> pcm.w6811 {
>        type hw
>        card 0
>        device 0
>        subdevice 0
> }
> 
> ctl.!default    = ctl.w6811
> pcm.!default    = pcm.w6811
> 
> ctl.hw {
>        @args[ CARD ]
>        @args.CARD {
>                type string
>                default "0"
>        }
>        type hw
>        card $CARD
> }
> 
> pcm.hw {
>        @args[ CARD DEV SUBDEV ]
>        @args.CARD {
>                type string
>                default "0"
>        }
>        @args.DEV {
>                type integer
>                default 0
>        }
>        @args.SUBDEV {
>                type integer
>                default 0
>        }
>        type hw
>        card $CARD
>        device $DEV
>        subdevice $SUBDEV
> }
> 
> However, when I use this as the conf, I get the following with aplay -l
> 
> /usr/share/alsa $ aplay -l
> **** List of PLAYBACK Hardware Devices ****
> ALSA lib conf.c:975:(parse_value) card is not a string
> ALSA lib conf.c:1588:(snd_config_load1) _toplevel_:45:1:Invalid argument
> ALSA lib conf.c:3066:(snd_config_update_r) /usr/share/alsa/alsa.conf may
> be old or corrupted: consit
> aplay: device_list:213: control open (0): Invalid argument
> 
> Not sure if I have the alsa.conf correct. So maybe it is a problem
> there. You mentioned a bare bones .conf, but I do not this is the only
> one I have in my email.

I don't see anything wrong with this alsa.conf, but I'm no expert.  It
is virtually the same as the one I am using, but I am using ALSA 1.0.13.

Here is the bare-bones config file that I was using before I added a
second sound device:

pcm.!default {
    type hw
    card 0
}
pcm.hw {
    type hw
    card 0
    device 0
    subdevice 0
}
ctl.!default {
    type hw
    card 0
}
ctl.hw {
    type hw
    card 0
}


../fam
-- 
Frank Mandarino                                fmandarino(a)endrelia.com
Endrelia Technologies Inc.
Toronto, Ontario, Canada
