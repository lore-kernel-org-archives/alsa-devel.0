From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: ASOC: For SND_SOC_DAIFMT_IB_IF what is
	invert	baseed on?
Date: Sun, 26 Oct 2008 16:05:26 +0000
Message-ID: <1225037126.28382.85.camel@dell-desktop.example.com>
References: <4e090d470810250931k5e44a4cck3ad0186a2c47ec03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from slimlogic.co.uk (slimlogic.co.uk [89.16.172.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 977FF243C7
	for <alsa-devel@alsa-project.org>; Sun, 26 Oct 2008 17:05:49 +0100 (CET)
In-Reply-To: <4e090d470810250931k5e44a4cck3ad0186a2c47ec03@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Richard Zhao <linuxzsc@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 2008-10-26 at 00:31 +0800, Richard Zhao wrote:
> Hi,
> 
> include/sound/soc.h
> /*
>  * DAI hardware signal inversions
>  */
> #define SND_SOC_DAIFMT_NB_NF            (0 << 8)        /* normal bclk + frm */
> #define SND_SOC_DAIFMT_NB_IF            (1 << 8)        /* normal bclk
> + inv frm */
> #define SND_SOC_DAIFMT_IB_NF            (2 << 8)        /* invert bclk
> + nor frm */
> #define SND_SOC_DAIFMT_IB_IF            (3 << 8)        /* invert bclk + frm */
> 
> What are frame cock and bit clock invert based on? I2S, PCM or some
> else bus protocols? Or just high level voltage or low level voltage?
> 

Generic logic levels (high/low voltage) that can apply to I2S and PCM
DAI's.

Liam
