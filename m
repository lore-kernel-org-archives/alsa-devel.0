From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Lynx Studio LynxTwo/L22 Driver
Date: Mon, 23 Jun 2003 12:50:08 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20030623125008.pochini@shiny.it>
References: <20030623032813-108400041>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (UNKNOWN@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id MAA08305
	for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2003 12:50:30 +0200
Received: from denise.shiny.it (denise.shiny.it [194.20.232.1])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id B526090
	for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2003 12:50:17 +0200 (MEST)
In-Reply-To: <20030623032813-108400041>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "D. Sen" <dsen@homemail.com>
Cc: alsa-devel@alsa-project.org, robbiex@bellsouth.net
List-Id: alsa-devel@alsa-project.org


On 23-Jun-2003 D. Sen wrote:
> Here's a question....
>
> Does Alsa drivers *have* to be in source code form? Can someone not 
> release an object file for linking....

ALSA is GPL. If you use any part of it (e.g. header files) then the
driver must be GPL too. You can workaround this, but it's extra work
to do. There are some closed-source drivers for Linux and for X.
Reading the notes of their website, I suppose they provide the
sources of generic code to drive the card. Perhaps if you only
use the documentation and you rewrite the driver fron scratch, you
can workaround (part of) the NDA. You should ask them directly, I'm
just guessing.


Bye.



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
