From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] soc/sti: a possible sleep-in-atomic bug in
 uni_player_ctl_iec958_put
Date: Tue, 12 Dec 2017 22:27:47 +0800
Message-ID: <425ee21c-b6c2-640b-15fd-6ff84b79a986@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, arnaud.pouliquen@st.com, dan.carpenter@oracle.com
Cc: alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

According to sound/soc/sti/uniperif_player.c, the driver may sleep under 
a spinlock.
The function call path is:
uni_player_ctl_iec958_put (acquire the spinlock)
   uni_player_set_channel_status
     mutex_lock --> may sleep

I do not find a good way to fix it, so I only report.
This possible bug is found by my static analysis tool (DSAC) and checked 
by my code review.


Thanks,
Jia-Ju Bai
