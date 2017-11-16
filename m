From: VDR User <user.vdr@gmail.com>
Subject: Re: Missing surround channels with Nvidia HDMI &
 snd-hda-intel driver
Date: Wed, 15 Nov 2017 21:53:37 -0800
Message-ID: <CAA7C2qiNPo_CQpoTERX-9PHS-Z=86sZo10v8XUuz2--v6tDqWA@mail.gmail.com>
References: <CAA7C2qgvC65Cjbf=AsUWd3gFCqAgHpctA=CnnfAD9E9Z0bxJQw@mail.gmail.com>
 <s5hr2t29loc.wl-tiwai@suse.de>
 <CAA7C2qiGQ-VuCFPG51kXaB7bCSyC+nQvWgF=EeUSwdkybXZ=wQ@mail.gmail.com>
 <s5ha7zqt310.wl-tiwai@suse.de>
 <CAA7C2qg7RsJRsTFu03KRwTeBjcN5LK7m-b22iyw6kp5x4ymuBw@mail.gmail.com>
 <CAA7C2qjoUf5gJ-Bu8vc4sQW7rfdSVa3s-stqngFtq0EZoxTNEw@mail.gmail.com>
 <s5ha7znc1he.wl-tiwai@suse.de>
 <CAA7C2qgCp1az49jxqQhGhiJbJFyP3RumT+GFn2m926L_mGfvKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f51.google.com (mail-lf0-f51.google.com
 [209.85.215.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 894E1266D7D
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 06:53:39 +0100 (CET)
Received: by mail-lf0-f51.google.com with SMTP id k66so16739167lfg.3
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 21:53:39 -0800 (PST)
In-Reply-To: <CAA7C2qgCp1az49jxqQhGhiJbJFyP3RumT+GFn2m926L_mGfvKQ@mail.gmail.com>
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

Ok, after doing a git bisect on the kernel tree, I wound up with:

41eb94fd26f6c150b0460e01ecc84d643355f9b6 is the first bad commit
commit 41eb94fd26f6c150b0460e01ecc84d643355f9b6
Author: Vinod Koul <vinod.koul@intel.com>
Date:   Fri Mar 4 20:25:30 2016 +0530

    ALSA: compress: fix some typos

So, something must have went wrong because that commit is just
spelling and grammar fixes in comments.

How can I do a git bisect for just sound/ instead of the whole kernel?
I assume I'd have to clone the kernel, delete sound/, then clone the
alsa dev git sound/ in its place? It should be easier to git bisect in
alsa, then simply recompile modules, install, load, test, and repeat
until I find the offending commit right?

On Wed, Nov 15, 2017 at 8:34 AM, VDR User <user.vdr@gmail.com> wrote:
>>> It just tried kernel 4.6-rc1 and the problem is present there as well.
>>> Is there a list of patches between stable kernel 4.5.7 and 4.6-rc1
>>> somewhere? I can try to revert each of them one at a time if so.
>>> Unless someone has any better idea to narrow this down to the
>>> offending commit?
>>
>> There were a significant amount of changes between 4.5 and 4.6
>> regarding HD-audio HDMI/DP due to DP-MST support and the movement of
>> chmap stuff into sound/hda.
>>
>> Both can be a culprit...
>>
>> For checking the former, could you try the following?
>> - Checkout 4.5.7 git branch
>> - merge (not cherry-pick) the commit 022f344b41a5
>>   % git merge 022f344b41a5
>>
>>   This will bring DP-MST changes on top of 4.5.7.
>>
>> Then build this and check whether it shows the problem.  If yes, you
>> can easily bisect between 4.5.7 and here.  If it doesn't show a
>> problem, the problem is in the rest changes in 4.6-rc1.
>
> Hi Takashi,
>
> I did:
> git clone https://github.com/torvalds/linux.git
> cd linux
> git checkout 022f344b41a5
>
> After compiling, audio is working correctly with that commit:
> ~$ speaker-test -c 6 -t wav
>
> speaker-test 1.1.3
>
> Playback device is default
> Stream parameters are 48000Hz, S16_LE, 6 channels
> WAV file(s)
> Rate set to 48000Hz (requested 48000Hz)
> Buffer size range from 64 to 5440
> Period size range from 32 to 2720
> Using max buffer size 5440
> Periods = 4
> was set period_size = 1088
> was set buffer_size = 5440
>  0 - Front Left
>  4 - Front Center
>  1 - Front Right
>  3 - Rear Right
>  2 - Rear Left
>  5 - LFE
> Time per period = 8.526391
>
> Do you happen to known which commit I can try next that *should* have
> the problem so I can git bisect from there?
>
> Thanks!
