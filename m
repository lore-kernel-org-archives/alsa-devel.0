From: "Keyon.Jey" <yang.jie@linux.intel.com>
Subject: Re: [tinycompress]how should I call compress_open	for
 aac ltp file playback?
Date: Wed, 05 Jun 2013 16:27:44 +0800
Message-ID: <51AEF680.10209@linux.intel.com>
References: <51AEDEAC.2020705@linux.intel.com>
 <20130605080104.GE31108@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 174472610B9
 for <alsa-devel@alsa-project.org>; Wed,  5 Jun 2013 10:26:22 +0200 (CEST)
In-Reply-To: <20130605080104.GE31108@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 06/05/2013 04:01 PM, Charles Keepax wrote:
> On Wed, Jun 05, 2013 at 02:46:04PM +0800, Keyon.Jey wrote:
>> I am trying to use tinycompress for hwdecoder. everything works fine,
>> but after compress_open (with profile = SND_AUDIOPROFILE_AAC level=0
>> ch_mode=0 rate_control=0), the playback of my aac-ltp-16bit-48KHz-Stereo
>> file is faster than it should be.  Am I wrong?
> Vinod is probably the person for this one, as I am not so
> familiar with what you guys have done internally. However, my
> guess would be you are not setting the sample_rate correctly? It
> likely needs to be set to the appropriate SNDRV_PCM_RATE_XXXX
> define. The source for cplay included in the tinycompress
> repository is a good example of using the tinycompress library.
>
> Charles
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
thanks, Charles. the print log showed me that I have set 
SNDRV_PCM_RATE_48000 which seems no problem.
the cplay example code is only for mp3 file, and it also not set .level, 
.ch_mode and .rate_control.
Vinod, what's your suggestion?

thanks,
Keyon
