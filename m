From: Timur Tabi <timur@freescale.com>
Subject: Re: Cirrus Logic CS42L52 Low power codec
Date: Mon, 18 Feb 2008 09:06:38 -0600
Message-ID: <47B99EFE.7060303@freescale.com>
References: <1203344273.4063.6.camel@localhost.localdomain>	<20080218143655.GE21314@rakim.wolfsonmicro.main>
	<1203345949.4063.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C5841038F1
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 16:06:53 +0100 (CET)
In-Reply-To: <1203345949.4063.8.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Brian Austin wrote:
> I was under the impression that the ASoc v1 ties the codec to a specific
> machine, and that v2 eliminates that need.  Is that a correct
> assumption?

Not exactly.  The codec isn't technically tied to the machine with V1, but on 
some architecture (like PowerPC), it might be difficult to get configuration 
information to the codec driver without a cooperating machine driver.

-- 
Timur Tabi
Linux kernel developer at Freescale
