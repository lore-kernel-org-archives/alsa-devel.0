From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Steinberg CMC
Date: Thu, 19 Apr 2012 17:19:58 +0200
Message-ID: <4F902D1E.2040604@ladisch.de>
References: <3DADBEB76B314C5EAC8F789321D691E7@nanhstxbtkmyli>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 612F32463C
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Apr 2012 17:16:50 +0200 (CEST)
In-Reply-To: <3DADBEB76B314C5EAC8F789321D691E7@nanhstxbtkmyli>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Patrick <patrick.pub@nerim.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Patrick wrote:
> I own 3 of the 6 Steinberg control surfaces CMC series
>
> To run them, I added some entries in the (usb) quirk-table.
>
> They are midi input and output of vendor ID Yahama and products as the
> following
> CMC-CH 0x1060
> CMC-TP 0x1061
> CMC-AI 0x1065

I wonder what the other three IDs might be ...  ;-)

> Where to notify that

Here.

> For the patch, should I paste the lines in the last Linux Kernel
> version and create the patch?

Yes.  See Documentation/SubmittingPatches for details, but a patch
like this is really trivial.


Regards,
Clemens
