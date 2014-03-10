From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 16/39] firewire-lib: Add some AV/C general
	commands
Date: Mon, 10 Mar 2014 21:46:48 +0900
Message-ID: <531DB438.1070906@sakamocchi.jp>
References: <5316963F.1000206@sakamocchi.jp>
 <1394016507-15761-1-git-send-email-o-takashi@sakamocchi.jp>
 <1394016507-15761-17-git-send-email-o-takashi@sakamocchi.jp>
 <531CDE06.40604@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 051412656D4
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 13:46:53 +0100 (CET)
In-Reply-To: <531CDE06.40604@ladisch.de>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

(Mar 10 2014 06:32), Clemens Ladisch wrote:
> All these functions return errors with two different mechanisms, the AV/C
> response code or a negative Linux error code.  This forces the caller to
> add a second error check that duplicates the one inside the function:

It's my intension.

Currently firewire-lib doesn't support 'deferred transaction' defined in 
'AV/C Digital Interface Command Set General
Specification (4.0 or later as long as I know)'. Then each driver needs 
to judge response codes.

> Would there be problems if any response except ACCEPTED resulted in -EIO?

The speakers.c did it. So I just keep it.

> (And here, error should be err_buffer.)

Exactly.


Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp
