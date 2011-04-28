From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: dB range of emu10k1 hda-intel
Date: Thu, 28 Apr 2011 20:49:06 +0800
Message-ID: <BANLkTikAaHECMZH1MfRnRCxKqsB6oY5d9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id CD7211037FF
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Apr 2011 14:49:06 +0200 (CEST)
Received: by fxm5 with SMTP id 5so2082686fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 28 Apr 2011 05:49:06 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/4/26 Takashi Iwai <tiwai@suse.de>

>
>
> > Is it a bug for PA server to add TLV_DB_GAIN_MUTE - infinite dB range of
> > "Front" and "Surround" and those finite dB range of "Master" and "PCM" ?
>
> Hrm, not sure.  Could you elaborate?
>
>

Should the application add the dB range of Virtual Master and the dB range
of the slave for HDA-Intel ?

Correct me if I am wrong

PA server seem use  -168.00 dB to 0.00 dB. for hda-intel

For ad1988   spec->vmaster_nid = 0x04;

"Virtual Master" + "Front" + "PCM Softvol"  = 58.5 + 58.5 + 51 = 168

state.Intel {
    control.1 {
        iface MIXER
        name 'Front Playback Volume'
        value.0 39
        value.1 39
        comment {
            access 'read write'
            type INTEGER
            count 2
            range '0 - 39'
            dbmin -5850
            dbmax 0
            dbvalue.0 0
            dbvalue.1 0
        }
    }

D: alsa-mixer.c: Activating path analog-output
D: alsa-mixer.c: Path analog-output (Analog Output), direction=1,

priority=99, probed=yes, supported=yes, has_mute=yes, has_volume=yes,
has_dB=yes, min_volume=0, max_volume=39, min_dB=-168, max_dB=0
D: alsa-mixer.c: Element Master, direction=1, switch=1, volume=1,
volume_limit=-1, enumeration=0, required=0, required_any=0,

required_absent=0, mask=0x7ffffffffffff, n_channels=1, override_map=yes
D: alsa-mixer.c: Element Headphone, direction=1, switch=1, volume=0,
volume_limit=-1, enumeration=0, required=0, required_any=0,
required_absent=0, mask=0x0, n_channels=0, override_map=no

D: alsa-mixer.c: Element Front, direction=1, switch=1, volume=1,
volume_limit=-1, enumeration=0, required=0, required_any=0,
required_absent=0, mask=0x6, n_channels=2, override_map=yes
D: alsa-mixer.c: Element Surround, direction=1, switch=1, volume=1,

volume_limit=-1, enumeration=0, required=0, required_any=0,
required_absent=0, mask=0x60, n_channels=2, override_map=yes
D: alsa-mixer.c: Element Side, direction=1, switch=1, volume=1,
volume_limit=-1, enumeration=0, required=0, required_any=0,

required_absent=0, mask=0xc00, n_channels=2, override_map=yes
D: alsa-mixer.c: Element Center, direction=1, switch=1, volume=1,
volume_limit=-1, enumeration=0, required=0, required_any=0,
required_absent=0, mask=0x4900000000018, n_channels=1, override_map=yes

D: alsa-mixer.c: Element LFE, direction=1, switch=1, volume=1,
volume_limit=-1, enumeration=0, required=0, required_any=0,
required_absent=0, mask=0x80, n_channels=1, override_map=yes
D: alsa-mixer.c: Element PCM, direction=1, switch=0, volume=1,

volume_limit=-1, enumeration=0, required=0, required_any=0,
required_absent=0, mask=0x3600000000f66, n_channels=2, override_map=yes
I: alsa-sink.c: Hardware volume ranges from -168.00 dB to 0.00 dB.






The dB range of emu10k1 calculated by PA server is (-100081dB to +12 dB)

"AC97 Master" + "AC97 PCM" + "Front" = 46.5 + 46.5  + 99999.99 = 100093


D: alsa-mixer.c: Activating path analog-output

D: alsa-mixer.c: Path analog-output (Analog Output), direction=1,
priority=99, probed=yes, supported=yes, has_mute=yes, has_volume=yes,
has_dB=yes, min_volume=0, max_volume=31, min_dB=-100081, max_dB=12
D: alsa-mixer.c: Element Master, direction=1, switch=1, volume=1,

volume_limit=-1, enumeration=0, required=0, required_any=0,
required_absent=0, mask=0x3600000000f66, n_channels=2, override_map=yes
D: alsa-mixer.c: Element Surround, direction=1, switch=0, volume=1,
volume_limit=-1, enumeration=0, required=0, required_any=0,

required_absent=0, mask=0x60, n_channels=2, override_map=yes
D: alsa-mixer.c: Element PCM, direction=1, switch=1, volume=1,
volume_limit=-1, enumeration=0, required=0, required_any=0,
required_absent=0, mask=0x3600000000f66, n_channels=2, override_map=yes

D: alsa-mixer.c: Element External Amplifier, direction=1, switch=4,
volume=0, volume_limit=-1, enumeration=0, required=0, required_any=0,
required_absent=0, mask=0x0, n_channels=0, override_map=no
D: alsa-mixer.c: Option on (output-amplifier-on/Amplifier) index=1,

priority=10
D: alsa-mixer.c: Option off (output-amplifier-off/No Amplifier) index=0,
priority=0
D: alsa-mixer.c: Setting output-amplifier-on (Amplifier) priority=10
D: alsa-mixer.c: Setting output-amplifier-off (No Amplifier) priority=0

I: alsa-sink.c: Hardware volume ranges from -100080.99 dB to 12.00 dB.
