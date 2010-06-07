From: Ryan Mallon <ryan@bluewatersys.com>
Subject: Re: [RFC PATCH v3 0/3] ep93xx i2s audio
Date: Tue, 08 Jun 2010 08:38:19 +1200
Message-ID: <4C0D58BB.5030505@bluewatersys.com>
References: <1275628285-12642-1-git-send-email-ryan@bluewatersys.com>
	<1275914732.3045.105.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hayes.bluewaternz.com (mail.bluewatersys.com [202.124.120.130])
	by alsa0.perex.cz (Postfix) with ESMTP id B3F471037EE
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Jun 2010 22:38:21 +0200 (CEST)
In-Reply-To: <1275914732.3045.105.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, Russell King <rmk@arm.linux.org.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: john.cooper@third-harmonic.com, alsa-devel@alsa-project.org, chasedouglas@gmail.com, buytenh@wantstofly.org, r&d4@dave-tech.it, hartleys@visionengravers.com, marshall@coolbananas.co.nz, linux-arm-kernel@lists.infradead.org, dhuggins@cs.cmu.edu
List-Id: alsa-devel@alsa-project.org

Liam Girdwood wrote:
> On Fri, 2010-06-04 at 17:11 +1200, Ryan Mallon wrote:
>> The following patch series adds support for i2s audio on the ep93xx,
>> with the Snapper CL15 used as an example implementation.
>>
>> This version fixes a number of things from the previous round:
>>  - Removed unused #defines
>>  - Set symmetric rates for the cpu dai
>>  - Fixed the sdiv/lrdiv calculation loop
>>  - Moved the cpu dai registration
>>  - Removed empty ep93xx_pcm_prepare callback
>>  - Fixed enable/disable when both capture and playback are running
>>  
>> Capture still does not work. The dma is running, but the captured data
>> is all zeros (tested used arecord and loopback). I have a 2.6.20
>> kernel with ep93xx i2s audio working an capture works there on the
>> same hardware. I have spent sometime looking into this, but can't see
>> the problem. Would appreciate if someone can lend some insight as to
>> what I have done wrong.
>>
>> Ryan Mallon (3):
>>   ep93xx i2s core support
>>   ep93xx i2s audio driver
>>   Snapper cl15 audio support
> 
> All
> 
> Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

Russell, Mark has picked up patch 2/3 via the alsa tree. Should I submit
1/3 and 3/3 via the arm patch system with Liam's ack?

Thanks,
~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan@bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
