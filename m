From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 2/4] ALSA: seq: add an alternative way to
 handle ioctl requests
Date: Fri, 12 Aug 2016 03:48:26 +0900
Message-ID: <fc4aab0e-047d-999a-859e-767c661a4ca8@sakamocchi.jp>
References: <1470905914-16382-1-git-send-email-o-takashi@sakamocchi.jp>
 <1470905914-16382-3-git-send-email-o-takashi@sakamocchi.jp>
 <f6b5ba17-b2e3-247b-b9dc-7acc4f2a968a@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 01762267597
 for <alsa-devel@alsa-project.org>; Thu, 11 Aug 2016 20:48:28 +0200 (CEST)
In-Reply-To: <f6b5ba17-b2e3-247b-b9dc-7acc4f2a968a@ladisch.de>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

On Aug 11 2016 18:08, Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> +	if (_IOC_DIR(handler->cmd) == IOC_IN) {
>> ...
>> +		    _IOC_DIR(handler->cmd) == IOC_OUT)
> 
> _IOC_DIR() returns a bit mask in which both _IOC_READ and _IOC_WRITE can
> be set.  IOC_IN, IOC_OUT, and IOC_INOUT are shifted values.
> (see include/uapi/asm-generic/ioctl.h)

Thanks for the correction. Yes, it's my overlook. I should have used
logical OR.


Thanks

Takashi Sakamoto
