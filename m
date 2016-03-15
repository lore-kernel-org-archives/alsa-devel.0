From: Micka <mickamusset@gmail.com>
Subject: Max9768 driver in kernel 4.1
Date: Tue, 15 Mar 2016 07:27:09 +0000
Message-ID: <CAF+MRt=Qg3ko86_8r+LkkD=yw6k_d+jV_Q21Sa6-Yxqb+vL68g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com [74.125.82.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 287302607F7
 for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2016 08:27:19 +0100 (CET)
Received: by mail-wm0-f48.google.com with SMTP id p65so12966216wmp.0
 for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2016 00:27:19 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I'm trying to use the max9768,

I have defined it correctly in the dts file :

max9768: max9768@49 {
compatible = "max,max9768";
reg = <0x49>;
};

I can see that in the driver, i go in the function max9768_i2c_probe
<http://lxr.free-electrons.com/ident?v=4.1;i=max9768_i2c_probe> without
problem, and I don't see errors when executing this line :

 err <http://lxr.free-electrons.com/ident?v=4.1;i=err> =
snd_soc_register_codec
<http://lxr.free-electrons.com/ident?v=4.1;i=snd_soc_register_codec>(&client
<http://lxr.free-electrons.com/ident?v=4.1;i=client>->dev
<http://lxr.free-electrons.com/ident?v=4.1;i=dev>,
&max9768_codec_driver
<http://lxr.free-electrons.com/ident?v=4.1;i=max9768_codec_driver>,
NULL <http://lxr.free-electrons.com/ident?v=4.1;i=NULL>, 0);


I have put some log :

[    9.213797] ASoC: dai register 2-0049 #0
[    9.213806] ASoC: Registered codec 'max9768.2-0049'


my problem is that i don't know how to configure the volume ? Any idea ?
where is it ?

I don't see where is it in the amixer controls list :

root@beaglebone:~# amixer controls
numid=1,iface=MIXER,name='PCM Playback Volume'
numid=15,iface=MIXER,name='Line DAC Playback Volume'
numid=14,iface=MIXER,name='Line PGA Bypass Volume'
numid=20,iface=MIXER,name='Line Playback Switch'
numid=33,iface=MIXER,name='ADC HPF Cut-off'
numid=23,iface=MIXER,name='AGC Switch'
numid=30,iface=MIXER,name='De-emphasis Switch'
numid=17,iface=MIXER,name='HP DAC Playback Volume'
numid=16,iface=MIXER,name='HP PGA Bypass Volume'
numid=21,iface=MIXER,name='HP Playback Switch'
numid=19,iface=MIXER,name='HPCOM DAC Playback Volume'
numid=18,iface=MIXER,name='HPCOM PGA Bypass Volume'
numid=22,iface=MIXER,name='HPCOM Playback Switch'
numid=26,iface=MIXER,name='Left AGC Attack time'
numid=28,iface=MIXER,name='Left AGC Decay time'
numid=24,iface=MIXER,name='Left AGC Target level'
numid=75,iface=MIXER,name='Left DAC Mux'
numid=49,iface=MIXER,name='Left HP Mixer DACL1 Switch'
numid=7,iface=MIXER,name='Left HP Mixer DACR1 Playback Volume'
numid=51,iface=MIXER,name='Left HP Mixer DACR1 Switch'
numid=48,iface=MIXER,name='Left HP Mixer PGAL Bypass Switch'
numid=50,iface=MIXER,name='Left HP Mixer PGAR Bypass Switch'
numid=6,iface=MIXER,name='Left HP Mixer PGAR Bypass Volume'
numid=41,iface=MIXER,name='Left HPCOM Mixer DACL1 Switch'
numid=11,iface=MIXER,name='Left HPCOM Mixer DACR1 Playback Volume'
numid=43,iface=MIXER,name='Left HPCOM Mixer DACR1 Switch'
numid=40,iface=MIXER,name='Left HPCOM Mixer PGAL Bypass Switch'
numid=42,iface=MIXER,name='Left HPCOM Mixer PGAR Bypass Switch'
numid=10,iface=MIXER,name='Left HPCOM Mixer PGAR Bypass Volume'
numid=74,iface=MIXER,name='Left HPCOM Mux'
numid=57,iface=MIXER,name='Left Line Mixer DACL1 Switch'
numid=3,iface=MIXER,name='Left Line Mixer DACR1 Playback Volume'
numid=59,iface=MIXER,name='Left Line Mixer DACR1 Switch'
numid=56,iface=MIXER,name='Left Line Mixer PGAL Bypass Switch'
numid=58,iface=MIXER,name='Left Line Mixer PGAR Bypass Switch'
numid=2,iface=MIXER,name='Left Line Mixer PGAR Bypass Volume'
numid=71,iface=MIXER,name='Left Line1L Mux'
numid=70,iface=MIXER,name='Left Line1R Mux'
numid=64,iface=MIXER,name='Left PGA Mixer Line1L Switch'
numid=65,iface=MIXER,name='Left PGA Mixer Line1R Switch'
numid=66,iface=MIXER,name='Left PGA Mixer Mic2L Switch'
numid=67,iface=MIXER,name='Left PGA Mixer Mic2R Switch'
numid=34,iface=MIXER,name='Output Driver Power-On time'
numid=35,iface=MIXER,name='Output Driver Ramp-up step'
numid=32,iface=MIXER,name='PGA Capture Switch'
numid=31,iface=MIXER,name='PGA Capture Volume'
numid=27,iface=MIXER,name='Right AGC Attack time'
numid=29,iface=MIXER,name='Right AGC Decay time'
numid=25,iface=MIXER,name='Right AGC Target level'
numid=73,iface=MIXER,name='Right DAC Mux'
numid=9,iface=MIXER,name='Right HP Mixer DACL1 Playback Volume'
numid=45,iface=MIXER,name='Right HP Mixer DACL1 Switch'
numid=47,iface=MIXER,name='Right HP Mixer DACR1 Switch'
numid=44,iface=MIXER,name='Right HP Mixer PGAL Bypass Switch'
numid=8,iface=MIXER,name='Right HP Mixer PGAL Bypass Volume'
numid=46,iface=MIXER,name='Right HP Mixer PGAR Bypass Switch'
numid=13,iface=MIXER,name='Right HPCOM Mixer DACL1 Playback Volume'
numid=37,iface=MIXER,name='Right HPCOM Mixer DACL1 Switch'
numid=39,iface=MIXER,name='Right HPCOM Mixer DACR1 Switch'
numid=36,iface=MIXER,name='Right HPCOM Mixer PGAL Bypass Switch'
numid=12,iface=MIXER,name='Right HPCOM Mixer PGAL Bypass Volume'
numid=38,iface=MIXER,name='Right HPCOM Mixer PGAR Bypass Switch'
numid=72,iface=MIXER,name='Right HPCOM Mux'
numid=5,iface=MIXER,name='Right Line Mixer DACL1 Playback Volume'
numid=53,iface=MIXER,name='Right Line Mixer DACL1 Switch'
numid=55,iface=MIXER,name='Right Line Mixer DACR1 Switch'
numid=52,iface=MIXER,name='Right Line Mixer PGAL Bypass Switch'
numid=4,iface=MIXER,name='Right Line Mixer PGAL Bypass Volume'
numid=54,iface=MIXER,name='Right Line Mixer PGAR Bypass Switch'
numid=69,iface=MIXER,name='Right Line1L Mux'
numid=68,iface=MIXER,name='Right Line1R Mux'
numid=61,iface=MIXER,name='Right PGA Mixer Line1L Switch'
numid=60,iface=MIXER,name='Right PGA Mixer Line1R Switch'
numid=62,iface=MIXER,name='Right PGA Mixer Mic2L Switch'
numid=63,iface=MIXER,name='Right PGA Mixer Mic2R Switch'


Thank you for your work and help !
