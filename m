From: Krzysztof Helt <krzysztof.h1@gmail.com>
Subject: Re: [PATCH] opti931: additional check for OPL3 device
Date: Mon, 17 Sep 2007 16:45:55 +0200
Message-ID: <20070917164555.fddbfa27.krzysztof.h1@gmail.com>
References: <8c74410a0709140735j3903a11dp23f783d45bffc55c@mail.gmail.com>
	<1189781567.3648.1210664373@webmail.messagingengine.com>
	<20070914184705.9ba48d80.krzysztof.h1@gmail.com>
	<1190016893.19336.1210994773@webmail.messagingengine.com>
	<46EE5284.9070202@gmail.com>
	<1190025593.12774.1211014755@webmail.messagingengine.com>
	<20070917142650.f7b862e4.krzysztof.h1@gmail.com>
	<46EE75D3.1010701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.186])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B7E4103871
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Sep 2007 16:38:36 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id b21so1019178nfd
	for <alsa-devel@alsa-project.org>; Mon, 17 Sep 2007 07:38:35 -0700 (PDT)
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
To: Rene Herman <rene.herman@gmail.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 17 Sep 2007 14:40:51 +0200
Rene Herman <rene.herman@gmail.com> wrote:

> The OPL4 is at 0x380, with its OPL3 compatible part at 0x388. Could you add 
> an Acked-by?
> 
You are inpatient. I have tested it on my opti933.

> ===
> opti9xx: adjust OPL3 FM resource value
> 
> The OPTi ISA-PnP chips advertise their OPL4 base at 0x380 (to 0x3f0) through 
>   pnp and put their on-chip OPL3 at +8. The driver assumes the provided 
> value is the ALBase (OPL3 address) though and checks for an OPL4 at -8, 
> which means that simply adding 8 to the pnp provides value works to fix 
> detection of both OPL3 and OPL4.
> 
> Problem spotted on 931 and 933 by Krzysztof Helt and confirmed on 924 and 
> 925 (together all OPTi ISA-PnP chips) by me.
> 
> Signed-off-by; Rene Herman <rene.herman@gmail.com>

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>
