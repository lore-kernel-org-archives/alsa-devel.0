From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 0/8] Fix year 2038 issue for sound subsystem
Date: Tue, 24 Apr 2018 15:29:24 +0200
Message-ID: <66b26dc6-9139-80cc-0b49-28ff68169b5c@perex.cz>
References: <cover.1524570852.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 727222676D4
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 15:29:46 +0200 (CEST)
In-Reply-To: <cover.1524570852.git.baolin.wang@linaro.org>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Baolin Wang <baolin.wang@linaro.org>, tiwai@suse.com, arnd@arndb.de
Cc: fabf@skynet.be, arvind.yadav.cs@gmail.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, vinod.koul@intel.com, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, lgirdwood@gmail.com, elfring@users.sourceforge.net, gudishax.kranthikumar@intel.com, broonie@kernel.org, bhumirks@gmail.com, naveen.m@intel.com, jeeja.kp@intel.com, o-takashi@sakamocchi.jp, subhransu.s.prusty@intel.com, mingo@kernel.org, dan.carpenter@oracle.com
List-Id: alsa-devel@alsa-project.org

Dne 24.4.2018 v 14:06 Baolin Wang napsal(a):
> Since many structures will use timespec type variables to record time stamp
> in uapi/asound.h, which are not year 2038 safe on 32bit system. This patchset
> tries to introduce new structures removing timespec type to compatible native
> mode and compat mode.
> 
> Moreover this patchset also converts the internal structrures to use timespec64
> type and related APIs.

Thanks for your patchset. A few comments:

It might be more nice to reuse the existing structures and put
timespec64 to the reserved field and duplicate information (with the
32-bit wrapping for the old fields). It means that we do not need new
ioctls and old libraries will be fine.

It may make sense to define private snd_timespec32 and snd_timespec64
with s32/s64 types instead separate sec/usec fields.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
