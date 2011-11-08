From: Daniel Mack <zonque@gmail.com>
Subject: Re: Swapped channels issue on pxa-ssp based platforms
Date: Tue, 08 Nov 2011 13:38:59 +0100
Message-ID: <4EB922E3.3040109@gmail.com>
References: <4EB817FC.4000905@gmail.com> <4EB83D3B.2050906@ladisch.de>
	<20111108113930.GI25591@opensource.wolfsonmicro.com>
	<4EB916A0.6090602@gmail.com>
	<20111108122702.GK25591@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 41925243B3
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2011 13:39:04 +0100 (CET)
Received: by bkat8 with SMTP id t8so328158bka.38
	for <alsa-devel@alsa-project.org>; Tue, 08 Nov 2011 04:39:04 -0800 (PST)
In-Reply-To: <20111108122702.GK25591@opensource.wolfsonmicro.com>
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
Cc: Sven Neumann <s.neumann@raumfeld.com>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Liam Girdwood <lrg@ti.com>, Haojian Zhuang <haojian.zhuang@marvell.com>
List-Id: alsa-devel@alsa-project.org

On 11/08/2011 01:27 PM, Mark Brown wrote:
> On Tue, Nov 08, 2011 at 12:46:40PM +0100, Daniel Mack wrote:
>
>> all over the place. I'm just curious whether there there is anything
>> in the ASoC core that cares for this?
>
> There's a big fat mutex around each PCM.

That explains why it didn't hit us earlier. Thanks :)
