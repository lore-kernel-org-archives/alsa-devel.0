From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] Always link to libm
Date: Thu, 12 May 2011 16:34:28 +0200
Message-ID: <4DCBEFF4.20102@ladisch.de>
References: <1305203993-6878-1-git-send-email-a.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id BAE181037FC
	for <alsa-devel@alsa-project.org>;
	Thu, 12 May 2011 16:32:22 +0200 (CEST)
In-Reply-To: <1305203993-6878-1-git-send-email-a.stein@systec-electronic.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alexander Stein <a.stein@systec-electronic.com>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Alexander Stein wrote:
> Starting with commit 9b6df1cf64ea7ccb329b4922d138c1f36ace00c0
>   control: add ASCII parsers from amixer
> ctlparse.c uses ceil() and so libm is need unrelated to soft- or hardfloat.

The softfloat option is intended to avoid floating-point code.

The root cause of this problem is that ctlparse.c uses floatin-point
calculations unconditionally; it should be rewritten to use integer
math, or to drop the float parsing if compiled with softfloat.


Regards,
Clemens
