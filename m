From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: dapm: fix a memory leak bug
Date: Tue, 23 Jul 2019 10:15:05 +0100
Message-ID: <20190723091505.GN54126@ediswmail.ad.cirrus.com>
References: <1563803864-2809-1-git-send-email-wang6495@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1563803864-2809-1-git-send-email-wang6495@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Wenwen Wang <wang6495@umn.edu>
Cc: Wenwen Wang <wenwen@cs.uga.edu>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 22, 2019 at 08:57:44AM -0500, Wenwen Wang wrote:
> From: Wenwen Wang <wenwen@cs.uga.edu>
> 
> In snd_soc_dapm_new_control_unlocked(), a kernel buffer is allocated in
> dapm_cnew_widget() to hold the new dapm widget. Then, different actions are
> taken according to the id of the widget, i.e., 'w->id'. If any failure
> occurs during this process, snd_soc_dapm_new_control_unlocked() should be
> terminated by going to the 'request_failed' label. However, the allocated
> kernel buffer is not freed on this code path, leading to a memory leak bug.
> 
> To fix the above issue, free the buffer before returning from
> snd_soc_dapm_new_control_unlocked() through the 'request_failed' label.
> 
> Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
