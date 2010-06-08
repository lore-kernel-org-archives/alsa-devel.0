From: Ryan Mallon <ryan@bluewatersys.com>
Subject: Re: [RFC PATCH v3 0/3] ep93xx i2s audio
Date: Tue, 08 Jun 2010 12:38:18 +1200
Message-ID: <4C0D90FA.5020400@bluewatersys.com>
References: <1275628285-12642-1-git-send-email-ryan@bluewatersys.com>
	<1275914732.3045.105.camel@odin>
	<4C0D58BB.5030505@bluewatersys.com>
	(sfid-20100607_213827_729716_0AEBDFD1)
	<F302D76F-8D7D-4F4B-ACC5-D7F76998AA4A@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hayes.bluewaternz.com (mail.bluewatersys.com [202.124.120.130])
	by alsa0.perex.cz (Postfix) with ESMTP id 27AF7103880
	for <alsa-devel@alsa-project.org>;
	Tue,  8 Jun 2010 02:38:20 +0200 (CEST)
In-Reply-To: <F302D76F-8D7D-4F4B-ACC5-D7F76998AA4A@opensource.wolfsonmicro.com>
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
Cc: john.cooper@third-harmonic.com, chasedouglas@gmail.com, dhuggins@cs.cmu.edu, alsa-devel@alsa-project.org, Russell King <rmk@arm.linux.org.uk>, r&d4@dave-tech.it, hartleys@visionengravers.com, buytenh@wantstofly.org, marshall@coolbananas.co.nz, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On 7 Jun 2010, at 21:38, Ryan Mallon wrote:
> 
>> Russell, Mark has picked up patch 2/3 via the alsa tree. Should I submit
>> 1/3 and 3/3 via the arm patch system with Liam's ack?
> 
> At least 3/3 needs to go via the ASoC tree since it depends on 2/3. It may make sense for all of them to go that way, or perhaps 1/3 could go separately via the ARM tree (in which case I'd ack it too).

I really don't mind either way, unless Russell has objections to the
core patches going via the alsa tree.

I want to make a couple of changes suggested by Hartley to patches 1/3
and 3/3 which will cleanup the registration interface a little. I will
repost the patches hopefully later today.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan@bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
