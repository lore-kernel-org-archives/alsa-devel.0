From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: [PATCH] opti931: additional check for OPL3 device
Date: Mon, 17 Sep 2007 12:39:53 +0200
Message-ID: <1190025593.12774.1211014755@webmail.messagingengine.com>
References: <8c74410a0709140735j3903a11dp23f783d45bffc55c@mail.gmail.com>
	<1189781567.3648.1210664373@webmail.messagingengine.com>
	<20070914184705.9ba48d80.krzysztof.h1@gmail.com>
	<1190016893.19336.1210994773@webmail.messagingengine.com>
	<46EE5284.9070202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id DD58110384F
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Sep 2007 12:39:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <46EE5284.9070202@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@gmail.com>
Cc: Krzysztof Helt <krzysztof.h1@gmail.com>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Rene Herman wrote:
> On 09/17/2007 10:14 AM, Clemens Ladisch wrote:
> > Krzysztof Helt wrote:
> >> Should the OPL4 detection has the same fallback or just all Opti cards
> >> should search the FM chip at the range + 8 address?
> > 
> > It appears a fallback shoudn't be needed because the chip always returns 
> > a range suitable for an OPL4.
> > 
> > Since an OPL3 range is never larger than 8 bytes, and OPL4 needs 16 
> > bytes, we could add 8 to get the FM address _if_ the range is at least 16
> > bytes; thus we are safe even if a chip publishes an OPL3-only range.
> 
> At least 16 won't do -- the OPTi chip provides a 12-byte range. More than 8 
> would work, but just +8 is fine. I have all OPTi ISA-PnP chips (924, 925, 
> 931, 933) and more aren't going to be produced. The 0x380 base is what it 
> calls the OPL4Base and ALBase (AdLib) is at 0x388.

Are there chips that have both OPL4Base and ALBase?

> The chip can defer to external FM it seems, but even if there are OPTi/OPL4 
> combo's out there in the wild (I sort of doubt it)

Why?

> the driver's just doing opl3 anyway. ie, still needs just the +8.

Only the 93x driver; the 92x driver has OPL4 support.


Regards,
Clemens
