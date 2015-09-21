From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 4/4] sound/core/seq: make prioq_match return bool
Date: Mon, 21 Sep 2015 16:11:00 +0200
Message-ID: <1442844660.1876.2.camel@sipsolutions.net>
References: <1442843834-4648-1-git-send-email-bywxiaobai@163.com>
	 <1442843834-4648-4-git-send-email-bywxiaobai@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442843834-4648-4-git-send-email-bywxiaobai@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yaowei Bai <bywxiaobai@163.com>, perex@perex.cz, tiwai@suse.com, k.kozlowski@samsung.com, elfring@users.sourceforge.net, fabf@skynet.be, lars@metafoo.de
Cc: linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


> -static inline int prioq_match(struct snd_seq_event_cell *cell,
> +static inline bool prioq_match(struct snd_seq_event_cell *cell,
>  			      int client, int timestamp)

I think you should fix up the indentation now.

johannes
