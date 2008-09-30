From: Frank Mandarino <fmandarino@endrelia.com>
Subject: Re: [PATCH] ASoC: Remove references to Endrelia ETI-B1
 board
Date: Tue, 30 Sep 2008 11:12:02 -0400
Message-ID: <48E241C2.2070906@endrelia.com>
References: <48E23AE0.3040805@endrelia.com> <s5hy719fzt6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ironport2-out.teksavvy.com (ironport2-out.pppoe.ca
	[206.248.154.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 098962453A
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Sep 2008 17:12:03 +0200 (CEST)
In-Reply-To: <s5hy719fzt6.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Sedji Gaouaou <sedji.gaouaou@atmel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org


Takashi Iwai wrote:
> At Tue, 30 Sep 2008 10:42:40 -0400,
> Frank Mandarino wrote:
>> The ASoC machine drivers for this board were only provided as examples
>> for the new AT91 ASoC platform driver.  Since the ETI-B1 board is
>> proprietary and there are other AT91 ASoC machine drivers available,
>> it makes sense to remove these drivers.
>>
>> Signed-off-by: Frank Mandarino <fmandarino@endrelia.com>
>> ---
>>  sound/soc/at91/Kconfig           |   27 ---
>>  sound/soc/at91/Makefile          |    7 -
>>  sound/soc/at91/eti_b1_bluecore.c |  284 -------------------------------
>>  sound/soc/at91/eti_b1_wm8731.c   |  350 --------------------------------------
> 
> Note that eti_b1_bluecore isn't in the current ALSA tree.
> 
> 
> thanks,
> 
> Takashi

Yes, I realize this.  I created the patch against the dev branch of the
ASoC git repository, where eti_b1_bluecore does exist.

Mark: is this a problem?  Should I create a patch against the ASoC
"master" branch?

../fam
-- 
Frank Mandarino					fmandarino@endrelia.com
Endrelia Technologies Inc.
Toronto, Ontario, Canada
416.208.6986 x4522
