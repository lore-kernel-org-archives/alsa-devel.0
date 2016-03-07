From: John Lin <john.lin@realtek.com>
Subject: Re: [PATCH] ASoC: rt5616: add kcontrol for headphone
	channel switch
Date: Mon, 7 Mar 2016 02:35:55 +0000
Message-ID: <14AE6189BDA733429BF8455FEEF632980111074D@RTITMBSV02.realtek.com.tw>
References: <1456910320-6979-1-git-send-email-john.lin@realtek.com>
 <20160302103535.GH18327@sirena.org.uk>
 <14AE6189BDA733429BF8455FEEF632980110FFD1@RTITMBSV02.realtek.com.tw>
 <20160305035137.GX18327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id CBB472605CC
 for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2016 03:36:05 +0100 (CET)
In-Reply-To: <20160305035137.GX18327@sirena.org.uk>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>, "zhengsq@rock-chips.com" <zhengsq@rock-chips.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Saturday, March 05, 2016 11:52 AM
> To: John Lin
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org; Bard Liao; Flove;
> Oder Chiou; zhengsq@rock-chips.com
> Subject: Re: [PATCH] ASoC: rt5616: add kcontrol for headphone channel switch
> 
> On Thu, Mar 03, 2016 at 02:45:32AM +0000, John Lin wrote:
> 
> > Yes, It is another mute control that is missing on current driver.
> > This mute control is for headphone volume mute. Is it OK to rename it
> > to 'Headphone Volume Playback Switch'?
> 
> No, you should call it "Headphone Playback Switch".  Please see
> ControlNames.txt for details.

The schematic diagram of headphone is such as:

DAC --> HP Vol --> HP Vol Mute --> HP MIX --> HP Mute

The kcontrol named 'Headphone Playback Switch' was in use for 'HP Mute'.
The missing kcontrol is 'HP Vol Mute' in schematic diagram.
Could you give us advice in this case? Thank you very much.

> ------Please consider the environment before printing this e-mail.
