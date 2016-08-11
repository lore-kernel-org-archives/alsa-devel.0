From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 2/4] ALSA: seq: add an alternative way
	to	handle ioctl requests
Date: Thu, 11 Aug 2016 11:08:03 +0200
Message-ID: <f6b5ba17-b2e3-247b-b9dc-7acc4f2a968a@ladisch.de>
References: <1470905914-16382-1-git-send-email-o-takashi@sakamocchi.jp>
 <1470905914-16382-3-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 2863B266B2A
 for <alsa-devel@alsa-project.org>; Thu, 11 Aug 2016 11:08:04 +0200 (CEST)
In-Reply-To: <1470905914-16382-3-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> +	if (_IOC_DIR(handler->cmd) == IOC_IN) {
> ...
> +		    _IOC_DIR(handler->cmd) == IOC_OUT)

_IOC_DIR() returns a bit mask in which both _IOC_READ and _IOC_WRITE can
be set.  IOC_IN, IOC_OUT, and IOC_INOUT are shifted values.
(see include/uapi/asm-generic/ioctl.h)


Regards,
Clemens
