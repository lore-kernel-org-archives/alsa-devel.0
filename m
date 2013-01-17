From: David Henningsson <david.henningsson@canonical.com>
Subject: hda_analyzer (was: Re: HD-audio regression after
 commit 34588709af61be1550b4e2bcee5c85d0ac4f34d4)
Date: Thu, 17 Jan 2013 16:33:56 +0100
Message-ID: <50F819E4.8080401@canonical.com>
References: <CA+S_cwraM+wofw5Nz_d0ctOget5dY-0nr5pRHCzOJtLX+JM2TA@mail.gmail.com>
 <s5h1udlp5to.wl%tiwai@suse.de>
 <CAN8ccib5gpbsyLPmfoaC4edwYjird8ViZbKKiTbo-iP4DsjsOA@mail.gmail.com>
 <s5hehhk2uee.wl%tiwai@suse.de>
 <CAN8cciZEWPdKcX2J=16ry9UVoXZwasF7GfN9O4JGwJPx+0Y8zQ@mail.gmail.com>
 <s5h8v7s2tja.wl%tiwai@suse.de>
 <CA+S_cwowFrLAWSRiQvPX5AZwuyo9DdA4qS7Xn3bMYy=AzzpHdg@mail.gmail.com>
 <s5hvcaw18qf.wl%tiwai@suse.de>
 <CA+S_cwq7mDPkjPCVpRecO93UW2gpYo7BpMfFARu0PZCvNT-w4A@mail.gmail.com>
 <s5hsj6017km.wl%tiwai@suse.de>
 <CA+S_cwo2mZn+5P3JuNWXZ+3taQcSHmvRhm95vjupY1o+FA+cpw@mail.gmail.com>
 <s5hobgo16ct.wl%tiwai@suse.de>
 <CA+S_cwqeP90pFpFviKns-bxxBS6ahunPgRfCG0BQTa5ZLPtE-Q@mail.gmail.com>
 <s5hlibs154t.wl%tiwai@suse.de>
 <CA+S_cwoLe=2tUr=EyFM0TxvbBaB12DCE2yDPwf3OzoRcO8jQug@mail.gmail.com>
 <CAN8cciama4q0EOiUsjp-KyyzehcvjwmdPdBQ9vsitbnR8g1PgA@mail.gmail.com>
 <CA+S_cwrmHguxk6WBxjAJTOaV8xV-4PH0gkpibFKs1P8bRxAsAg@mail.gmail.com>
 <CAN8cciaEqbTi-kP7HFH5f2wOBTzFEVEryPo5TrFH8mQYqmVBjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id D96382650D7
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2013 16:33:54 +0100 (CET)
In-Reply-To: <CAN8cciaEqbTi-kP7HFH5f2wOBTzFEVEryPo5TrFH8mQYqmVBjg@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, =?UTF-8?B?TWFub2xvIETDrQ==?= =?UTF-8?B?YXo=?= <diaz.manolo@gmail.com>, Miro Hodak <mhodak127@gmail.com>, Takashi Iwai <tiwai@suse.de>, basinilya@gmail.com, Raymond Yau <superquad.vortex2@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 01/17/2013 04:29 PM, Raymond Yau wrote:
>  > File "/dev/shm/hda-analyzer/hda_proc.py", line 143, in wrongfile
>  >     raise ValueError, "wrong proc file format (%s)" % msg
>  > ValueError: wrong proc file format (integer decode 'State of AFG node
> 0x01:' ('Node '))
>  >
>  > Any ideas?
>
> This patch add lines which make the parser of hda_proc.py fail
>
> http://git.kernel.org/?p=linux/kernel/git/tiwai/sound.git;a=commitdiff;h=f4f0a8c4783a0258f2d0020a67fd619ce41a02a3;hp=e4cc6153401fc59d6d4ca0317be5774bdbd399ba
>

Sigh, this is not the first time new stuff in the proc file crashes 
hda_analyzer.

Jaroslav, can you please fix hda_analyzer so that it ignores new stuff 
in the proc file instead of crashing, so we don't have this problem over 
and over again?

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
