From: "Paul Kavan" <pkavan@gmail.com>
Subject: Re: Using aplay and arecord on an ARM
Date: Wed, 20 Jun 2007 14:09:07 -0500
Message-ID: <61c0054e0706201209q717489ddvb07f43ee60476fc@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by alsa0.perex.cz (Postfix) with ESMTP id 7161A24396
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jun 2007 21:09:08 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id o2so412559uge
	for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2007 12:09:07 -0700 (PDT)
In-Reply-To: <f5boh6$nc4$1@sea.gmane.org>
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


Try adding the option "--with-versioned=no" to the alsa-libs configure.


That did the trick in terms of the sw params problem. With the default
alsa.conf file, I can now get the speaker to make some noise. However,
doing:

speaker-test -r8000 -f1000 -FS8 -tsine -l5

gives me a slightly distorted sine wave that has a period of half of what I
would expect.

Frank, this is what I have for the small conf. I hope it is the right one:

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


ctl.w6811 {
       type hw
       card 0
}
pcm.w6811 {
       type hw
       card 0
       device 0
       subdevice 0
}

ctl.!default    = ctl.w6811
pcm.!default    = pcm.w6811

ctl.hw {
       @args[ CARD ]
       @args.CARD {
               type string
               default "0"
       }
       type hw
       card $CARD
}

pcm.hw {
       @args[ CARD DEV SUBDEV ]
       @args.CARD {
               type string
               default "0"
       }
       @args.DEV {
               type integer
               default 0
       }
       @args.SUBDEV {
               type integer
               default 0
       }
       type hw
       card $CARD
       device $DEV
       subdevice $SUBDEV
}

However, when I use this as the conf, I get the following with aplay -l

/usr/share/alsa $ aplay -l
**** List of PLAYBACK Hardware Devices ****
ALSA lib conf.c:975:(parse_value) card is not a string
ALSA lib conf.c:1588:(snd_config_load1) _toplevel_:45:1:Invalid argument
ALSA lib conf.c:3066:(snd_config_update_r) /usr/share/alsa/alsa.conf may be
old or corrupted: consit
aplay: device_list:213: control open (0): Invalid argument

Not sure if I have the alsa.conf correct. So maybe it is a problem there.
You mentioned a bare bones .conf, but I do not this is the only one I have
in my email.

Paul

-- 
***************************************
Paul David Kavan
Project Engineer
GRH Electronics, Inc.
402-734-4900
pkavan@gmail.com
***************************************
