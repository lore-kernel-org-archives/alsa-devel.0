From: "Keyon.Jey" <yang.jie@linux.intel.com>
Subject: Re: [tinycompress]how should I call compress_open	for
 aac ltp file playback?
Date: Fri, 07 Jun 2013 14:46:08 +0800
Message-ID: <51B181B0.6070001@linux.intel.com>
References: <51AEDEAC.2020705@linux.intel.com>
 <20130605080104.GE31108@opensource.wolfsonmicro.com>
 <51AEF680.10209@linux.intel.com> <20130607002308.GD23045@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 90228261640
 for <alsa-devel@alsa-project.org>; Fri,  7 Jun 2013 08:44:49 +0200 (CEST)
In-Reply-To: <20130607002308.GD23045@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, "Keyon.Jey" <yang.jie@linux.jf.intel.com>
List-Id: alsa-devel@alsa-project.org

On 06/07/2013 08:23 AM, Vinod Koul wrote:
> On Wed, Jun 05, 2013 at 04:27:44PM +0800, Keyon.Jey wrote:
>> On 06/05/2013 04:01 PM, Charles Keepax wrote:
>>> On Wed, Jun 05, 2013 at 02:46:04PM +0800, Keyon.Jey wrote:
>>>> I am trying to use tinycompress for hwdecoder. everything works fine,
>>>> but after compress_open (with profile = SND_AUDIOPROFILE_AAC level=0
>>>> ch_mode=0 rate_control=0), the playback of my aac-ltp-16bit-48KHz-Stereo
>>>> file is faster than it should be.  Am I wrong?
>>> Vinod is probably the person for this one, as I am not so
>>> familiar with what you guys have done internally. However, my
>>> guess would be you are not setting the sample_rate correctly? It
>>> likely needs to be set to the appropriate SNDRV_PCM_RATE_XXXX
>>> define. The source for cplay included in the tinycompress
>>> repository is a good example of using the tinycompress library.
>>>
>> thanks, Charles. the print log showed me that I have set
>> SNDRV_PCM_RATE_48000 which seems no problem.
>> the cplay example code is only for mp3 file, and it also not set
>> .level, .ch_mode and .rate_control.
>> Vinod, what's your suggestion?
> You need to ask your firmware guys, what are they expecting the these fields.
> Some decoder implementations can be different. But i would expect the audio to
> be broken, bad quality if that is the case.
>
> But the speed of playback can be due to different decoder output rate and
> different sampling rate configured. You are telling decoder 48Khz as CPM sample
> rate, is that what decoder is understanding and conversion to decoder values
> correct. Then you should check if the rendering to DAC is at 48KHz or not.
>
> --
> ~Vinod
>
thanks, Vinod, I will check with the firmware guys for these detail fields.

~Keyon
