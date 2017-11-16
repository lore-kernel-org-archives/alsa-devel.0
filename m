From: VDR User <user.vdr@gmail.com>
Subject: Re: Missing surround channels with Nvidia HDMI &
 snd-hda-intel driver
Date: Thu, 16 Nov 2017 13:28:17 -0800
Message-ID: <CAA7C2qgAW7k6tULe=SBpUG1_6D+N5NYsPmYZ2pi9j8HhdjicwQ@mail.gmail.com>
References: <CAA7C2qgvC65Cjbf=AsUWd3gFCqAgHpctA=CnnfAD9E9Z0bxJQw@mail.gmail.com>
 <s5hr2t29loc.wl-tiwai@suse.de>
 <CAA7C2qiGQ-VuCFPG51kXaB7bCSyC+nQvWgF=EeUSwdkybXZ=wQ@mail.gmail.com>
 <s5ha7zqt310.wl-tiwai@suse.de>
 <CAA7C2qg7RsJRsTFu03KRwTeBjcN5LK7m-b22iyw6kp5x4ymuBw@mail.gmail.com>
 <CAA7C2qjoUf5gJ-Bu8vc4sQW7rfdSVa3s-stqngFtq0EZoxTNEw@mail.gmail.com>
 <s5ha7znc1he.wl-tiwai@suse.de>
 <CAA7C2qgCp1az49jxqQhGhiJbJFyP3RumT+GFn2m926L_mGfvKQ@mail.gmail.com>
 <CAA7C2qiNPo_CQpoTERX-9PHS-Z=86sZo10v8XUuz2--v6tDqWA@mail.gmail.com>
 <s5htvxuag8e.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f43.google.com (mail-lf0-f43.google.com
 [209.85.215.43])
 by alsa0.perex.cz (Postfix) with ESMTP id E4FC8266EE4
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 22:28:19 +0100 (CET)
Received: by mail-lf0-f43.google.com with SMTP id f134so454514lfg.8
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 13:28:19 -0800 (PST)
In-Reply-To: <s5htvxuag8e.wl-tiwai@suse.de>
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
Cc: "mailing list: alsa-dev" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> What you can try is to bisect like
>    git bisect start -- sound/hda sound/pci/hda
>    git bisect good v4.5
>    git bisect bad v4.6-rc1

Ok, did more bisect'ing. I had to skip a commit because the compile
failed but other than that, this is what I wound up with:

git bisect start '--' 'sound/hda' 'sound/pci/hda'
# good: [fe0d128c57bf927a713159f60a18d9f315d4d91d] ALSA: jack: Allow
building the jack layer without input device
git bisect good fe0d128c57bf927a713159f60a18d9f315d4d91d
# bad: [9b3dc8aa3fb1a5f38ca9501f20f6ea4dced10fa0] ALSA: hda - Register
chmap obj as priv data instead of codec
git bisect bad 9b3dc8aa3fb1a5f38ca9501f20f6ea4dced10fa0
# skip: [d61b04f801e6005182d432ebe4a0211c1d6feadd] Merge branch
'for-linus' into for-next
git bisect skip d61b04f801e6005182d432ebe4a0211c1d6feadd
# good: [ec75a940b1037e877efd9a5a9e94eab1e464f73b] ALSA: hda - hdmi
add wmb barrier for audio component
git bisect good ec75a940b1037e877efd9a5a9e94eab1e464f73b
# good: [d10a80de04a3a8c0d7c1567cbc0a8d2e1181c10a] ALSA: hda -
hdmi_find_pcm_slot return value bug fix
git bisect good d10a80de04a3a8c0d7c1567cbc0a8d2e1181c10a
# good: [6defb60ae4ffe92c29291ed49695daa255b8f559] Merge branch
'for-linus' into for-next
git bisect good 6defb60ae4ffe92c29291ed49695daa255b8f559
# good: [67b90cb84be8fde0e51f71834e15c32fbec08562] ALSA: hda - Create
common chmap object
git bisect good 67b90cb84be8fde0e51f71834e15c32fbec08562
# first bad commit: [9b3dc8aa3fb1a5f38ca9501f20f6ea4dced10fa0] ALSA:
hda - Register chmap obj as priv data instead of codec

