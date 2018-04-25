From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 0/8] Fix year 2038 issue for sound subsystem
Date: Wed, 25 Apr 2018 09:23:58 +0200
Message-ID: <1b6a0710-7bc1-08d1-49a5-f1bed7bf3f84@perex.cz>
References: <cover.1524570852.git.baolin.wang@linaro.org>
 <66b26dc6-9139-80cc-0b49-28ff68169b5c@perex.cz>
 <CAK8P3a0SKAAJMUDOJBjHKCnvprqOTjTnX9Ju3W_q1avzdU7EnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a0SKAAJMUDOJBjHKCnvprqOTjTnX9Ju3W_q1avzdU7EnA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Baolin Wang <baolin.wang@linaro.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Ingo Molnar <mingo@kernel.org>, SF Markus Elfring <elfring@users.sourceforge.net>, Dan Carpenter <dan.carpenter@oracle.com>, jeeja.kp@intel.com, Vinod Koul <vinod.koul@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, subhransu.s.prusty@intel.com, Bhumika Goyal <bhumirks@gmail.com>, gudishax.kranthikumar@intel.com, Naveen M <naveen.m@intel.com>, hardik.t.shah@intel.com, Arvind Yadav <arvind.yadav.cs@gmail.com>, Fabian Frederick <fabf@skynet.be>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Dne 24.4.2018 v 15:37 Arnd Bergmann napsal(a):
> On Tue, Apr 24, 2018 at 3:29 PM, Jaroslav Kysela <perex@perex.cz> wrote:
>> Dne 24.4.2018 v 14:06 Baolin Wang napsal(a):
>>> Since many structures will use timespec type variables to record time stamp
>>> in uapi/asound.h, which are not year 2038 safe on 32bit system. This patchset
>>> tries to introduce new structures removing timespec type to compatible native
>>> mode and compat mode.
>>>
>>> Moreover this patchset also converts the internal structrures to use timespec64
>>> type and related APIs.
>>
>> Thanks for your patchset. A few comments:
>>
>> It might be more nice to reuse the existing structures and put
>> timespec64 to the reserved field and duplicate information (with the
>> 32-bit wrapping for the old fields). It means that we do not need new
>> ioctls and old libraries will be fine.
> 
> The current approach is intended to make any user space work
> without source-level changes, i.e. you can still build an old alsa-lib
> package against a new glibc as long as you have the latest kernel
> headers (which the glibc requires for using 64-bit time_t).
> 
> If we try to extend the structures in a different way, that requires
> user space changes, and existing source code would silently
> break on a future glibc.
> IMHO changing the source-level interface should only be done
> as a last resort for y2038.

We have almost everything hidden in the alsa-lib code for the
applications and there is the protocol versioning, so we can detect the
changes easily and handle the new fields in the library. As you noted,
the current code will be fine until 2038 even with my proposed change
(which is more easy to be implemented in the kernel - less bloat) and
there are 20 years to update alsa-lib remaining for the 32-bit systems.

Only the binary compatibility for the older binaries should be taken
into account.

Also, you expect that tv_nsec will be changed to the 's64' type. Do you
have that confirmed from the glibc developers? From the current
specification, the tv_nsec type is 'long'. It may cause some binary
compatibility issues, too.

				Thanks,
					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
