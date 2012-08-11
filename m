From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: HDA Mono out
Date: Sat, 11 Aug 2012 20:19:43 +0800
Message-ID: <CAN8cciaj=yM3Gk6yKF+4r1ip8QXoKNgxHUqtjUVqWXihjQjEsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f44.google.com (mail-qa0-f44.google.com
 [209.85.216.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 8036E264EF8
 for <alsa-devel@alsa-project.org>; Sat, 11 Aug 2012 13:49:58 +0200 (CEST)
Received: by qadb17 with SMTP id b17so459282qad.17
 for <alsa-devel@alsa-project.org>; Sat, 11 Aug 2012 05:19:43 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: pulseaudio-discuss@list.freedesktop.org
List-Id: alsa-devel@alsa-project.org

How can the driver differentiate those mono internal chassis speaker of
desktop from those subwoofer speaker of laptop?

https://launchpadlibrarian.net/34863455/Card0.Codecs.codec.2.txt

Node 0x13 [Pin Complex] wcaps 0x40010c: Mono Amp-Out
Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x00]
  Pincap 0x00000010: OUT
  Pin Default 0x911711f0: [Fixed] Speaker at Int Rear
   Conn = Analog, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x2d

refer to the patch

hda: Added mono_out_pin to autoconfig

Added a mono_out_pin field to autocfg struct, and code to parse for the
mono_out_line.

http://git.kernel.org/?p=linux/kernel/git/tiwai/sound.git;a=blobdiff;f=sound/pci/hda/hda_codec.c;h=df927be176af87e1f262b4a6b0809fe1ef0ed757;hp=f6a9a5dd9b7459d13527d0ead11db2a03160e6cb;hb=90da78bf6aaabd4d31c6663b7c1d1b9c5a8c023f;hpb=cd93dc8ccad8680f104c9134ae73888feb14e946

does any computer really has the mono jack using the mono pin complex?

do pulseaudio classify those mono internal chassis speaker as desktop
speaker path or speaker path?

http://cgit.freedesktop.org/pulseaudio/pulseaudio/tree/src/modules/alsa/mixer/paths

in patch_analog.c, "mono playback switch" is created in 6stack. 3stack and
laptop model.  the auto model need to handle the speaker of the laptop
implementation but lenovo 3000 workstation contain the internal chassis
speaker which hda auto parser put it in speaker_pins instead of mono_out

if ((err = ad1988_auto_create_multi_out_ctls(spec, &spec->autocfg)) < 0 ||
    (err = ad1988_auto_create_extra_out(codec,
spec->autocfg.speaker_pins[0],
"Speaker")) < 0 ||
     (err = ad1988_auto_create_extra_out(codec, spec->autocfg.hp_pins[0],
"Headphone")) < 0 ||
    (err = ad1988_auto_create_analog_input_ctls(codec, &spec->autocfg)) < 0)
return err;

one possible way to fix this bug for lenovo 3000 by checking wcaps of the
pin support mono/stereo in ad1988_auto_create_extra_out and create the mono
playback switch for the internal chassis speaker instead of the speaker
playback volume/switch since mono out pin have to share audio output 0x04
with green jack at rear panel.
