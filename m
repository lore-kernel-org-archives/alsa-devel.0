From: Andreas Reis <andreas.reis@gmail.com>
Subject: Re: [Report] ALSO: hda - CA0132: Bugs and missing
	features
Date: Tue, 19 Nov 2013 17:08:58 +0100
Message-ID: <CAM_hTGES5oDziDKA8C=m_ew3r0X_Tvgd4Mp3WCcG=OLRk6H0bg@mail.gmail.com>
References: <CAM_hTGFcrt2voAOOGfJG8=XaaFRuJCPdeyj3CCituhFthLLr4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qe0-f47.google.com (mail-qe0-f47.google.com
 [209.85.128.47])
 by alsa0.perex.cz (Postfix) with ESMTP id E6A5E261A3C
 for <alsa-devel@alsa-project.org>; Tue, 19 Nov 2013 17:08:59 +0100 (CET)
Received: by mail-qe0-f47.google.com with SMTP id t7so491720qeb.20
 for <alsa-devel@alsa-project.org>; Tue, 19 Nov 2013 08:08:59 -0800 (PST)
In-Reply-To: <CAM_hTGFcrt2voAOOGfJG8=XaaFRuJCPdeyj3CCituhFthLLr4Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Correction: The other jack duplicated for the front panel is Mic In
(no mention of the rear panel jack's shared Line In functionality
here), not Rear Speaker Out.

On Tue, Nov 19, 2013 at 5:04 PM, Andreas Reis <andreas.reis@gmail.com> wrote:
> Posting here by Takashi's advice after my alsa-user post remained unanswered.
>
> There are a number of grave issues with the CA0132 codec on my
> Gigabyte G1.Sniper M5 (rev. 1.0) (Intel Z87, Recon3Di onboard, latest
> bios F8c). I've tried kernels (x64) from 3.9 to 3.13-preRC1 (as
> currently in Torvald's git), both with pulse on Ubuntu 13.10 and
> without on Arch Linux.
>
> First a description, then the issues; contacting Creative's support
> only led to one of those "we don't do Linux" replies.
>
> This motherboard has 2/5.1 channel support with a total of eight jacks
> (the last two below are stated as duplicated for a front panel, with
> only one of each pair to be used at a time):
>
> * Line/Mic In
> * Line/Front Speaker Out
> * Optical S/PDIF Out
> * Center/Subwoofer Speaker Out
> * Rear Speaker Out
> * Headphone/Speaker Out
>
> On Windows everything works (optical not tested), although the In jack
> must be set to "Mic" to work, not to "Line" (no corresponding setting
> exists in alsamixer).
>
> The manual recommends using the headphone jacks for stereo (as it
> "supports amplifying function"), but from the moment of pressing the
> power button both also output very audible static noise along with the
> actual sound, so I only use the Line Out.
>
> Now, the actual issues on Linux:
>
> * No way to change to 5.1, at least not with alsamixer (the "Surround"
> switch there refers to some stereo effect). C/S and Rear Out jacks are
> just dead.
> * The front panel Headphone/Speaker Out works, but the rear panel one
> only provides the static.
> * Often after restarting from a system crash, the sound will not work
> until I change the Master volume and restart all programs which tried
> to play something.
> * One needs these lines in /etc/asound.conf to fix the sound card
> ordering, as card 0 only has three S/PDIF outs (presumably the HDMI/DP
> outs of the Intel chipset):
>
> defaults.pcm {
>          card 1
>          device 0
> }
> defaults.ctl {
>          card 1
>          device 0
> }
>
> And what irks the most:
>
> * No microphone input whatsoever, on neither jack.
>
> The only noise on Linux is a faint click on disabling either
> "AMic1/DMic" or "AMic1/DMic Auto Detect", and the attached garbage
> when Mic1-Boost is enabled along with the latter two (regardless of
> weather the mic is actually plugged in).
>
> Passing model=generic to snd-hda-intel, as suggested by Takashi in an
> email, had no effect.
>
> Some observations:
>
> * alsamixer seems to always show "Analog-Mic2" or "What U Hear"
> (sometimes both) enabled after boot, even if they had been manually
> disabled previously.
> * As written above, there is no way to cycle between the three input
> settings (rear panel line-in, rear panel mic, front panel mic) as on
> Windows.
> * One can switch on both "Analog-Mic2" and "AMic1/DMic"/"AMic1/DMic
> Auto Detect" at the same time, although they should probably be
> mutually exclusive.
> * It only works on Windows 8.1 if I hard boot into it. If I reboot
> from Linux it will fail as well: The Mic is still detected (ie, not
> reported as unplugged), but instead of actually recording, it take any
> output as its input, while corrupting it into a what sounds to me like
> a soft, fading feedback loop. Unfortunately I have been unable to
> record this. Cycling the settings there doesn't help, only shutting
> down and removing the power for a brief while does.
>
> Attachments:
>
> * alsa-info (split due to size):
>     part1: http://pastie.org/pastes/8492817/text?key=p2wnvkcvn0h7o3t2pdgg
>     part2: http://pastie.org/pastes/8492822/text?key=yjurqav8tzrpvbfar4o87a
> * lspci -vvnn: http://pastie.org/pastes/8492798/text
> * alsamixer, capture: http://i.imgur.com/ByA20f0.png
> * alsamixer, playback: http://i.imgur.com/7dkvo66.png
> * recorded garbage (arecord -f S16_LE -r 44100 -d 10 hw:1,0
> test-mic.wav): http://www.mediafire.com/?yy1fno6vw9dbdo8
