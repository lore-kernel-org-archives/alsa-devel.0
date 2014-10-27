From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: ALSA - AD1893
Date: Mon, 27 Oct 2014 10:25:46 +0800
Message-ID: <CAN8cciZNX9+uKx8vOLPa+9Eved3CXAvnO6M4xVH9chaTnA+Pkg@mail.gmail.com>
References: <20141026155908.8054.54999.launchpad@chaenomeles.canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f178.google.com (mail-qc0-f178.google.com
 [209.85.216.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 116D326063D
 for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2014 03:25:47 +0100 (CET)
Received: by mail-qc0-f178.google.com with SMTP id b13so3535010qcw.9
 for <alsa-devel@alsa-project.org>; Sun, 26 Oct 2014 19:25:47 -0700 (PDT)
In-Reply-To: <20141026155908.8054.54999.launchpad@chaenomeles.canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Prashant <prashant1277@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

> I am working on Chromium and trying to get a machine with AD1983 to
> function correctly.
>
> I'm on 3.14 kernel.  My issue is that I need a way for CRAS (no pulse)
> to tell HDA driver to switch capture from Front mic to rear Line/Mic.
> The way alsamixer does it, but I want to add that functionality to Cras.
> Could you point my to which IOCTL to call or alsa API to look at?

You have to post the outpout of alsa-info.sh

It depend on the pin default of the rear jack is line in or mic

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/Documentation/sound/alsa/HD-Audio.txt

- line_in_auto_switch (bool): enable/disable the line-in auto-switch
feature; default false

- add_stereo_mix_input (bool): add the stereo mix (analog-loopback mix) to
the input mux if available

- add_jack_modes (bool): add "xxx Jack Mode" enum controls to each I/O jack
for allowing to change the headphone amp and mic bias VREF
  capabilities

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda/patch_analog.c?id=f1e762ddc8035f803d15f8c524151bf788482ec2

Stereo mix was already added to those desktop using VIA or ADI codec when
auto-mic is not enabled

Stereo mix also has input from DAC, line in and mic

node 0x14 Record Selector can also select input from mono mixer node 0xf
(mono mix)

For those HDA codec with one ADC and most AC97 codecs

amixer -c0 cset "Capture Source" "Line"

Any reason to use codec specific ioctl since it won't work on other hda
codec
