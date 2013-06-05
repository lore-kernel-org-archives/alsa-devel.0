From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [tinycompress]how should I call compress_open	for
	aac ltp file playback?
Date: Wed, 5 Jun 2013 09:01:04 +0100
Message-ID: <20130605080104.GE31108@opensource.wolfsonmicro.com>
References: <51AEDEAC.2020705@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ABAB926109C
 for <alsa-devel@alsa-project.org>; Wed,  5 Jun 2013 10:09:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <51AEDEAC.2020705@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Keyon.Jey" <yang.jie@linux.intel.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 05, 2013 at 02:46:04PM +0800, Keyon.Jey wrote:
> I am trying to use tinycompress for hwdecoder. everything works fine,  
> but after compress_open (with profile = SND_AUDIOPROFILE_AAC level=0  
> ch_mode=0 rate_control=0), the playback of my aac-ltp-16bit-48KHz-Stereo  
> file is faster than it should be.  Am I wrong?

Vinod is probably the person for this one, as I am not so
familiar with what you guys have done internally. However, my
guess would be you are not setting the sample_rate correctly? It
likely needs to be set to the appropriate SNDRV_PCM_RATE_XXXX
define. The source for cplay included in the tinycompress
repository is a good example of using the tinycompress library.

Charles
