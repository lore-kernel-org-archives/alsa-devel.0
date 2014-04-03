From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 17/44] fireworks: Add transaction and some
 commands
Date: Thu, 03 Apr 2014 22:15:23 +0200
Message-ID: <533DC15B.8030103@ladisch.de>
References: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
 <1395400229-22957-18-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 2EFE02656D8
 for <alsa-devel@alsa-project.org>; Thu,  3 Apr 2014 22:15:28 +0200 (CEST)
In-Reply-To: <1395400229-22957-18-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> +#define MEMORY_SPACE_EFW_RESPONSE	0xecc080000000
> +/* this is for juju convinience? */
> +#define MEMORY_SPACE_EFW_END		0xecc080000200

A single write transaction cannot be larger than 0x200 bytes.


Regards,
Clemens
