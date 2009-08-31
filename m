From: "Pedro I. Sanchez" <psanchez@fosstel.com>
Subject: Re:
 =?utf-8?q?How_to_support_multiple_audio_codecs_on_a_?=
 =?utf-8?q?single=09board?=
Date: Mon, 31 Aug 2009 13:30:05 -0400
Message-ID: <aa38d64f273f66fdc188ddfcfc23909a@colcan.ca>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0309F5A565@dbde02.ent.ti.com>
	<20090831131605.GA16998@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from a2s40.a2hosting.com (a2s40.a2hosting.com [74.126.24.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B9A6103813
	for <alsa-devel@alsa-project.org>;
	Mon, 31 Aug 2009 19:30:09 +0200 (CEST)
In-Reply-To: <20090831131605.GA16998@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 31 Aug 2009 14:16:06 +0100, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Aug 31, 2009 at 02:48:55PM +0530, Aggarwal, Anuj wrote:
> 
>> I have 3 instances of AIC23 on my board and all are connected to 
>> different I2C/McBSP and hence can be used independently. How should 
>> I use/modify the current AIC23 driver and write the asoc board-specific
>> file to enable all the AIC23 instances? Is there any similar 
>> implementation in the audio subsystem which I can look as a reference?
> 
> This is not currently supported; it needs a lot of work in the core to
> allow multiple CODEC drivers to coexist.  Things like and the
> presentation of controls to user space can't really cope at the minute.
> It's a bit easier in your case since you essentially have three sound
> cards (rather than one card with multiple CODECS) but there's still a
> bit of work needed around device registration.
> 
> For now you'll need to write three machine drivers only one of which is
> permitted to be loaded at once; once the core has this support added
> you'll then be able to load all three at once and have the three appear
> as separate sound cards.  If you'd like to contribute the core support
> that'd be excellent :)
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
Pedro I. Sanchez

What if the codecs are different? My board has a playback-only device
(TAS5709) and a capture-only device (PCM1800). Would it be OK to implement
a single machine driver with num_dai=2? Or would you suggest to implement
two different sound cards?


-- 
Pedro
