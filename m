From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 22/39] fireworks: Add proc interface for
	debugging purpose
Date: Sat, 01 Mar 2014 22:17:58 +0900
Message-ID: <5311DE06.80105@sakamocchi.jp>
References: <1393558072-25926-1-git-send-email-o-takashi@sakamocchi.jp>
 <1393558072-25926-23-git-send-email-o-takashi@sakamocchi.jp>
 <s5h61nzn2wi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id DBE5C265327
 for <alsa-devel@alsa-project.org>; Sat,  1 Mar 2014 14:18:01 +0100 (CET)
In-Reply-To: <s5h61nzn2wi.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi,

(Feb 28 2014 15:54), Takashi Iwai wrote:
> Why '#' is needed for each file name?

It's for my convinience to ask testers gathering output from procfs 
nodes. With this '#', I can just tell them '/proc/asound/cardX/#*' to 
get enough information.

Is it rude?


Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp
