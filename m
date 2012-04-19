From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [english 100%] Re:  Steinberg CMC
Date: Thu, 19 Apr 2012 19:02:36 +0200
Message-ID: <4F90452C.4000909@ladisch.de>
References: <3DADBEB76B314C5EAC8F789321D691E7@nanhstxbtkmyli>
	<4F902D1E.2040604@ladisch.de>
	<7746C177000D4267B9F6B2F01F8D7128@nanhstxbtkmyli>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 45F4A246B0
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Apr 2012 19:02:50 +0200 (CEST)
In-Reply-To: <7746C177000D4267B9F6B2F01F8D7128@nanhstxbtkmyli>
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
> Probably 1062 1063 1064 are the CMC- FD PD and QC but in which order?

The important information is the ID.
The name can be read from the device's descriptors; this parameter is there
just to allow overriding it.

> I understand the patch is trivial it is three lines to add. But I need to
> get the development version to submit it. Otherwise if in the meantime the
> 105f and the 1066 are entered, my patch will return an error.
>
> ... or can the maintainers do it?

Such conflicts would be trivial to resolve.


Regards,
Clemens
