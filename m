From: Dan MacDonald <allcoms@gmail.com>
Subject: Re: CM6206, S/PDIF + JACK
Date: Tue, 13 Nov 2012 21:46:31 +0000
Message-ID: <CANOoOju1RjMdutspkvE23sErr7x-B-gbq5jVk4r3KS02vbx4Bg@mail.gmail.com>
References: <CANOoOjsvRWz6N7eUgJRyFohqih4_d9-sCXhHpWs3M7i4wXjbWQ@mail.gmail.com>
 <50A2434A.8000803@ladisch.de>
 <CANOoOjtGq5OYYkhVHrxivCSrPmvzid1_-vbvuzDtgDqChUHTSQ@mail.gmail.com>
 <50A2BACE.80107@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
 [209.85.212.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 256B3265230
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2012 22:46:35 +0100 (CET)
Received: by mail-vb0-f51.google.com with SMTP id fn1so7623028vbb.38
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2012 13:46:34 -0800 (PST)
In-Reply-To: <50A2BACE.80107@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Clemens!

I've at least tested SPDIF in under Windows now so I know its not a
hardware issue here.


On Tue, Nov 13, 2012 at 9:25 PM, Clemens Ladisch <clemens@ladisch.de> wrote:

> Dan MacDonald wrote:
> > However, I had a quick go at capturing audio from SPDIF and the default
> > stereo inputs (after making sure SPDIF in was enabled under alsamixer)
> >  this morning but I got nothing. I have zero experience with SPDIF
> devices
> > and Linux (or any other OS) so I dunno what to watch out for
>
> This depends entirely on how the hardware implements the routing.
>
> > In my quick test I was trying to capture audio from a audio CDR so there
> > won't have been any copy protection on the disc. CDs are 44.1Khz of
> course
> > but I was running JACK at 48Khz - that shouldn't be an issue should it or
> > would I need to run JACK at 44.1 to capture an audio CD via SPDIF? Maybe
> rt
> > resampling isn't supported?
>
> I didn't find a box labeled "high-quality resampler for those lazy Jack
> users" in the datasheet ...
>

Hehe! :)

but the box for this card says "Hard to find made easy" on every face!


>
> > Another thing thats just come to mind is I think that the mic and line
> > inputs were also set to capture so maybe I'd need to only enable capture
> > for the SPDIF input but nothing else?
>
> In theory, only one input can be enabled at the same time.
> What does "amixer contents" show for this device?
>
>
> Regards,
> Clemens
>

amixer -c 1 contents
numid=14,iface=MIXER,name='PCM Capture Source'
  ; type=ENUMERATED,access=rw------,values=1,items=4
  ; Item #0 'Mic'
  ; Item #1 'Line'
  ; Item #2 'IEC958 In'
  ; Item #3 'Mixer'
  : values=0
numid=12,iface=MIXER,name='PCM Capture Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=13,iface=MIXER,name='PCM Capture Volume'
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=6928,step=0
  : values=4096,4096
  | dBminmax-min=-16.00dB,max=11.06dB
numid=3,iface=MIXER,name='Line Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=4,iface=MIXER,name='Line Playback Volume'
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=8065,step=0
  : values=6144,6144
  | dBminmax-min=-24.00dB,max=7.50dB
numid=9,iface=MIXER,name='Line Capture Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=10,iface=MIXER,name='Line Capture Volume'
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=6928,step=0
  : values=4096,4096
  | dBminmax-min=-16.00dB,max=11.06dB
numid=1,iface=MIXER,name='Mic Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=2,iface=MIXER,name='Mic Playback Volume'
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=8065,step=0
  : values=6144,6144
  | dBminmax-min=-24.00dB,max=7.50dB
numid=7,iface=MIXER,name='Mic Capture Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=8,iface=MIXER,name='Mic Capture Volume'
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=6928,step=0
  : values=4096,4096
  | dBminmax-min=-16.00dB,max=11.06dB
numid=11,iface=MIXER,name='IEC958 In Capture Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=5,iface=MIXER,name='Speaker Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=6,iface=MIXER,name='Speaker Playback Volume'
  ; type=INTEGER,access=rw---R--,values=8,min=0,max=197,step=0
  : values=196,196,196,196,196,196,196,196
  | dBminmax-min=-36.93dB,max=0.00dB


Thanks Clemens!
