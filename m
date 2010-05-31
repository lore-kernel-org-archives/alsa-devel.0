From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: Re: alsa-driver-1.0.23 fails to build on ppc
Date: Mon, 31 May 2010 15:13:00 +0200
Message-ID: <20100531131300.GA8279@aragorn.home.lxtec.de>
References: <20100529101637.GA17139@aragorn.home.lxtec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpout0.hostsharing.net (smtpout0.hostsharing.net
	[83.223.95.250])
	by alsa0.perex.cz (Postfix) with ESMTP id 923841038E9
	for <alsa-devel@alsa-project.org>;
	Mon, 31 May 2010 15:13:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100529101637.GA17139@aragorn.home.lxtec.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>, pkg-alsa-devel <pkg-alsa-devel@lists.alioth.debian.org>
List-Id: alsa-devel@alsa-project.org

* Elimar Riesebieter [100529 12:16 +0200]
> Hi,
> 
> preparing alsa-driver-1.0.23 for Debian upload I found while building modules all:
> 
>   LD [M]  /usr/src/modass/usr_src/modules/alsa-driver/aoa/core/snd-aoa.o
>   CC [M]  /usr/src/modass/usr_src/modules/alsa-driver/aoa/fabrics/layout.o
> In file included from /usr/src/modass/usr_src/modules/alsa-driver/aoa/fabrics/layout.c:2:
> /usr/src/modass/usr_src/modules/alsa-driver/aoa/fabrics/../../alsa-kernel/aoa/fabrics/layout.c: In function 'check_codec':
> /usr/src/modass/usr_src/modules/alsa-driver/aoa/fabrics/../../alsa-kernel/aoa/fabrics/layout.c:772: error: 'struct device_node' has no member named 'phandle'

Hmm, on 2.6.32|3 linux_phandle works. On 2.6.34 phandle.

Any hint?

Elimar

-- 
  On the keyboard of life you have always
  to keep a finger at the escape key;-)
