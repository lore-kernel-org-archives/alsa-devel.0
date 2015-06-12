From: Nicolae Rosia <nicolae.rosia@gmail.com>
Subject: Re: Intel HDA & Realtek issues on ASUS G751JM
Date: Fri, 12 Jun 2015 22:22:40 +0300
Message-ID: <CAH=tA9G45ci85VvD1ZceiEcM3sp+3FKtA1B8LimENEVcC-dtFw@mail.gmail.com>
References: <CAH=tA9HdRbRrLrKW+OeYUibjs3StwmKOUD_6p=WMu5LDK4VYzg@mail.gmail.com>
 <s5hzj47n9d1.wl-tiwai@suse.de>
 <CAH=tA9FR7vb+dFS2Mzpd7RJGrbGNRAjj9pM3BCsdVxzG_i0YAA@mail.gmail.com>
 <s5h616ul6o5.wl-tiwai@suse.de>
 <CAH=tA9E_D7Nt0iS8j9GXp3duDYN=xDn5aDt2O_cZuf1gFRArJQ@mail.gmail.com>
 <CAN8ccib4f0O5TW6Z=QzrSoRkp=EA-Km6z15TTh+HXb5me-=+NQ@mail.gmail.com>
 <CAH=tA9FE_fNf9GtmxHTwA8+4EjMS31iYRoTZcroCLAbEZpn38w@mail.gmail.com>
 <CAN8cciY8A-ecJVYyPKoRqZad+HhpOCvFtxdrrA=yTrk_q7QitQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f196.google.com (mail-lb0-f196.google.com
 [209.85.217.196])
 by alsa0.perex.cz (Postfix) with ESMTP id DF7282604D3
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 21:22:40 +0200 (CEST)
Received: by lbio15 with SMTP id o15so3631749lbi.0
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 12:22:40 -0700 (PDT)
In-Reply-To: <CAN8cciY8A-ecJVYyPKoRqZad+HhpOCvFtxdrrA=yTrk_q7QitQ@mail.gmail.com>
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

On Fri, Jun 12, 2015 at 5:34 AM, Raymond Yau
<superquad.vortex2@gmail.com> wrote:
> Do you mean hdajackretask cannot shutdown pulseaudio or you still have other
> applicaion using the sound card which prevent dynamic reconfiguration of
> snd-hda-intel ?
>
I was testing using a browser on a youtube video. When I apply the
changes, I lose the sound (pulseaudio gets killed), that message
appears and I have to refresh the page to get sound again - but
nothing changes.

>
> Can you post the output of alsa-info.sh after you patched the line out jacks
> ?
http://www.alsa-project.org/db/?f=82a057b76a781edb53217b2cc096bce35459ab0a

> Which node is the headphone spdif combo jack ?
>
Using hdajacksensetest I found out the mapping:
SPDIF port (jack 1): Pin 0x16 (Green Line Out, Rear side)
jack 2: Pin 0x18 (Green Line Out, Rear side)
jack 3: Pin 0x15 (Green Line Out, Rear side)

> Do both headphone jacks have headphone , headset  or line out icon ?
You can see the icons here [0] at page 20

> Do you mean switch to 5.1 profile in sound preference is not enough ?
By listening on Youtube I can't hear the center and subwoofer without
modifying the pulseaudio conf

[0] http://dlcdnet.asus.com/pub/ASUS/nb/G751JM/0409_E9481.pdf?_ga=1.206896403.1230956712.1434110719
