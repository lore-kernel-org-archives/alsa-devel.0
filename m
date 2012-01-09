From: Sangbeom Kim <sbkim73@samsung.com>
Subject: Re: [PATCH] ASoC: Fix idma build after update for
 channel count check
Date: Mon, 09 Jan 2012 16:33:04 +0900
Message-ID: <01d601cccea0$ec6716d0$c5354470$@com>
References: <1326092003-21997-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<CAGhQ9VzN-BWtM4XC1uL3VrTNFZN-j4xE1LXzO92zfTB80aWLbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by alsa0.perex.cz (Postfix) with ESMTP id 2FC7D10394B
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2012 08:33:01 +0100 (CET)
Received: from epcpsbgm1.samsung.com (mailout4.samsung.com [203.254.224.34])
	by mailout4.samsung.com
	(Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built
	Sep 7
	2010)) with ESMTP id <0LXI00N8PSXH0030@mailout4.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 09 Jan 2012 16:32:46 +0900 (KST)
Received: from DOSBKIM7302 ([12.23.120.118])
	by mmp2.samsung.com (Oracle Communications Messaging Exchange Server
	7u4-19.01 64bit (built Sep 7 2010)) with ESMTPA id
	<0LXI007ZNSYM0KX1@mmp2.samsung.com>
	for alsa-devel@alsa-project.org; Mon, 09 Jan 2012 16:32:46 +0900 (KST)
In-reply-to: <CAGhQ9VzN-BWtM4XC1uL3VrTNFZN-j4xE1LXzO92zfTB80aWLbQ@mail.gmail.com>
Content-language: ko
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Joachim Eastwood' <manabian@gmail.com>, 'Mark Brown' <broonie@opensource.wolfsonmicro.com>
Cc: 'Joachim Eastwood' <joachim.eastwood@jotron.com>, alsa-devel@alsa-project.org, 'Liam Girdwood' <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Joachim,

On Mon, Jan 9, 2012 at 4:08 PM, Joachim Eastwood wrote:
> I accidentally added the brace to the if test in "ASoC: check for
> substream not channels_min in pcm engines".
> So you either remove the brace from the if test or add another one as you
> did.
> 
> Acked-by: Joachim Eastwood <joachim.eastwood@jotron.com>
> 

Thanks for your care to ASoC Samsung code.
If you change ASoC Samsung code, Could you please include me in the CC list?

Acked-by: Sangbeom Kim <sbkim73@samsung.com>

Thanks,
Sangbeom.
