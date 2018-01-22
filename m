From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] ASoC: atmel: Remove check for node pointer
Date: Mon, 22 Jan 2018 15:20:57 +0100
Message-ID: <f9fe1a4c-b855-22b4-c46b-837a03ae9d06@axentia.se>
References: <20180122141557.GA29226@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20091.outbound.protection.outlook.com [40.107.2.91])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E32A267376
 for <alsa-devel@alsa-project.org>; Mon, 22 Jan 2018 15:21:03 +0100 (CET)
In-Reply-To: <20180122141557.GA29226@lenoch>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ladislav Michl <ladis@linux-mips.org>, alsa-devel@alsa-project.org
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nicolas Ferre <nicolas.ferre@microchip.com>
List-Id: alsa-devel@alsa-project.org

On 2018-01-22 15:15, Ladislav Michl wrote:
> Probe function is called only after DT compatible is matched,
> thus node pointer cannot be NULL.
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

Sure,

Acked-by: Peter Rosin <peda@axentia.se>

Cheers,
peda
