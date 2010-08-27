From: Timur Tabi <timur@freescale.com>
Subject: Re: imx-ssi in master mode?
Date: Thu, 26 Aug 2010 20:15:58 -0500
Message-ID: <AANLkTimoyDKWnvETOMat=t2Ns_dwmZhggPbJUoS+6gQX@mail.gmail.com>
References: <4C7688A3.9090700@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 765B824503
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Aug 2010 03:15:59 +0200 (CEST)
Received: by iwn4 with SMTP id 4so2062208iwn.38
	for <alsa-devel@alsa-project.org>; Thu, 26 Aug 2010 18:15:58 -0700 (PDT)
In-Reply-To: <4C7688A3.9090700@googlemail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sven Zeisberg <sven.zeisberg@googlemail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 26, 2010 at 10:30 AM, Sven Zeisberg
<sven.zeisberg@googlemail.com> wrote:

> Now I'm wondering if anybody has successfully used a codec with the
> i.MX25 SSI set up as Master. When we do this here, we can see that the
> i.MX25 is generating the bit clock but no frame sync.

This is board-dependent.  That is, you would need to have a board that
was wired up for the SSI to be in master mode before you can start
working on the driver.

-- 
Timur Tabi
Linux kernel developer at Freescale
