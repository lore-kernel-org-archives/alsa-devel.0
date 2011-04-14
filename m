From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH ALSA HDA 1/1] Fix alc662_dac_nid and change
 6stack-dig to 5stack-dig
Date: Thu, 14 Apr 2011 19:11:20 +0800
Message-ID: <BANLkTik57-t7OH=JUC7wv0aMFuVRX2735A@mail.gmail.com>
References: <BANLkTim-aFLPMDOsoBG+ifynovDgT8LO3g@mail.gmail.com>
	<s5h8vvnrjea.wl%tiwai@suse.de>
	<BANLkTimfTLnPCt2e1gw7tdgpd=omBzbW6A@mail.gmail.com>
	<s5hy63nq12a.wl%tiwai@suse.de>
	<BANLkTinCh8+93jgcUrVP5J=u6XK3xbZOqg@mail.gmail.com>
	<s5htyeb9180.wl%tiwai@suse.de>
	<BANLkTikVQtpzCNX4W6MxAScMHzx_f6FAeA@mail.gmail.com>
	<BANLkTikhM1i8PK8HC9yN6d8yevx982CwGw@mail.gmail.com>
	<BANLkTimcFQRMmjT9+FhJXnkNqNQPTMHZNQ@mail.gmail.com>
	<BANLkTikX4FtPEdsPKP-2wa=aLVyU3ibJHA@mail.gmail.com>
	<4DA3566E.6000600@gmail.com>
	<BANLkTimpWyUR5H7DRk3JEg+qMcZp45=2=A@mail.gmail.com>
	<BANLkTi=4wGJSDGOWwrFHMhd9w17tWvbrNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 06ACF103807
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Apr 2011 13:11:21 +0200 (CEST)
Received: by fxm5 with SMTP id 5so1293369fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 14 Apr 2011 04:11:21 -0700 (PDT)
In-Reply-To: <BANLkTi=4wGJSDGOWwrFHMhd9w17tWvbrNQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

2011/4/13 Valerio tesei <valerio.tesei@gmail.com>

>
>
> Yes but my motherboard is ASUS P7H55D-M PRO not ASUS P7H55-M PRO i
> dont know the exact differences between h55d and h55 (i think only a
> 'deluxe' on the package)
> On Asus compare, differences are about gigabit lan (realtek obviusly)
> on p7h55d-pro and more "asus unique features" on p7h55d-pro (wasted
> money to get nothing more than value mobo)
> This is my back panel :
> http://img40.imageshack.us/img40/8864/asusp7h55dmpro1156ddr3m.jpg
> seems the same as p7h55-pro
>  are out of my skills.
> I will revert sound-2.6-git changes (printk and patch you suggested
> above), create a new alsa-info, dump the graph by hda-analyzer tool, I
> will post all these things later (when back home)
> Anyway, all of you make a great work. I realy appreciate. Thanks All.
>

I guess those patches are ok since those connections are also unmuted in my
10 channels ad1988a

As alc892 datasheet is available at realtek web site , no need to use
codecgraph, just look at the Block diagram and you will able to find out
those inputs pins (e.g. Front Mic, Rear Mic ,... ) connected through 0x0b to
those output pins


Takashi  ,
 Is it correct to set spec->multiout.hp_nid = 0 or
spec->multiout.no_share_stream in order to disable the multiout to use hp
dac

and use alt_dac_nid and stream_analog_alt_playback to enable Front Panel HP
playback (multistream playback) like those intel desktop videos ?

This assign headphone and mic at front panel to alt_playback and alt_capture
"hw:0,2"


    if (!spec->cap_mixer)
        set_capture_mixer(codec);

+    if (codec->vendor_id == 0x10ec0892) {
+/* enable multistream for front panel hp */
+       if (spec->multiout.hp_nid && spec->autocfg.line_outs == 4) {
+           spec->alt_dac_nid = spec->multiout.hp_nid;
+           spec->multiout.hp_nid = 0;
+           spec->stream_analog_alt_playback =
&alc880_pcm_analog_alt_playback;
+       }
+        if (spec->num_adc_nids>1 && spec->autocfg.num_inputs > 2)
+            spec->stream_analog_alt_capture =
&alc880_pcm_analog_alt_capture;
+   }

    if (has_cdefine_beep(codec)) {
