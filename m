From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: Writing an AT91SAM9260-EK Dumb Codec Driver
Date: Tue, 19 Jun 2007 16:31:06 +0100
Message-ID: <1182267066.26658.164.camel@localhost.localdomain>
References: <61c0054e0706151146i26514503hb0bfc99ad8399791@mail.gmail.com>
	<1181934519.26658.94.camel@localhost.localdomain>
	<61c0054e0706151406o2cc8b4c2x502e7fdb38a39a3e@mail.gmail.com>
	<61c0054e0706180851y49fc8c1cs7a27c4f84d10904f@mail.gmail.com>
	<61c0054e0706181007g6d7b9de0te1c27ffefebc2225@mail.gmail.com>
	<1182186958.26658.118.camel@localhost.localdomain>
	<1182187444.26658.121.camel@localhost.localdomain>
	<61c0054e0706181037i67e64668h2528cf756f963067@mail.gmail.com>
	<61c0054e0706181230o3e7f68b0u4ebd7e02f70e96e8@mail.gmail.com>
	<1182245470.26658.128.camel@localhost.localdomain>
	<61c0054e0706190741q56f3ae77of24a227c11f180bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 9402C103810
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jun 2007 17:31:07 +0200 (CEST)
In-Reply-To: <61c0054e0706190741q56f3ae77of24a227c11f180bb@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Kavan <pkavan@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2007-06-19 at 09:41 -0500, Paul Kavan wrote:

> 
> checking for ALSA LDFLAGS...  -lasound -lm -ldl -lpthread 
> checking for libasound headers version >= 1.0.12... not present.
> configure: error: Sufficiently new version of libasound not found.
> 
> 
> Not sure what is the problem here. I have 
> 

configure cant find your libasound headers. Either your recently built
libasound and it's headers are in the wrong place or configure is
looking in the wrong place.

It's maybe worth spending a few hours installing and getting used to OE
atm as this takes away all this cross compiling pain (esp if you are
building packages with lots of dependencies). 

Liam