9b3dc8aa3fb1a5f38ca9501f20f6ea4dced10fa0 is the first bad commit
commit 9b3dc8aa3fb1a5f38ca9501f20f6ea4dced10fa0
Author: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Date:   Fri Mar 4 19:59:47 2016 +0530

    ALSA: hda - Register chmap obj as priv data instead of codec

    With this chmap object is added as private data and new ops are
    added to access driver specific chmap.

    Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
    Signed-off-by: Vinod Koul <vinod.koul@intel.com>
    Signed-off-by: Takashi Iwai <tiwai@suse.de>

:040000 040000 11dc1a68fd79182d4e38c2a7fd73fd699dbd0685
69c05f445bc255fc02441742b091247af99fb177 M      include
:040000 040000 8946088a30757dfcbc1ea6badbe6ea8366b2b39f
6fcf7ce7986ffd29d3b5686ebe63168713b866ed M      sound

Does this sound like it could be where the bug resides?. I created a
patch with `git format-patch -1
9b3dc8aa3fb1a5f38ca9501f20f6ea4dced10fa0` and tried to apply it to
kernel 4.6-rc1 but I failed. I didn't bother trying to hand-reverse it
because it looks like it would just cause breakage. Not sure what to
do next here so I'll wait and see what you think..

-Derek

> This will concentrate only on commits in sound/hda/* and
> sound/pci/hda/*.  You have to be careful about the kernel version to
> be built eventually jumping back and forth, and remember which one is
> installed and rebooted/retested.  I usually put a different suffix
> string to CONFIG_LOCALVERSION at each build or set
> CONFIG_LOCALVERSION_AUTO to put the git commit id.
>
>
> Takashi
>
>> On Wed, Nov 15, 2017 at 8:34 AM, VDR User <user.vdr@gmail.com> wrote:
>> >>> It just tried kernel 4.6-rc1 and the problem is present there as well.
>> >>> Is there a list of patches between stable kernel 4.5.7 and 4.6-rc1
>> >>> somewhere? I can try to revert each of them one at a time if so.
>> >>> Unless someone has any better idea to narrow this down to the
>> >>> offending commit?
>> >>
>> >> There were a significant amount of changes between 4.5 and 4.6
>> >> regarding HD-audio HDMI/DP due to DP-MST support and the movement of
>> >> chmap stuff into sound/hda.
>> >>
>> >> Both can be a culprit...
>> >>
>> >> For checking the former, could you try the following?
>> >> - Checkout 4.5.7 git branch
>> >> - merge (not cherry-pick) the commit 022f344b41a5
>> >>   % git merge 022f344b41a5
>> >>
>> >>   This will bring DP-MST changes on top of 4.5.7.
>> >>
>> >> Then build this and check whether it shows the problem.  If yes, you
>> >> can easily bisect between 4.5.7 and here.  If it doesn't show a
>> >> problem, the problem is in the rest changes in 4.6-rc1.
>> >
>> > Hi Takashi,
>> >
>> > I did:
>> > git clone https://github.com/torvalds/linux.git
>> > cd linux
>> > git checkout 022f344b41a5
>> >
>> > After compiling, audio is working correctly with that commit:
>> > ~$ speaker-test -c 6 -t wav
>> >
>> > speaker-test 1.1.3
>> >
>> > Playback device is default
>> > Stream parameters are 48000Hz, S16_LE, 6 channels
>> > WAV file(s)
>> > Rate set to 48000Hz (requested 48000Hz)
>> > Buffer size range from 64 to 5440
>> > Period size range from 32 to 2720
>> > Using max buffer size 5440
>> > Periods = 4
>> > was set period_size = 1088
>> > was set buffer_size = 5440
>> >  0 - Front Left
>> >  4 - Front Center
>> >  1 - Front Right
>> >  3 - Rear Right
>> >  2 - Rear Left
>> >  5 - LFE
>> > Time per period = 8.526391
>> >
>> > Do you happen to known which commit I can try next that *should* have
>> > the problem so I can git bisect from there?
>> >
>> > Thanks!
>>
