From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Update on TLV320AIC3204 Driver
Date: Tue, 15 Jun 2010 14:53:23 +0100
Message-ID: <20100615135322.GG14510@rakim.wolfsonmicro.main>
References: <20100611055512.GG23431@www.longlandclan.yi.org>
	<20100615002734.GB7759@www.longlandclan.yi.org>
	<20100615051110.GG7759@www.longlandclan.yi.org>
	<201006151642.32385.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 57C731038B1
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Jun 2010 15:53:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201006151642.32385.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, ext Stuart Longland <redhatter@gentoo.org>, Eric B??nard <eric@eukrea.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 15, 2010 at 04:42:32PM +0300, Peter Ujfalusi wrote:
> On Tuesday 15 June 2010 08:11:10 ext Stuart Longland wrote:
> > Okay, I've had a close inspection of how the SOC_DOUBLE_R_SX_TLV widgets
> > are implemented.  I couldn't find where in the git trees the control had
> > been added, I wound up applying this patch myself in my tree... it
> > apparently got applied in the official trees, but I cannot find it.

> I'm not really sure what the SOC_DOUBLE_R_SX_TLV is for... 

It's for value ranges which have normal unsigned integer mapping but
where the zero point is not at the lowest value so you need to wrap
around.  Which isn't actually what Stuart is looking for...

> But would a simple SOC_DOUBLE_R_TLV enough for the aic3204 codec?
> I have not looked at the datasheet (if it is available), but I'll try to find 
> it.
> Well looking at the _2r_sx functions in soc-core.c does not really clears the 
> intention, but at least I can see several things in the snd_soc_put_volsw_2r_sx 

...and this won't work since Stuart is looking for something that does
signed values which I don't think we have already, the standard stuff
all wants unsigned quantities.

> function, which can cause problems:
> - in error case it returns 0,

Yup, will fix that just now.

> - instead of updating the bits, it rewrites the register, which I think will 
> erase bits, which it should not touch.

It's just open coding the update bits so there's no actual problem here.

> - it has the ret variable, but it is not really used, and when it got assigned, 
> than it gets 1 in the success case. But luckily the return at the end of the 
> function is not using the ret, but 0.

Yeah, ret is a waste of time.

> - I'm not really sure if the 0xff masking is needed at all in the _sx functions, 
> since the values are masked with the mask anyways.

It's not really needed due to mask, yes.

> So I do not really follow what these suppose to do... Can someone give an 
> example of HW register, and the SX combination with the tlv struct? 

The only user is cs42l451.
