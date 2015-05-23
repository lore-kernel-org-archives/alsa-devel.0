From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 3/4] ALSA: firewire-lib: use dev_err()
 when	detecting incoming streaming error
Date: Sat, 23 May 2015 16:00:52 +0900
Message-ID: <556025A4.2030101@sakamocchi.jp>
References: <1432304474-6533-1-git-send-email-o-takashi@sakamocchi.jp>
 <1432304474-6533-4-git-send-email-o-takashi@sakamocchi.jp>
 <555F6FD6.8090809@ladisch.de> <555FFF25.5030602@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 3AC742604C6
 for <alsa-devel@alsa-project.org>; Sat, 23 May 2015 09:00:57 +0200 (CEST)
In-Reply-To: <555FFF25.5030602@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On May 23 2015 13:16, Takashi Sakamoto wrote:
> This means that there're a gap between the generated
> error messages, approximately several hundred seconds because it cost
> expensive for devices to restart isochronous streams. In my opinion,
> this is not such flooding.

Oops, "several hundred mili-seconds"...


Regards

Takashi Sakamoto
