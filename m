From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH v3 04/16] ALSA: Oxygen: Add CS4245_SPI_READ
 constant
Date: Sat, 18 Jan 2014 11:29:36 +0100
Message-ID: <52DA5790.3050609@ladisch.de>
References: <1389971315-3215-1-git-send-email-v1ron@mail.ru>
 <1389971315-3215-4-git-send-email-v1ron@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 39A47261A28
 for <alsa-devel@alsa-project.org>; Sat, 18 Jan 2014 11:29:47 +0100 (CET)
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id BC2EC20A0A
 for <alsa-devel@alsa-project.org>; Sat, 18 Jan 2014 05:29:46 -0500 (EST)
In-Reply-To: <1389971315-3215-4-git-send-email-v1ron@mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Roman Volkov <v1ron@mail.ru>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Roman Volkov wrote:
> The driver needs this constant to perform SPI read operations.
> The shift from CS4245_SPI_ADDRESS and CS4245_SPI_WRITE constants
> removed, since when we need to send two bytes instead of three
> in the SPI packet, we need to shift left by 8 instead of 16.
>
> -#define CS4245_SPI_ADDRESS	(0x9e << 16)
> -#define CS4245_SPI_WRITE	(0 << 16)
> +#define CS4245_SPI_ADDRESS	0x9e
> +#define CS4245_SPI_WRITE	0

This change alone breaks the driver.

All patches must be self-contained, which is important to be able to
apply the patch series partially during debugging.

Please merge this with the patch that changes the SPI code.


Regards,
Clemens
