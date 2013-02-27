From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: ASoC: no-pcm (backend) error propagation
Date: Wed, 27 Feb 2013 16:23:53 +0800
Message-ID: <1361953433.28121.33.camel@vega>
References: <190351B32828744FBA3BD9565204D27B01CA3AF2@NA-MBX-03.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 7744A2617AF
 for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2013 09:24:01 +0100 (CET)
In-Reply-To: <190351B32828744FBA3BD9565204D27B01CA3AF2@NA-MBX-03.mgc.mentorg.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Frkuska, Joshua" <Joshua_Frkuska@mentor.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2013-02-27 at 02:21 +0000, Frkuska, Joshua wrote:
> Hello,
> 
> I am working off of the 3.5.7 branch of the kernel using a frontend-backend approach for my driver. No additional patches have been added for ASoC/ALSA from the 3.5.7 kernel branch.
> 
> My question relates to the way the no-pcm (backend) propagates errors to the front end. My FE(frontend) consists of a cpu-dai, a pcm platform driver, and a dummy-codec. My BE(backend) consists of another cpu-dai, a non-pcm platform driver, and a real codec.
> The non-pcm operates with the dmaengine but just in an autonomous fashion external to the PCM's knowledge.
> 
> I have the pcm-platform driver passing data to the FE cpu-dai and the backend platform then takes the data from the frontend's cpu-dai and passes it on to the BE cpu-dai, which then configures the codec-dai to get output.
> 
> In the frontend if/whenever there is an underrun error in the cpu-dai, I can directly call snd_pcm_stop to stop the stream and report the error state. I can do this because the substream->ops have properly been defined in the frontend pcm. However, in the backend, the substream->ops never get initialized and rightfully so since there isn't a valid pcm for the backend.
> 
> My question is, what is the correct/any way to let the frontend PCM stream know that an underrun has occurred in the backend? Is there a mechanism to handle this in ASoC? Looking through the code, I cannot find such a mechanism. I have a feeling that there should be something like snd_soc_pcm_stop to check to see if we are in a FE/BE configuration and act accordingly to stop the FE PCM stream and report errors.
> 

It was originally intended that any underrun / overrun issues in a BE
DAI would be handled internally by the audio DSP (and this worked well
with the OMAP4 ABE). However, it is probably a good a idea to have a
better mechanism for reporting BE xrun issues up the stack to the host
CPU side too. 

Currently the FE PCM xrun mechanism and FE pointer() callback could be
used by the host to get the size of any FE:BE underrun/overrun. This
isn't ideal and wont work when there can be multiple BEs for a FE. 

It looks like some new code is required here to get this working
correctly for BEs. 

Regards

Liam
