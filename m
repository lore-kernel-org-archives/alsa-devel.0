From: Omair Mohammed Abdullah <omair.m.abdullah@linux.intel.com>
Subject: Re: Question: PCM short and long sync formats
Date: Mon, 26 Mar 2012 17:37:15 +0530
Message-ID: <4F705BF3.5080905@linux.intel.com>
References: <4F69ABB0.2000706@linux.intel.com>
	<20120321115146.GC3226@opensource.wolfsonmicro.com>
	<4F7031AD.3090202@linux.intel.com>
	<20120326102650.GC3098@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E3822490A
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Mar 2012 14:04:56 +0200 (CEST)
In-Reply-To: <20120326102650.GC3098@opensource.wolfsonmicro.com>
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

On Monday 26 March 2012 03:56 PM, Mark Brown wrote:
> On Mon, Mar 26, 2012 at 02:36:53PM +0530, Omair Mohammed Abdullah wrote:
>> On Wednesday 21 March 2012 05:21 PM, Mark Brown wrote:
>
>>> What do you mean when you say "PCM short frame sync" and "PCM long
>>> frame sync"?
>
>> Sorry for the late reply, I was away.
>
>> What I mean by short/long frame sync is: the frame sync lasts for 1
>> bit/1 word wide.
>
>> Eg.: For short frame sync, we get a frame sync signal for 1 clock
>> before the first bit on the RX/TX.
>
>> It is different from I2S mode where the frame sync is inverted and
>> the transition starts 1 clock before the bits and lasts till bit 1.
>
> I'm sorry but I still have no idea what you're talking about.  You've
> described PCM mode but not explained what "short frame sync" and "long
> frame sync" mode are.

This diagram may explain things better:
http://picpaste.com/pcm_fs-7dBlrkuW.png
