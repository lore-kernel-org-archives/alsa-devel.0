From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Realtek ALC662 issues - Intel DG41CN
Date: Thu, 2 Apr 2015 14:05:35 +0800
Message-ID: <CAN8cciYekADYx1yVo=b2Grtk=TMqqWt6yC0vHMxPXZZxA_WtQQ@mail.gmail.com>
References: <CAN8ccibj5KZH2_R5Sh52Mm0DX5_OdniysqtbYu=RKNwxwo=KMg@mail.gmail.com>
 <CAN8cciZ2RFu3tNmhRd75BxyqQTVGd1fQC-RvxvgcaxGyg=5A9A@mail.gmail.com>
 <CAN8ccibO+bBpHgLGSZgOXBdsfSs41+rx8a+WOqUzoAiER6oKAw@mail.gmail.com>
 <CAN8cciY6j8iXiLkAkMhy2915MqR=RQXic5nXM4-cFRA_dW-Ngw@mail.gmail.com>
 <CAN8cciZAN0=DpTBO5UKLt4-Tve7ZDGy3NdkN-M62ZmqV+RMpfg@mail.gmail.com>
 <CAN8cciavrLGiDB_AYL4Z+hXFdtcaU1hWEkb7CY1i6g2s+9NoYQ@mail.gmail.com>
 <CAN8cciaBxSz_JY2i6xX21VUm4DGKfiu5Kv=9S60wQQh93Y-E6g@mail.gmail.com>
 <CAN8cciZDOLU9ufd2QpXkovYyCDbQtjoFJpDO0-3+94A_45Gxxg@mail.gmail.com>
 <CAAMTFD=N8GrHUAUon7YGFmZjkZGVeLS-EwzT8h6Lu1+JkxV6zg@mail.gmail.com>
 <CAN8cciZh2H8RUapa5vKisDqjKJ4dBc=abAHzYtoxTp77BYojrw@mail.gmail.com>
 <CAAMTFDm6uOwtBAnRrzP0C2WfD=pYfJJ+9Pg4rd+QA1wa6gUBKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f174.google.com (mail-ob0-f174.google.com
 [209.85.214.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F7B526047B
 for <alsa-devel@alsa-project.org>; Thu,  2 Apr 2015 08:05:36 +0200 (CEST)
Received: by obbec2 with SMTP id ec2so113386582obb.3
 for <alsa-devel@alsa-project.org>; Wed, 01 Apr 2015 23:05:35 -0700 (PDT)
In-Reply-To: <CAAMTFDm6uOwtBAnRrzP0C2WfD=pYfJJ+9Pg4rd+QA1wa6gUBKw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: aditya kumar <aditya2507@gmail.com>
Cc: tiwai@suse.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
> >> You don't need any model since the pin defaults of your Intel DG41CN
are correct unless you want to use CD audio in connector
>
> Originally, after the install there was no "model" there. It did not work
even then. This entry that you see is because of my trials to make it work.

You have to post output of alsa-info.sh without specify any model

>
> >>You should check the front audio panel of your computer chassis if jack
state of headphone is alway plugged
> Don't think that is the case. Because it works just fine on the Windows
OS. In fact, as I have mentioned, there is some choppiness/stutter sound
that I hear occasionally when I play in right now on Fedora/Ubuntu (while
most of the time there is no sound). This behaviour goes away when I put
the headphone (and then there is no sound at all from the main speaker)

Do the front panel headphone still work when you use rear panel jacks for
5.1 sound in windows ?

>
> >>You have to provide pulseaudio verbose log
> Pulseaudio is not a problem because I tested it by killing Pulseaudio
too. The same problem persists. Though, if you insist I can surely get you
the output.

Killing pulseaudio won't work since it can auto-spwan

http://lists.freedesktop.org/archives/pulseaudio-discuss/2015-March/023568.html

Check the pulseaudio verbose log , as your line out and headphone share the
same playback volume control, dB min of line out path and headphone path
should be same value

http://cgit.freedesktop.org/pulseaudio/pulseaudio/commit/src/modules/alsa/mixer/paths/analog-output-headphones.conf?id=96369919e5100865e2469e42fb8f4b8e38e41aef
<http://cgit.freedesktop.org/pulseaudio/pulseaudio/tree/src/modules/alsa/mixer/paths/analog-output-headphones.conf>
http://cgit.freedesktop.org/pulseaudio/pulseaudio/tree/src/modules/alsa/mixer/paths/analog-output-headphones.conf

If Front is shared by HP and Line out,
Why set volume to zero dB ?
volume should remain unchanged , only need to restore save values after
reboot

>
> >>You can disable multi channels by using early patching and hint
multi_io=0  to get back the headphone playback volume contro
> How do I do that? Appreciate your help here!
>
>
https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/Documentation/sound/alsa/HD-Audio.txt

Codec: Realtek ALC662 rev1
Address: 0
AFG Function Id: 0x1 (unsol 1)
Vendor Id: 0x10ec0662
Subsystem Id: 0x8086434e
Revision Id: 0x100101

Early Patching
~~~~~~~~~~~~~~
When CONFIG_SND_HDA_PATCH_LOADER=y is set, you can pass a "patch" as a
firmware file for modifying the HD-audio setup before initializing the
codec.  This can work basically like the reconfiguration via sysfs in the
above, but it does it before the first codec configuration.

A patch file is a plain text file which looks like below:

------------------------------------------------------------------------
  [codec]
  0x12345678 0xabcd1234 2

  [hint]
  multi_io = no
------------------------------------------------------------------------

The file needs to have a line `[codec]`.  The next line should contain
three numbers indicating the codec vendor-id (0x12345678 in the example),
the codec subsystem-id (0xabcd1234) and the address (2) of the codec.  The
rest patch entries are applied to this specified codec until another codec
entry is given.  Passing 0 or a negative number to the first or the second
value will make the check of the corresponding field be skipped.  It'll be
useful for really broken devices that don't initialize SSID properly.

The hd-audio driver reads the file via request_firmware().  Thus,
a patch file has to be located on the appropriate firmware path,
typically, /lib/firmware.  For example, when you pass the option
`patch=hda-init.fw`, the file /lib/firmware/hda-init.fw must be
present

Post output of alsa-info.sh after you reboot with early patching

You will get headphone playback volume control but loss those surround ,
center and lfe playback volume controls

http://www.intel.com/support/motherboards/desktop/sb/CS-034206.htm

Seem your motherboard does not support multistreaming as it is not in the
supported list

Do this mean that indep_hp should be explicitly disabled for alc662 ?
