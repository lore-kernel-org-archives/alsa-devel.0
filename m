From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH 2/2] ASoC: DAPM - Make sure DAPM widget IO
 ops hold the component mutex.
Date: Fri, 9 Mar 2012 17:26:02 +0000
Message-ID: <CAOZdJXUy-hCOEk6beBrjv16iknsMWTHc+AxSyw-L8-hLEXQYSw@mail.gmail.com>
References: <1331057779-4630-1-git-send-email-lrg@ti.com>
	<1331057779-4630-2-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
	(va3ehsobe006.messaging.microsoft.com [216.32.180.16])
	by alsa0.perex.cz (Postfix) with ESMTP id DA46E104666
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 18:26:14 +0100 (CET)
In-Reply-To: <1331057779-4630-2-git-send-email-lrg@ti.com>
Content-Language: en-US
Content-ID: <43A2F2780C98064E8CBCE740D0E04CBA@mgd.freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 6, 2012 at 12:16 PM, Liam Girdwood <lrg@ti.com> wrote:
> Currently not all DAPM widget IO ops are holding their component mutex
> (codec or platform). Make sure this is now held for DAPM widget IO operations.
>
> Signed-off-by: Liam Girdwood <lrg@ti.com>

This patch breaks the P1022DS, which uses the WM8776 as a codec.  The
MPC8610HPCD, which is identical to the P1022DS but uses the CS4270
codec instead, works fine.

I'm guessing it's some kind of deadlock, because as soon as I start
playback, the system halts.  Not even Ctrl-C works.

-- 
Timur Tabi
Linux kernel developer at Freescale
