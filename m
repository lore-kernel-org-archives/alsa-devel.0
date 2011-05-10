From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Multistreaming Playback using Front Panel
 Headphone with realtek codec
Date: Tue, 10 May 2011 08:50:11 +0800
Message-ID: <BANLkTiktUvbP=mmfDqOd-JEzXVLLNWKLfA@mail.gmail.com>
References: <BANLkTimSTYjZoMACA4PoLJa0swo3L2_e4Q@mail.gmail.com>
	<s5hoc3hmq0b.wl%tiwai@suse.de>
	<BANLkTikP+e2Oe_K0yFMJNWmYGdMkdyhN+A@mail.gmail.com>
	<BANLkTim_JYqCiPMaZ+2Ffi+t=1_AuF6KuA@mail.gmail.com>
	<BANLkTi=b-sYz9m2Jvazr8QTHQ+F0H+f5+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D75010380A
	for <alsa-devel@alsa-project.org>;
	Tue, 10 May 2011 02:50:12 +0200 (CEST)
Received: by fxm5 with SMTP id 5so4539874fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 09 May 2011 17:50:12 -0700 (PDT)
In-Reply-To: <BANLkTi=b-sYz9m2Jvazr8QTHQ+F0H+f5+g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/5/9 Valerio tesei <valerio.tesei@gmail.com>

> 2011/5/7 Raymond Yau <superquad.vortex2@gmail.com>
>
> > 2011/5/5 Valerio tesei <valerio.tesei@gmail.com>
> >
> > >
> > > Hi Raymond,
> > >
> > > About my problem, the audio card with the latest patches seems to work
> > (but
> > > great noise when nothing is playing is present, i also tried to mute
> > > everything in alsamixer) so i could say "it works with model=auto"
> >
> >
> > I think it just partially works with model=auto
> >
> This mean that i must wait that some one fix my sound card? I'm not able to
> do this by myself
>


 What about the rear / front problem that make hear only one channel at
> front
> and only one channel at rear is a configuration problem or a driver
> problem?
>
>
you can use hda-analyzer to change the volume slider and mute switch in the
path from [Audio Output] to [Pin Complex] ,the graph show all the connected
path in thick blue line (same as datasheet) and the status line show the
value of those mixers


>
> according to your alsa-info.sh
>
> > I applied the patch, and build the kernel, this is my lastest alsa-info:
> >
> http://www.alsa-project.org/db/?f=61aa4129d0ea771ebc7226ea80c5c3ead24ef05c
>
>
> There are two sets of capture volume/switch and input sources controls but
> only one capture device
>

The auto model need to check whether HDA controller has enough stream for
alt_capture device 2


Can you record from device 2 and device 0 from different mic or line in at
the same time ?

after you force the driver to create device 2

    if (!spec->adc_nids) {
        spec->adc_nids = alc662_adc_nids;
        spec->num_adc_nids = ARRAY_SIZE(alc662_adc_nids);
    }
    if (!spec->capsrc_nids)
        spec->capsrc_nids = alc662_capsrc_nids;

    if (!spec->cap_mixer)
        set_capture_mixer(codec);

+    spec->stream_analog_alt_capture = &alc880_pcm_analog_alt_capture;

if not, the driver may need to mute and remove the controls of second ADC





> >
> >
> > What kind of noise ?
> >
> > Do you mean that the noise can be hear in HP and all audio jacks at rear
> > panel ?
> >
> >
> > > So i made the test, i correctly hear the tests, 7 outputs for the rear
> > > panel, and 2 for the front, but when i play the first test, i hear on
> > > the front panel some noise and realy crackly and whispered the tests
> > > when front left and front right are played, i guess it is not normal,
> > > may this help?
>



if you turn on "Independent HP" but still hear sound when you are playing
sound to rear panel,

The logic in snd_hda_multi_out_analog_prep()
1) set up line_out[0] to use Front DAC
2) set up HP if (!mout->no_share_stream &&
        mout->hp_nid && mout->hp_nid != nids[HDA_FRONT])
3) copy front to extra out  if (!mout->no_share_stream &&
mout->extra_out_nid[i])
4) setup other line_out up to request channel
5) copy front to remain line_out

so you need to check the system log  whether the correct [Audio Output] are
used in 2, 4, 6, 8 channels playback

when playing stereo, the left channel  is copy to the center and the right
channel is copy to the subwoofer for the orange jack. because of (5)


My patch is based on "auto" model can create a "Headphone Playback Volume"
on a DAC which is not already used by multi_out (rear panel jacks for
multichannel playback)

The "Independent HP" is off by default so it is as same as the original
model="auto"
so mout->hp_nid must not be null


Node 0x1b [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
 Amp-In vals: [0x00 0x00]
 Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
 Amp-Out vals: [0x00 0x00]
 Pincap 0x0001373e: IN OUT HP EAPD Detect Trigger
 Vref caps: HIZ 50 GRD 80 100
 EAPD 0x2: EAPD
 Pin Default 0x02214820: [Jack] HP Out at Ext Front
 Conn = 1/8, Color = Green
 DefAssociation = 0x2, Sequence = 0x0
 Pin-ctls: 0xc0: OUT HP VREF_HIZ
 Unsolicited: tag=04, enabled=1
 Power states: D0 D1 D2 D3 EPSS
 Power: setting=D0, actual=D0
 Connection: 5
 0x0c 0x0d 0x0e 0x0f 0x26*

If the noise already appear with model=auto without my patch

a) you can force the driver connect HP to 0x0c (the mixer of Front DAC) ,
but there won't be any "Headphone Volume Control" in this path


static int alc662_auto_create_extra_out(struct hda_codec *codec, hda_nid_t
pin,
                    const char *pfx)
{
    struct alc_spec *spec = codec->spec;
    hda_nid_t nid, mix;
    int err;

    if (!pin)
        return 0;
    nid = alc_auto_look_for_dac(codec, pin);
+   nid = 0;
    if (!nid) {



b) you can disable the copy front mode by

comment the code related to 3) and 5)

c) study the info about anti -pop mode (EPSS) in the datasheet

d) disable the unsolicited event for hp automute

e) disable sticky stream

spec->no_sticky_stream = 1
