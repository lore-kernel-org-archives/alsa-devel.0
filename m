From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: how to link multi plugin to dsnoop ?
Date: Wed, 11 May 2011 18:57:25 +0200
Message-ID: <4DCABFF5.7080507@ladisch.de>
References: <BANLkTinPN1Whe-0u53S7MD81a018eZukrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id AE5B6247BC
	for <alsa-devel@alsa-project.org>;
	Wed, 11 May 2011 18:55:18 +0200 (CEST)
In-Reply-To: <BANLkTinPN1Whe-0u53S7MD81a018eZukrQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vincent Meserette <vmeserette@aldebaran-robotics.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Vincent Meserette wrote:
> Does someone know how can I route the multi plugin to dsnoop ?

The dmix/dshare/dsnoop plugins work only directly on a hardware device.

Use two dsnoop plugins on the hw devices, then tie them together with
a multi.


Regards,
Clemens
