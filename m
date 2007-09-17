From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] opti931: additional check for OPL3 device
Date: Mon, 17 Sep 2007 15:57:21 +0200
Message-ID: <46EE87C1.9010908@gmail.com>
References: <8c74410a0709140735j3903a11dp23f783d45bffc55c@mail.gmail.com>	<1189781567.3648.1210664373@webmail.messagingengine.com>	<20070914184705.9ba48d80.krzysztof.h1@gmail.com>	<1190016893.19336.1210994773@webmail.messagingengine.com>	<46EE5284.9070202@gmail.com>	<1190025593.12774.1211014755@webmail.messagingengine.com>
	<20070917142650.f7b862e4.krzysztof.h1@gmail.com>
	<46EE75D3.1010701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 31C33103867
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Sep 2007 15:58:12 +0200 (CEST)
In-Reply-To: <46EE75D3.1010701@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 09/17/2007 02:40 PM, Rene Herman wrote:

To possibly save you the trouble, yes, tested that the OPL3 address really 
follows along with the OPL4Base PnP resource.

Fixed description and CCed Takashi:

> On 09/17/2007 02:26 PM, Krzysztof Helt wrote:
> 
>> Look at the code. Shifting the fm_port address by 8 (Rene's) is correct
>> way to do as the OPL3 is searched at fm_port and fm_port +2, but the OPL4
>> is searched at fm_port and fm_port -8 (which will be the fm_port before
>> shifting).
> 
> Ah, damn, crap. Yes, forget the version I just sent. Original (attached) 
> was correct. Thanks for paying attention.
> 
>> Is the OPL4 located at 0x380 and 0x388 or 0x378 and 0x380? If the former,
>> the Rene's patch is correct.
> 
> The OPL4 is at 0x380, with its OPL3 compatible part at 0x388. Could you 
> add an Acked-by?

===
opti9xx: adjust OPL3 FM resource value

The OPTi ISA-PnP chips advertise their OPL4Base resource value at 0x380
(to 0x3f0) through PnP and put their on-chip OPL3 at ALBase = OPL4Base + 8.
The driver assumes the PnP advertised value is the ALBase though and checks
for an OPL4 at -8, which means that simply adding 8 to the PnP advertised
value works to fix both OPL3 and OPL4 support.

Problem spotted on 931 and 933 by Krzysztof Helt and confirmed on 924 and
925 (together all OPTi ISA-PnP chips) by me. Has been tested.

Signed-off-by; Rene Herman <rene.herman@gmail.com>
===

Rene.
