From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: Hardware audio decoder driver design
Date: Thu, 28 Jul 2011 21:26:59 +0530
Message-ID: <438BB0150E931F4B9CE701519A4463010871F17CDA@bgsmsx502.gar.corp.intel.com>
References: <201107281910.10535@zigzag.lvk.cs.msu.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id A30B4244E6
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Jul 2011 17:57:08 +0200 (CEST)
In-Reply-To: <201107281910.10535@zigzag.lvk.cs.msu.su>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Nikita V. Youshchenko" <yoush@cs.msu.su>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Nikita V. Youshchenko wrote: 
> Hello.
> 
> Soon I will work on a linux kernel driver for a custom audio decoder device
> that is being developed by a company I work for. If not going into
> details, that devices reads A52-encoded stream from system memory, and
> writes raw pcm stream to system memory.
> 
> Simplest thing to do is - implement a character device, where user-space
> will write encoded stream, and from where user-space will read decoded
> stream.
> (driver for similar hardware, located at
> http://sourceforge.net/projects/vs10xx/, does that).
> 
> However, perhaps a better architecture (e.g. in-kernel intergation with an
> audio sink) is possible?
> 
> I'm looking for any related information - e.g. ideas on what interface to
> implement, examples of drivers for similar devices, etc.
We have implemented a similar scheme for our devices, please see 
staging/intel_sst/. We are currently adding alsa API for compressed path 
streaming which will also involve API for decoding compressed data and sending 
back to system memory

HTH
~Vinod
