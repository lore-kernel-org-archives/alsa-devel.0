From: Wang Xingchao <wangxingchao2011@gmail.com>
Subject: Re: HD-audio runtime PM
Date: Tue, 26 Nov 2013 09:05:20 +0800
Message-ID: <CA+v+29hKbtTBLh=qNRBVqd-NUfXRVBBokoypDh_0RMRQ_VjYvw@mail.gmail.com>
References: <s5hli0gmyxt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
 [209.85.160.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 3654C260818
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 02:05:42 +0100 (CET)
Received: by mail-pb0-f54.google.com with SMTP id un15so6990534pbc.27
 for <alsa-devel@alsa-project.org>; Mon, 25 Nov 2013 17:05:40 -0800 (PST)
In-Reply-To: <s5hli0gmyxt.wl%tiwai@suse.de>
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
Cc: "Lin, Mengdong" <mengdong.lin@intel.com>, "Alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

2013/11/22 Takashi Iwai <tiwai@suse.de>:
> Hi,
>
> after my previous fix, the runtime PM seems working stably finally.
> However, there seem still some glitches:
>
> 1. The wakeup via jack or HDMI/DP detection doesn't seem to work on my
>   test machines.  WAKEEN is set properly.  And its value can be read
>   correctly at the point of runtime resume, too.
>
> 2. We don't change the device to D3 in runtime suspend.  So I guess we
>   save little power as of now.
>
>   Actually, setting to D3 and resuming to D0 works fine, as far as I
>   tested -- except for HDMI/DP ELD read out on Haswell.  Although ELD
>   read doesn't give any errors, the received bytes are corrupted.  In
>   my case, the read starts from offset 0x1c.
>
>   The HDMI can be still played even at that state, but then it falls
>   back to the stereo 2ch mode, of course.
>
> The tests were performed on both Haswell (DP and LynxPoint-LP) and
> IvyBridge (PantherPoint) machines.
>
> The first problem has been present, and it's also the behavior of some
> old chips where the codec can't go to sleep with unsol wakeup.  So, in
> this regard, it's no regression, per se.  But certainly it's no good
> thing.
>
> I thought Mengdong once made WAKEEN working.  Mengdong, do you
> remember what was the condition?  Could you check whether the latest
> kernel (at best sound git tree for-linus branch) still works?
>
> About the second point: we should do D3 if we do care power, and
> that's the very right reason for runtime PM.  But the ELD issue is a
> bad bug, and it makes me wonder whether it's a graphics driver side
> issue or a codec side.  As a quick workaround, we can implement D3 on
> controllers but for Haswell HDMI/DP.

I didnot follow alsa-devel threads often now, is that ELD issue an
regression from my previous commit?
I test WAKEEN feature on Haswell machines before, it could really
wakeup system from D3.
The controller must be in RESET mode after enter runtime-suspend,
otherwise it will not be waken up
even if codec send out wake-up event. And STATESTS will be cleared
after controller brought out of RESET mode.

thanks
--xingchao
>
> In anyway, this is no urgent issue, clearly targeted for 3.14.
> The whole patch series are found in my sound-unstable git tree
> test/hda branch.
>   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-unstable.git
>
>
> thanks,
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
