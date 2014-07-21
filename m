From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/6] bebob: Improvements for M-Audio
	specific operations
Date: Mon, 21 Jul 2014 18:50:23 +0900
Message-ID: <53CCE25F.9070201@sakamocchi.jp>
References: <1405831835-26499-1-git-send-email-weiyj_lk@163.com>	<1405908605-8105-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5hegxfi424.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 298F7265138
 for <alsa-devel@alsa-project.org>; Mon, 21 Jul 2014 11:50:38 +0200 (CEST)
In-Reply-To: <s5hegxfi424.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, darrena092@gmail.com, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Iwai-San,

(Jul 21 2014 16:06), Takashi Iwai wrote:
> I don't want to apply such a big series at the late stage of 3.16-rc.
> Please create short patches "just doing fix" for 3.16 as Yongjun did,
> and rebase comprehensive cleanups on it.

Exactly. In this time, I want to fix three bugs:
1. Missing unlock which Yongjun reported
2. My misunderstanding about return value of .put callback
3. Wrong label for a control element of digital input interface

I think these should be fixed in this release cycle.

Additionally, I want to add some dev_err() to reduce my maintaining
efforts, because the fireworks/bebob drivers newly supports 60-70 models
in Linux 3.16, while the number of developers who can support users is a
few, maybe I and Clemens.

I'll post four patches for these items, instead of the six patches, and
post additional patches for next cycle, 3.17. Is it OK?


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp
