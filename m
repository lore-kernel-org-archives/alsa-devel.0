From: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.26-rc1 regression: ISA DMA broken (bisected)
Date: Fri, 9 May 2008 14:28:28 +0200
Message-ID: <20080509122828.GB10855@elte.hu>
References: <4823AAF2.7070102@keyaccess.nl> <s5hzlr0105c.wl%tiwai@suse.de>
	<48243D86.7020504@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx3.mail.elte.hu (mx3.mail.elte.hu [157.181.1.138])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E66C24457
	for <alsa-devel@alsa-project.org>;
	Fri,  9 May 2008 14:28:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48243D86.7020504@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>, Glauber Costa <gcosta@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Pete Clements <clem@clem.clem-digital.net>
List-Id: alsa-devel@alsa-project.org


* Rene Herman <rene.herman@keyaccess.nl> wrote:

> On 09-05-08 08:06, Takashi Iwai wrote:
>
>> Thanks for catching it.  Yeah, the patch looks buggy.  We had an
>> implicit assumption that dev = NULL for ISA devices that require 24bit
>> DMA.
>>
>> How about the patch below?  It's against the latest Linus git tree.
>
> Yes, works well. Thank you.

great, thanks Rene for catching this! Added this line to the patch as 
well:

 Tested-by: Rene Herman <rene.herman@keyaccess.nl>

	Ingo
