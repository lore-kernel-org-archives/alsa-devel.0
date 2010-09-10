From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: M-Audio Fast Track Ultra (8r) mixer: How to verify
 dB	information?
Date: Fri, 10 Sep 2010 12:33:20 +0200
Message-ID: <4C8A0970.4080602@ladisch.de>
References: <4C89539E.8030701@web.de> <4C89DBC5.7070906@ladisch.de>
	<4C89E2CA.2090206@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 7B1D4103981
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 12:32:58 +0200 (CEST)
In-Reply-To: <4C89E2CA.2090206@web.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felix Homann <fexpop@web.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Felix Homann wrote:
> Well, according to alsamixer the mixer values are mapped to a range from 
> 0 to -128 dB.
> 
> 'amixer contents' show entries of the form
> 
>        | unk-4-0xffffce00,0x00000000,

Install the latest alsa-utils, or if you already have it, recompile it.


Regards,
Clemens
