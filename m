From: Dennis Mungai <dmngaie@gmail.com>
Subject: Re: Bug report for: [P7xxDM2(-G), Realtek ALC898,
 issue: Headphone Jack, External] No sound at all
Date: Wed, 17 Jan 2018 01:33:06 +0300
Message-ID: <CAKKYfmGMjEjhuo_MgKUgSS2KWHCGzJMJpPeBGbiuSJD=FoNeoQ@mail.gmail.com>
References: <CAKKYfmEHpTina=bzw_vpSx8inwHUKuhUgfo9C1t+YHCLGcnMOQ@mail.gmail.com>
 <s5h8td3pesk.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f181.google.com (mail-qt0-f181.google.com
 [209.85.216.181])
 by alsa0.perex.cz (Postfix) with ESMTP id E7299266E62
 for <alsa-devel@alsa-project.org>; Tue, 16 Jan 2018 23:33:09 +0100 (CET)
Received: by mail-qt0-f181.google.com with SMTP id 33so20280742qtv.1
 for <alsa-devel@alsa-project.org>; Tue, 16 Jan 2018 14:33:09 -0800 (PST)
In-Reply-To: <s5h8td3pesk.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Cool, thanks!

Rewiring the pins via hdajack retask tool fixes the detection, but still no
sound from the headphones jack is heard. Only the temporary click off the
audio jack when plugged in.

On Jan 12, 2018 11:11, "Takashi Iwai" <tiwai@suse.de> wrote:

> On Thu, 11 Jan 2018 19:21:03 +0100,
> Dennis Mungai wrote:
> >
> > Hello there,
> >
> > I have Ubuntu 16.04LTS installed on the Clevo P751DM2-G, also marketed
> > as the Origin Eon 15-X (Late 2016 model), the System76's Serval WS
> > (2017 model), the Eurocom Sky X4E2, among others.
> >
> > The sound card is the Realtek ALC898 with the following output
> configuration:
> >
> > 1. One SPDIF/headphone combo jack (to the right)
> > 2. One Line Out.
> > 3. One Line-In.
> > 4. One Mic-In.
> >
> > Background information:
> >
> > On Windows, one can use the Realtek HD Audio control panel pop-up menu
> > on jack detection to set the output type when an audio device is
> > plugged in to an appropriate jack, combined with Sound Blaster X-Fi
> > MB5 software to enable post-processing effects such as Bass, noise
> > cancellation, etc.
> >
> > What I have tried so far:
> >
> > 1. Setting the model definition at /etc/modprobe.d/sound.conf with the
> > following entries:
> >
> > options snd-hda-intel model=no-primary-hp enable=1 index=0
> >
> > Using such a line worked before on an MSI GS43VR 6RE Phantom Pro that
> > also has the same (or a similar) ESS Sabre Audio DAC component.
> >
> > Expected behavior:
> >
> > When plugged into the microphone jack, the ESS Sabre DAC should be
> > activated and sound should be routed to the headset.
> >
> > Observed anomaly:
> >
> > Sound comes out through the speakers instead.
> >
> > However, the line-out output works. In that case, when plugged into
> > the line out, Audio works as expected.
>
> Judging from alsa-info.sh output, BIOS doesn't seem to give the proper
> headphone pin (or the headset output), and that's the culprit.
> It's a bug of BIOS.  You can try to figure out the pin and override
> the pin config via hdajackretask or such a tool.
>
>
> Takashi
>
