From: Sangbeom Kim <sbkim73@samsung.com>
Subject: Re: [PATCH] ASoC: samsung dma - prepare dma in
 start/resume trigger path
Date: Fri, 24 Aug 2012 19:06:52 +0900
Message-ID: <00f001cd81e0$2ed8ccf0$8c8a66d0$@com>
References: <1345755069-9512-1-git-send-email-dgreid@chromium.org>
 <00df01cd81cb$e21d2f00$a6578d00$@com>
 <CAEUnVG58NPNKuf_PRyBEegYnH95dkTN81PGZGYxDt41jhH2uaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A8B3265D53
 for <alsa-devel@alsa-project.org>; Fri, 24 Aug 2012 12:06:54 +0200 (CEST)
Received: from epcpsbgm1.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M99000BM83EN450@mailout3.samsung.com> for
 alsa-devel@alsa-project.org; Fri, 24 Aug 2012 19:06:51 +0900 (KST)
Received: from DOSBKIM7302 ([10.90.35.108])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0M990051F83EQR50@mmp1.samsung.com> for
 alsa-devel@alsa-project.org; Fri, 24 Aug 2012 19:06:50 +0900 (KST)
In-reply-to: <CAEUnVG58NPNKuf_PRyBEegYnH95dkTN81PGZGYxDt41jhH2uaQ@mail.gmail.com>
Content-language: ko
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: 'Dylan Reid' <dgreid@chromium.org>
Cc: alsa-devel@alsa-project.org, kgene.kim@samsung.com, alim.akhtar@samsung.com, padma.v@samsung.com, broonie@opensource.wolfsonmicro.com, ben-linux@fluff.org, olofj@chromium.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 24, 2012 at 4:52 PM, Dylan Reid wrote:
> Yes. Currently, if I suspend while playing, after resume it won't work
> until I close and reopen the device.  the call to snd_pcm_resume is
> not indicating an error, but a write error comes from snd_pcm_write a
> little later.

Ok, 
Please let me know your test environment.

Thanks,
Sangbeom.
