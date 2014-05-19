From: Oder Chiou <oder_chiou@realtek.com>
Subject: Re: [PATCH RFT] ASoC: rt5645: Fix updating wrong
	registerforT5645_AIF2 case
Date: Mon, 19 May 2014 07:41:07 +0000
Message-ID: <7EB0DE829A537248AF2ED30C97D1269436DBA2@RTITMBSV03.realtek.com.tw>
References: <1400325452.22102.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 408532625EF
 for <alsa-devel@alsa-project.org>; Mon, 19 May 2014 09:41:16 +0200 (CEST)
In-Reply-To: <1400325452.22102.1.camel@phoenix>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Axel Lin [mailto:axel.lin@ingics.com]
> Sent: Saturday, May 17, 2014 7:18 PM
> To: Mark Brown
> Cc: Oder Chiou; Bard Liao; Liam Girdwood; alsa-devel@alsa-project.org
> Subject: [PATCH RFT] ASoC: rt5645: Fix updating wrong register forT5645_AIF2
> case
> 
> This looks like a copy-paste bug, fix it.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> Hi,
> I don't have this h/w, so please test if this patch works.
> Axel
We've tested it, and it works properly, thanks.
