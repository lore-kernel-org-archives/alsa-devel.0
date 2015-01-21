From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: alsa-lib support for compress offload
Date: Wed, 21 Jan 2015 09:01:13 -0600
Message-ID: <54BFBF39.9010408@linux.intel.com>
References: <54B8DF7A.6000700@imgtec.com> <s5hbnlzt3o2.wl-tiwai@suse.de>
 <54B8F485.7090603@imgtec.com> <54B9413F.805@linux.intel.com>
 <54BD3D7F.6020105@imgtec.com> <54BD8036.5070405@linux.intel.com>
 <54BE25B7.1040606@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id EB78E2605C8
 for <alsa-devel@alsa-project.org>; Wed, 21 Jan 2015 16:01:36 +0100 (CET)
In-Reply-To: <54BE25B7.1040606@imgtec.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Qais Yousef <qais.yousef@imgtec.com>, Takashi Iwai <tiwai@suse.de>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org


> Long story short, I am writing a new ALSA driver that supports compress
> offload. The only user land support I could find is in tinycompress. I
> was looking at adding gstreamer support to facilitate my testing and
> hopefully make the driver more useful.

The problem when you use a gstreamer->tinycompress path is that you have 
no hooks for volume control and audio policy/routing. It'll remain a 
test toy. If you want integration with a better user-friendly support, 
the right answer is to go through PulseAudio and write a compressed sink 
within pulseaudio. See the LPC slides from 2010 or 2011 that describe 
the solution. And Arun can help you with that, he wrote the 
gstreamer/pulseaudio interface :-)
