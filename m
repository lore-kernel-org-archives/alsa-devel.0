From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC] [PATCH] firewire-lib: add support for AV/C
	deferred transaction
Date: Sat, 15 Mar 2014 22:09:12 +0900
Message-ID: <532450F8.10202@sakamocchi.jp>
References: <5323151D.3010706@sakamocchi.jp> <532381B7.3030903@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E0A126509E
 for <alsa-devel@alsa-project.org>; Sat, 15 Mar 2014 14:09:19 +0100 (CET)
In-Reply-To: <532381B7.3030903@ladisch.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>, linux1394-devel@lists.sourceforge.net, "ffado-devel@lists.sf.net" <ffado-devel@lists.sf.net>
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

(Mar 15 2014 07:24), Clemens Ladisch wrote:
> Looks OK.

Thanks for your quick review.

> In theory, a device that uses INTERIM is likely to need a larger timeout
> than the FCP default, but as long as 125 ms works for those BeBoB devices,
> increasing the timeout is not necessary.

With this value and BeBoB devices which I own, I have experienced no 
retry/timeout.

As long as I know, BeBoB based devices need much time to complete 
immediate/deferred transaction for changing sampling rate during 
streaming. In this case, immediate transactions need 150 msec or more 
and deferred transactions need 40/240msec or more to complete. But BeBoB 
driver must not change sampling rate in this case because sampling rate 
should not be changed during streaming. The driver should stop streaming 
once then change sampling rate.

I suggest that we will change this value when finding devices which need 
more timeout.


Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp
