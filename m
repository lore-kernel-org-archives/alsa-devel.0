From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH TINYCOMPRESS 1/14] compress: Add
	function	to get timestamp in samples
Date: Tue, 19 Feb 2013 17:18:29 +0000
Message-ID: <20130219171829.GA32279@opensource.wolfsonmicro.com>
References: <20130210000227.GA31139@opensource.wolfsonmicro.com>
 <20130211063448.GA3789@intel.com> <5118FBF8.9060804@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4EC86265234
 for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2013 18:18:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <5118FBF8.9060804@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>>> The compress_get_hpointer() converts the timestamp into actual
>>> time. But Android needs it in samples. To avoid the inefficiency
>>> of using compress_get_hpointer() and converting into time and then
>>> back into samples, this change adds compress_get_tstamp() which
>>> returns the raw struct snd_compr_tstamp.
>
>the conversion could be handled in tinycompress (user-space) 
>rather than adding a new kernel ioctl that everyone will need to implement.

This isn't adding a new ioctl. It's adding a tinycompress function to give
the client a way of calling the existing SNDRV_COMPRESS_TSTAMP ioctl, which
gets the position in samples.

>Loss of efficiency? It's not that bad really
It's silly to get something in the required format, convert it to the
wrong format, then convert it back again, when it's trivial to just
return it in the correct format. And all unnecessary code wastes a little
battery power - if you call it often the waste starts to become measurable.

It's worse if the divide is done in software. Not all ARM processors have
hardware divide so the three divides in compress_get_hpointer are not
necessarily trivial (especially if you're building a low-power embedded
device using a simpler ARM instead of the latest high-end ARM.)

Divide is the most difficult math operation to do in hardware, so any
good programmer that cares about efficiency/speed/power consumption on
embedded platforms should be suspicious of code that needs a divide.
