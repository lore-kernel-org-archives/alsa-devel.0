From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 05/44] firewire-lib: Add support for MIDI
	capture/playback
Date: Thu, 03 Apr 2014 19:08:16 +0900
Message-ID: <533D3310.30005@sakamocchi.jp>
References: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
 <1395400229-22957-6-git-send-email-o-takashi@sakamocchi.jp>
 <533C6510.7000605@ladisch.de> <533D1CF4.1040302@sakamocchi.jp>
 <533D21DD.10400@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 231E2265685
 for <alsa-devel@alsa-project.org>; Thu,  3 Apr 2014 12:08:28 +0200 (CEST)
In-Reply-To: <533D21DD.10400@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, Adrian Knoth <adi@drcomp.erfurt.thur.de>, jan.svitok@gmail.com
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

(Apr 03 2014 17:54), Clemens Ladisch wrote:
> This is still wrong.  It should be:
>
> 		len = b[0] - 0x80;
> 		if (1 <= len && len <= 3 && s->midi[port])

Oops! Exactly.

I might be tired for this long developing...


Thank you

Takashi Sakamoto
o-takashi@sakamocchi.jp
