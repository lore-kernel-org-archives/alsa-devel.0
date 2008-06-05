From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: is sound/arm obsolete?
Date: Thu, 05 Jun 2008 13:56:01 +0100
Message-ID: <1212670561.3480.17.camel@localhost.localdomain>
References: <9c1cad6e0806050550k694c825bq341db0228a1c9ecb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7A4B2245A0
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jun 2008 14:56:02 +0200 (CEST)
In-Reply-To: <9c1cad6e0806050550k694c825bq341db0228a1c9ecb@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Maen Suleiman <maen.suleiman@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2008-06-05 at 15:50 +0300, Maen Suleiman wrote:
> Hi all,
> 
> We are intending to develop a new ALSA driver for an audio unit on
> Marvell Orion SoC, should a new ALSA drivers written for ARM based
> SoCs be developed under sound/arm or under sound/soc/newsoc ? (is
> sound/arm considered as obsolete? )

It would be better to develop under soc/orion as this will allow your
DMA and I2S code to be used by others with different Orion audio
configurations. 

It may also save you development time if your target codec is already
supported !

Liam
