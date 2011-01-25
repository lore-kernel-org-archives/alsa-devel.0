From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Subject: Re: [PATCH] alsa: fix invalid hardware.h include in
 ac97c for AVR32 architecture
Date: Tue, 25 Jan 2011 19:31:22 +0100
Message-ID: <20110125183122.GA10090@ssg-0.norway.atmel.com>
References: <1295881796-27625-1-git-send-email-hcegtvedt@atmel.com>
	<s5hwrls3o76.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.atmel.no (relay.atmel.no [194.19.124.36])
	by alsa0.perex.cz (Postfix) with ESMTP id 8BFE4103979
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2011 19:31:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hwrls3o76.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, kernel@avr32linux.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Around Tue 25 Jan 2011 18:09:17 +0100 or thereabout, Takashi Iwai wrote:
> At Mon, 24 Jan 2011 16:09:56 +0100,
> Hans-Christian Egtvedt wrote:
>> 
>> From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
>> 
>> This patch fixes the non-compiling AC97C driver for AVR32 architecture by
>> include mach/hardware.h only for AT91 architecture. The AVR32 architecture does
>> not supply the hardware.h include file.
>> 
>> Signed-off-by: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
>> CC: stable@vger.kernel.org
> 
> Applied now.  Thanks.

Thanks, I see you lined it up on your master branch, do you plan pushing it
for the 2.6.38 release?

<snipp>

-- 
Best regards, HC
