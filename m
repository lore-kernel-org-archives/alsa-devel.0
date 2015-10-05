From: Oder Chiou <oder_chiou@realtek.com>
Subject: Re: [PATCH] ASoC: rt286: Fix the runtime error in the
	booting
Date: Mon, 5 Oct 2015 04:09:58 +0000
Message-ID: <7EB0DE829A537248AF2ED30C97D12694F9A57E@RTITMBSV03.realtek.com.tw>
References: <1443763829-9359-1-git-send-email-oder_chiou@realtek.com>
 <20151002101141.GO12635@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D76D2652CE
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2015 06:10:20 +0200 (CEST)
In-Reply-To: <20151002101141.GO12635@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, Bard Liao <bardliao@realtek.com>, "flubba86@gmail.com" <flubba86@gmail.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Friday, October 02, 2015 6:12 PM
> To: Oder Chiou
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org; Flove; Bard Liao; John Lin;
> flubba86@gmail.com
> Subject: Re: [PATCH] ASoC: rt286: Fix the runtime error in the booting
> 
> On Fri, Oct 02, 2015 at 01:30:29PM +0800, Oder Chiou wrote:
> > The struct rt286_index_def was used by the cache function, so it cannot be
> > declared as const.
> 
> > -static const struct reg_default rt286_index_def[] = {
> > +static struct reg_default rt286_index_def[] = {
> >  	{ 0x01, 0xaaaa },
> >  	{ 0x02, 0x8aaa },
> >  	{ 0x03, 0x0002 },
> 
> This isn't obvious and seems likely to break - why is this ever being
> modified and how is that safe?
The table was used for the cache function of the index table, so it would be
changed the value in the index register writing. The breaking is in that the
variable of type "const" is changing. And the wrong modification was
committed by "c418a84a8c8f98b1a0f30cd68d0cdf40d77aed01". The modifications of
the commit are correct in the conventional case, but it will be breaking in
case of rt286 and rt298.
