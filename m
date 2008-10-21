From: "Cai, Cliff" <Cliff.Cai@analog.com>
Subject: Re: [PATCH 2/3] ASoC: Blackfin: add multi-channel
	supporting in Blackfin ASoC driver and AD1980 codec driver
Date: Tue, 21 Oct 2008 18:33:27 +0800
Message-ID: <0F1B54C89D5F954D8535DB252AF412FA02E6638E@chinexm1.ad.analog.com>
References: <1224560173-8728-1-git-send-email-cooloney@kernel.org>
	<1224560173-8728-3-git-send-email-cooloney@kernel.org>
	<20081021083715.GA10841@sirena.org.uk>
	<0F1B54C89D5F954D8535DB252AF412FA02E66236@chinexm1.ad.analog.com>
	<20081021091550.GE10841@sirena.org.uk>
	<0F1B54C89D5F954D8535DB252AF412FA02E662B0@chinexm1.ad.analog.com>
	<s5hhc762sp1.wl%tiwai@suse.de>
	<386072610810210255s5a267db3h65a4c6c1bfca19f3@mail.gmail.com>
	<20081021101515.GI10841@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail10.analog.com (nwd2mail10.analog.com [137.71.25.55])
	by alsa0.perex.cz (Postfix) with ESMTP id 9B55A103832
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Oct 2008 12:31:44 +0200 (CEST)
Content-class: urn:content-classes:message
In-Reply-To: <20081021101515.GI10841@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>, Bryan Wu <cooloney@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, "Cai, Cliff" <Cliff.Cai@analog.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

 

>-----Original Message-----
>From: Mark Brown [mailto:broonie@sirena.org.uk] 
>Sent: Tuesday, October 21, 2008 6:15 PM
>To: Bryan Wu
>Cc: Takashi Iwai; Cai, Cliff; alsa-devel@alsa-project.org
>Subject: Re: [alsa-devel] [PATCH 2/3] ASoC: Blackfin: add 
>multi-channel supporting in Blackfin ASoC driver and AD1980 
>codec driver
>
>On Tue, Oct 21, 2008 at 05:55:23PM +0800, Bryan Wu wrote:
>
>> But you know, it is very difficult for us to allocate big 
>buffer in an 
>> NOMMU machine (such as Blackfin) on the fly, So we prefer to 
>allocate 
>> them at the beginning. And in the embedded world, when the user want 
>> to use multi-channel function, they will enable this option. If they 
>> don't, they won't do that. It is very simple for both us and our 
>> users, although it is less elegant than Mark's idea.
>
>So the issue is that you want to force a static allocation at 
>startup due to hardware limitations?  That makes a bit more 
>sense.  I guess that's OK but I'd suggest changing the code to 
>also allow the user to select four channels - not all 
>multi-channel systems use six channels.

The buffer struct of ac97 frame for 4/6 channels only has one slot
difference -- LFE slot,
6-channel mode does support 4-channel mode.

>Another option would be to select it at driver startup time.
>
>I'm still not sure that this is something that should be 
>selected via the kernel configuration rather than by the 
>machine driver - I would expect the use of six channels to be 
>a property of the system rather than of the particular kernel build.
>
