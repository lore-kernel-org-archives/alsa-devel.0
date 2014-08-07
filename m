From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH] ASoC: rt286: Add API to set supported jack
	type
Date: Thu, 7 Aug 2014 01:43:24 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D7608E00@RTITMBSV03.realtek.com.tw>
References: <1407217970-20126-1-git-send-email-bardliao@realtek.com>
 <20140806205421.GZ17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id DC769261B02
 for <alsa-devel@alsa-project.org>; Thu,  7 Aug 2014 03:43:30 +0200 (CEST)
In-Reply-To: <20140806205421.GZ17528@sirena.org.uk>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Thursday, August 07, 2014 4:54 AM
> To: Bard Liao
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org; lars@metafoo.de;
> Flove; Oder Chiou
> Subject: Re: [PATCH] ASoC: rt286: Add API to set supported jack type
> 
> On Tue, Aug 05, 2014 at 01:52:50PM +0800, bardliao@realtek.com wrote:
> > From: Bard Liao <bardliao@realtek.com>
> >
> > RT286 need to configure the jack type (combo or non-combo) according
> > to the HW design. This function is given a easy way to set the correct
> > jacy type for those without platform data supported.
> 
> If this is coming from the hardware design I'd expect this to be configured
> via platform data or firmware data rather than with an API.
> Why do it this way?

Actually, this patch is for Intel platform which doesn't support platform data
yet. That's why we create an API so they can call the API in machine driver.

> 
> ------Please consider the environment before printing this e-mail.
