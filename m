From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Card information in /proc or /sys
Date: Tue, 29 Jun 2010 08:45:45 +0200
Message-ID: <4C299699.8020507@ladisch.de>
References: <4C28F23A.9050804@faberman.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 021B8243E9
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Jun 2010 08:46:01 +0200 (CEST)
In-Reply-To: <4C28F23A.9050804@faberman.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Florian Faber <faber@faberman.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Florian Faber wrote:
> I want to expose more information about the sound card's ports (names,
> connectors etc.) to userspace in a standardized manner.

There is not yet a standard for this type of information.

There are plans to expose this in the form of TLV structures, which can
be attached to mixer controls or returned by new IOCTLs.


Regards,
Clemens
