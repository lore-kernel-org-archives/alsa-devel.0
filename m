From: Omair Mohammed Abdullah <omair.m.abdullah@linux.intel.com>
Subject: Re: Question: PCM short and long sync formats
Date: Mon, 26 Mar 2012 18:59:43 +0530
Message-ID: <4F706F47.2090306@linux.intel.com>
References: <4F69ABB0.2000706@linux.intel.com>
	<20120321115146.GC3226@opensource.wolfsonmicro.com>
	<4F7031AD.3090202@linux.intel.com>
	<20120326102650.GC3098@opensource.wolfsonmicro.com>
	<4F705BF3.5080905@linux.intel.com>
	<20120326120853.GP3098@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E624249C1
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Mar 2012 15:27:25 +0200 (CEST)
In-Reply-To: <20120326120853.GP3098@opensource.wolfsonmicro.com>
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

On Monday 26 March 2012 05:38 PM, Mark Brown wrote:
> On Mon, Mar 26, 2012 at 05:37:15PM +0530, Omair Mohammed Abdullah wrote:
>> On Monday 26 March 2012 03:56 PM, Mark Brown wrote:
>
>>> I'm sorry but I still have no idea what you're talking about.  You've
>>> described PCM mode but not explained what "short frame sync" and "long
>>> frame sync" mode are.
>
>> This diagram may explain things better:
>> http://picpaste.com/pcm_fs-7dBlrkuW.png
>
> Sorry, that's not really clarifying things.  It looks like "long frame
> sync" is just I2S but presumably there's some difference?

Yes, in I2S mode, according to the spec I have, the frame sync leads the 
MSB of the data by 1 bit clock cycle. Whereas the 'long frame sync' mode 
starts with the MSB of the data.
