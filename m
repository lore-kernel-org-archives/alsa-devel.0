From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/2] Generic HDMI codec: Add channel
	mapping control
Date: Sun, 11 Dec 2016 10:16:16 +0900
Message-ID: <773cb1e2-cdd2-fee9-4d2b-fa6580b18b47@sakamocchi.jp>
References: <1481215067-19362-1-git-send-email-arnaud.pouliquen@st.com>
 <f4d0e685-51f0-5831-e087-67d2ba276422@sakamocchi.jp>
 <ca1cfca3-3f2a-3935-536d-5d92cc4d0a67@sakamocchi.jp>
 <fffbf15e-ac95-a203-357f-01044614372a@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 094D6265823
 for <alsa-devel@alsa-project.org>; Sun, 11 Dec 2016 02:16:26 +0100 (CET)
In-Reply-To: <fffbf15e-ac95-a203-357f-01044614372a@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org
Cc: kernel@stlinux.com, Takashi Iwai <tiwai@suse.de>, lgirdwood@gmail.com, Jyri Sarha <jsarha@ti.com>, David Airlie <airlied@linux.ie>, broonie@kernel.org, Daniel Vetter <daniel.vetter@intel.com>
List-Id: alsa-devel@alsa-project.org

On Dec 9 2016 23:06, Arnaud Pouliquen wrote:
>> Anyway, we're mostly on the end of development for 4.10 cycle, and the
>> review process for new feature might be delay till 4.10-rc1 release, two
>> weeks later. During the weeks. bug fixes are preferable to be applied.
>
> Thank you for warning me. No problem for the delay, i fully understand
> that focus is on bug fixes.
> Notice that it is quite difficult for developers to find the best timing
> to address this kind of patch, as integration process is not always
> simple to follow... this probably come with experience.

ALSA is a development project for sound subsystem of Linux operating 
system, and our work is a part of Linux kernel. Therefore, it's better 
to follow generic behavior in Linux kernel development.

> So if i well understand your remark the best windows to integrate a
> feature for the version N+1, is to propose patch from N-rc1 tag.
> (expecting that patch-set is enough mature to be integrated in N+1...)

It's a better way if you're aware of maintainers' work and your task 
allows you to do things steadily.


Regards

Takashi Sakamoto
