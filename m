From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: 2.6.26-rc1 regression: ISA DMA broken (bisected)
Date: Sat, 10 May 2008 01:00:44 +0200
Message-ID: <4824D79C.7060303@keyaccess.nl>
References: <4823AAF2.7070102@keyaccess.nl> <s5hzlr0105c.wl%tiwai@suse.de>
	<48243D86.7020504@keyaccess.nl> <20080509122828.GB10855@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id BF8FA243A3
	for <alsa-devel@alsa-project.org>;
	Sat, 10 May 2008 00:59:43 +0200 (CEST)
In-Reply-To: <20080509122828.GB10855@elte.hu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ingo Molnar <mingo@elte.hu>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>, Glauber Costa <gcosta@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Pete Clements <clem@clem.clem-digital.net>
List-Id: alsa-devel@alsa-project.org

On 09-05-08 14:28, Ingo Molnar wrote:
> * Rene Herman <rene.herman@keyaccess.nl> wrote:
> 
>> On 09-05-08 08:06, Takashi Iwai wrote:
>>
>>> Thanks for catching it.  Yeah, the patch looks buggy.  We had an
>>> implicit assumption that dev = NULL for ISA devices that require 24bit
>>> DMA.
>>>
>>> How about the patch below?  It's against the latest Linus git tree.
>> Yes, works well. Thank you.
> 
> great, thanks Rene for catching this! Added this line to the patch as 
> well:
> 
>  Tested-by: Rene Herman <rene.herman@keyaccess.nl>

Oh... it was rather significantly in the AM when I posted so I forgot to
mention in the haste to get this out of the way but it was Pete Clements
who reported the regression:

http://www.nabble.com/Lost-Sound-from-2.6.24-to-2.6.25----CS4236-ISA-tc17062547.html

He also tested it, so as long as we're name-mention-flattering around...

And this a good excuse to ask how you edit changelog after the fact. Just
reset/reapply and stuff or is there a "better" way? I fairly frequently
find myself wanting to do just that but it's a bit of a mess when there's
already commits on top.

Rene.
