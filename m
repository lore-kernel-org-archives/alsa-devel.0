From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/8] Fix year 2038 issue for sound subsystem
Date: Tue, 24 Apr 2018 15:37:28 +0200
Message-ID: <CAK8P3a0SKAAJMUDOJBjHKCnvprqOTjTnX9Ju3W_q1avzdU7EnA@mail.gmail.com>
References: <cover.1524570852.git.baolin.wang@linaro.org>
 <66b26dc6-9139-80cc-0b49-28ff68169b5c@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f194.google.com (mail-qt0-f194.google.com
 [209.85.216.194])
 by alsa0.perex.cz (Postfix) with ESMTP id D74442676A6
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 15:37:30 +0200 (CEST)
Received: by mail-qt0-f194.google.com with SMTP id h2-v6so9963263qtp.7
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 06:37:30 -0700 (PDT)
In-Reply-To: <66b26dc6-9139-80cc-0b49-28ff68169b5c@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Fabian Frederick <fabf@skynet.be>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, Baolin Wang <baolin.wang@linaro.org>, Vinod Koul <vinod.koul@intel.com>, hardik.t.shah@intel.com, Takashi Iwai <tiwai@suse.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, gudishax.kranthikumar@intel.com, Mark Brown <broonie@kernel.org>, Bhumika Goyal <bhumirks@gmail.com>, Naveen M <naveen.m@intel.com>, SF Markus Elfring <elfring@users.sourceforge.net>, jeeja.kp@intel.com, subhransu.s.prusty@intel.com, Ingo Molnar <mingo@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 24, 2018 at 3:29 PM, Jaroslav Kysela <perex@perex.cz> wrote:
> Dne 24.4.2018 v 14:06 Baolin Wang napsal(a):
>> Since many structures will use timespec type variables to record time stamp
>> in uapi/asound.h, which are not year 2038 safe on 32bit system. This patchset
>> tries to introduce new structures removing timespec type to compatible native
>> mode and compat mode.
>>
>> Moreover this patchset also converts the internal structrures to use timespec64
>> type and related APIs.
>
> Thanks for your patchset. A few comments:
>
> It might be more nice to reuse the existing structures and put
> timespec64 to the reserved field and duplicate information (with the
> 32-bit wrapping for the old fields). It means that we do not need new
> ioctls and old libraries will be fine.

The current approach is intended to make any user space work
without source-level changes, i.e. you can still build an old alsa-lib
package against a new glibc as long as you have the latest kernel
headers (which the glibc requires for using 64-bit time_t).

If we try to extend the structures in a different way, that requires
user space changes, and existing source code would silently
break on a future glibc.
IMHO changing the source-level interface should only be done
as a last resort for y2038.

Note that most of the work is not required to keep working beyond
2038, but actually is required just to keep working with an
updated glibc that redefines time_t to 64 bit. The audio timestamps
should be in CLOCK_MONOTONIC for new user space anyway,
and that doesn't overflow a 32-bit type.

> It may make sense to define private snd_timespec32 and snd_timespec64
> with s32/s64 types instead separate sec/usec fields.

Right, I have some ideas there as well as I saw one remaining issue
in my patch for the status mmap: when building a program with
64-bit time_t, we still see a copy of the old structure but with an\
impossible layout.

       ARnd
