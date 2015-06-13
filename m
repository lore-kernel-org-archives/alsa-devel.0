From: Nicolae Rosia <nicolae.rosia@gmail.com>
Subject: Re: Intel HDA & Realtek issues on ASUS G751JM
Date: Sat, 13 Jun 2015 10:45:26 +0300
Message-ID: <CAH=tA9ECWF9WaeJvJcT3D-uXqr-r4Zp+TmBD88GJ6YhxQztJxA@mail.gmail.com>
References: <CAH=tA9HdRbRrLrKW+OeYUibjs3StwmKOUD_6p=WMu5LDK4VYzg@mail.gmail.com>
 <s5hzj47n9d1.wl-tiwai@suse.de>
 <CAH=tA9FR7vb+dFS2Mzpd7RJGrbGNRAjj9pM3BCsdVxzG_i0YAA@mail.gmail.com>
 <s5h616ul6o5.wl-tiwai@suse.de>
 <CAH=tA9E_D7Nt0iS8j9GXp3duDYN=xDn5aDt2O_cZuf1gFRArJQ@mail.gmail.com>
 <CAN8ccib4f0O5TW6Z=QzrSoRkp=EA-Km6z15TTh+HXb5me-=+NQ@mail.gmail.com>
 <CAH=tA9FE_fNf9GtmxHTwA8+4EjMS31iYRoTZcroCLAbEZpn38w@mail.gmail.com>
 <CAN8cciY8A-ecJVYyPKoRqZad+HhpOCvFtxdrrA=yTrk_q7QitQ@mail.gmail.com>
 <CAH=tA9G45ci85VvD1ZceiEcM3sp+3FKtA1B8LimENEVcC-dtFw@mail.gmail.com>
 <CAN8cciaQhhP3P-LU2KFJ8mCSTk5tcroEKpDMh4g_dtMkxV_q0A@mail.gmail.com>
 <CAN8ccib13ygePJWmQiQvmt-4wt49GnJ2BYVLAUKFckNNk0mf5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com
 [209.85.217.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 37E4426059C
 for <alsa-devel@alsa-project.org>; Sat, 13 Jun 2015 09:45:27 +0200 (CEST)
Received: by lblr1 with SMTP id r1so2975186lbl.0
 for <alsa-devel@alsa-project.org>; Sat, 13 Jun 2015 00:45:26 -0700 (PDT)
In-Reply-To: <CAN8ccib13ygePJWmQiQvmt-4wt49GnJ2BYVLAUKFckNNk0mf5A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Jun 13, 2015 at 6:14 AM, Raymond Yau
<superquad.vortex2@gmail.com> wrote:
> If your specifcaion and user guide does not mention the support of surround
> 5.1
>
> You need to find out the internal subwoofer use both channel or just left or
> right
>
> speaker-test -c4 -t wav -D hw:0,0
>
> If you hear high frequency from subwoofer, this mean you need software low
> pass filtter
>
After removing all jacks and testing with speaker-test -c 4 -t wav -D hw:1,0

speaker-test 1.0.29

Playback device is hw:1,0
Stream parameters are 48000Hz, S16_LE, 4 channels
WAV file(s)
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 32 to 524288
Period size range from 16 to 262144
Using max buffer size 524288
Periods = 4
was set period_size = 131072
was set buffer_size = 524288
 0 - Front Left
 1 - Front Right
 3 - Rear Right
 2 - Rear Left
^CTime per period = 9.384977

I can hear high frequency from internal subwoofer while speaker-test
printed 3 and 2.

> Two headphone jacks, internal speaker and subwoofer
>
> There are only three playback volume controls
>
> http://mailman.alsa-project.org/pipermail/alsa-devel/2015-June/093668.html
>
> Your case are
>
> A. 3 DACs, 2 HP, 2 speakers
>
> Node 0x1a [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
>   Control: name="Bass Speaker Playback Switch", index=0, device=0
>     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
>   Control: name="Speaker Surround Phantom Jack", index=0, device=0
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x80 0x80]
>   Pincap 0x0000373c: IN OUT HP Detect
>     Vref caps: HIZ 50 GRD 80 100
>   Pin Default 0x90170130: [Fixed] Speaker at Int N/A
>     Conn = Analog, Color = Unknown
>     DefAssociation = 0x3, Sequence = 0x0
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x00: VREF_HIZ
>   Unsolicited: tag=00, enabled=0
>   Power states:  D0 D1 D2 D3 EPSS
>   Power: setting=D0, actual=D0
>   Connection: 3
>      0x0c 0x0d* 0x0e
