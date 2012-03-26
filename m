From: Omair Mohammed Abdullah <omair.m.abdullah@linux.intel.com>
Subject: Re: Question: PCM short and long sync formats
Date: Mon, 26 Mar 2012 14:36:53 +0530
Message-ID: <4F7031AD.3090202@linux.intel.com>
References: <4F69ABB0.2000706@linux.intel.com>
	<20120321115146.GC3226@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id D02E2103D57
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Mar 2012 11:04:33 +0200 (CEST)
In-Reply-To: <20120321115146.GC3226@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wednesday 21 March 2012 05:21 PM, Mark Brown wrote:
> On Wed, Mar 21, 2012 at 03:51:36PM +0530, Omair Mohammed Abdullah wrote:
>
>> I was looking for PCM short frame sync and PCM long frame sync, but
>> they are not present in soc-dai.h (FORMAT_MASK). Is there a way to
>> derive them from other formats or should I just add them?
>
> What do you mean when you say "PCM short frame sync" and "PCM long
> frame sync"?

Sorry for the late reply, I was away.

What I mean by short/long frame sync is: the frame sync lasts for 1 
bit/1 word wide.

Eg.: For short frame sync, we get a frame sync signal for 1 clock before 
the first bit on the RX/TX.

It is different from I2S mode where the frame sync is inverted and the 
transition starts 1 clock before the bits and lasts till bit 1.
