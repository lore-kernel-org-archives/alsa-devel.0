From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Intel HDA & Realtek issues on ASUS G751JM
Date: Fri, 12 Jun 2015 10:34:41 +0800
Message-ID: <CAN8cciY8A-ecJVYyPKoRqZad+HhpOCvFtxdrrA=yTrk_q7QitQ@mail.gmail.com>
References: <CAH=tA9HdRbRrLrKW+OeYUibjs3StwmKOUD_6p=WMu5LDK4VYzg@mail.gmail.com>
 <s5hzj47n9d1.wl-tiwai@suse.de>
 <CAH=tA9FR7vb+dFS2Mzpd7RJGrbGNRAjj9pM3BCsdVxzG_i0YAA@mail.gmail.com>
 <s5h616ul6o5.wl-tiwai@suse.de>
 <CAH=tA9E_D7Nt0iS8j9GXp3duDYN=xDn5aDt2O_cZuf1gFRArJQ@mail.gmail.com>
 <CAN8ccib4f0O5TW6Z=QzrSoRkp=EA-Km6z15TTh+HXb5me-=+NQ@mail.gmail.com>
 <CAH=tA9FE_fNf9GtmxHTwA8+4EjMS31iYRoTZcroCLAbEZpn38w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f172.google.com (mail-ob0-f172.google.com
 [209.85.214.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DFD0266640
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 04:34:42 +0200 (CEST)
Received: by obbgp2 with SMTP id gp2so14867111obb.2
 for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2015 19:34:41 -0700 (PDT)
In-Reply-To: <CAH=tA9FE_fNf9GtmxHTwA8+4EjMS31iYRoTZcroCLAbEZpn38w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolae Rosia <nicolae.rosia@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
> Thank you very much!
> I have compiled hdajacksensetest from source and found out that one
> pin was marked as Not connected even though it was present, and
> another one was marked as Microphone.
> I have used hdajackretask to force the retask at boot time (it didn't
> work at runtime - it always displays tee:
> /sys/class/sound/hwC1D0/reconfig: Device or resource busy) and now it
> looks like this:

Do you mean hdajackretask cannot shutdown pulseaudio or you still have
other applicaion using the sound card which prevent dynamic reconfiguration
of snd-hda-intel ?

> ./hdajacksensetest -c 1 -a
> Pin 0x12 (Internal Mic): present = No
> Pin 0x14 (Internal Speaker): present = No
> Pin 0x15 (Green Line Out, Rear side): present = Yes
> Pin 0x16 (Green Line Out, Rear side): present = Yes
> Pin 0x18 (Green Line Out, Rear side): present = Yes
> Pin 0x19 (Not connected): present = No
> Pin 0x1a (Internal Speaker): present = No
> Pin 0x1b (Not connected): present = No
> Pin 0x1d (Not connected): present = No
> Pin 0x1e (Internal SPDIF Out): present = No
> Pin 0x1f (Not connected): present = No

Can you post the output of alsa-info.sh after you patched the line out
jacks ?

Which node is the headphone spdif combo jack ?

Do both headphone jacks have headphone , headset  or line out icon ?

The normal fix is to add back the missing headphone jacks

>
> After this, I have modified the pulseaudio config,
> /etc/pulse/daemon.conf, by adding the following:
> default-sample-channels = 6
> enable-lfe-remixing = yes
> and 5.1 works!
>
> How can we fix this for other owners?

Do you mean switch to 5.1 profile in sound preference is not enough ?
>
>
