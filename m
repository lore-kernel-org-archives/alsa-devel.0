From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_dummy on Centos - Redhat
Date: Thu, 03 Sep 2009 13:50:26 +0200
Message-ID: <4A9FAD82.3050207@ladisch.de>
References: <7c5010d60909020912k1b9b64bdsab2363c4762e8c5c@mail.gmail.com>	<4A9E9CB7.8040809@ladisch.de>
	<7c5010d60909020933n47381069uacadd656aa98e8e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 6BD96244C1
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Sep 2009 14:04:26 +0200 (CEST)
In-Reply-To: <7c5010d60909020933n47381069uacadd656aa98e8e8@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Giovanni Maruzzelli <gmaruzz.lists@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

(please don't top-post)

Giovanni Maruzzelli wrote:
> In centos is 1000HZ, in the kernels I compiled is 100HZ

I would have expected these to be the other way around, since higher
timer frequency should result in more accurate simulated sound card
interrupts.

Do you have different CONFIG_PREEMPT* settings?

You could try compiling with the original CentOS configuration and
switching settings until it breaks.


Best regards,
Clemens
