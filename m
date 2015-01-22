From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: alsa-lib support for compress offload
Date: Thu, 22 Jan 2015 16:03:16 -0600
Message-ID: <54C173A4.4060706@linux.intel.com>
References: <54B8DF7A.6000700@imgtec.com> <s5hbnlzt3o2.wl-tiwai@suse.de>
 <54B8F485.7090603@imgtec.com> <54B9413F.805@linux.intel.com>
 <54BD3D7F.6020105@imgtec.com> <54BD8036.5070405@linux.intel.com>
 <54BE25B7.1040606@imgtec.com> <20150121071053.GC28763@intel.com>
 <s5h1tmoz6mi.wl-tiwai@suse.de> <20150122215645.GF28763@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 69B512652E3
 for <alsa-devel@alsa-project.org>; Thu, 22 Jan 2015 23:03:20 +0100 (CET)
In-Reply-To: <20150122215645.GF28763@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Qais Yousef <qais.yousef@imgtec.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.jf.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 1/22/15 3:56 PM, Vinod Koul wrote:
> Can we actually support compress with current alsa APIs? If yes then we can
> do rework and keep current tinycompress APIs for Andporid and let core lib
> be reused, if not then we can go with these new APIs

No. We need to be able to pass decoder/encoder parameters, and we need 
the ability to deal with bytes, without any fixed mapping between bytes 
and time. If we want any convergence we'd need ALSA to deal with bytes 
only and not frames, in addition to the extra configuration steps, which 
would be a complete API change.
-Pierre
