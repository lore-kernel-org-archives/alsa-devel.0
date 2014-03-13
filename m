From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: tlv320aic32x4 Codec ADC and DAC must shutdown to
 alter clocks
Date: Thu, 13 Mar 2014 08:09:25 +0100
Message-ID: <532159A5.20200@topic.nl>
References: <53207878.2060107@topic.nl> <20140312233137.GB28112@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp06.online.nl (smtp06.online.nl [194.134.42.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 46D3326512B
 for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2014 08:09:26 +0100 (CET)
In-Reply-To: <20140312233137.GB28112@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 03/13/2014 12:31 AM, Mark Brown wrote:
> On Wed, Mar 12, 2014 at 04:08:40PM +0100, Mike Looijmans wrote:
>
>> What I cannot fix is that changing the parameters (like clock
>> frequency) must stop the DAC core.
>
>> The DAPM framework just sets the BIAS to "ON" only once, and does
>> not shut down until after a time out. Which is good.
>> But if the next stream to play needs a different clock setting, the
>> DAC must be stopped first, the code must wait until the DAC has
>> powered down, and then the clocks can be stopped and altered. When
>> all settings are done, the DAC can be restarted.
>
> As a first order fix the driver should just refuse to reconfigure if the
> clocks are active.

Which would result in the driver often failing to work and the user 
having no clue why.

>> I can detect the change in the hw_params, and on the first stream to
>> play, this is called while still in STANDBY or lower levels.
>> However, when the codec is already in ON bias level, how do I tell
>> DAPM that I had to shut down the DAC in order to change the
>> parameters? Just toggling the related bits will keep the DAC powered
>> down. A routine to store and restore the power state is possible,
>> but very ineffective. Especially since the "I must shutdown"
>> conclusion can also be in the clock setting routine. That would
>> result in multiple down-up cycles.
>
> The big problem with shutting down is disruption to other activity - if
> there's something going on using the clocks.  For some devices that
> don't have long startup times ignore_pmdow_time may help a lot.

The bias level can remain where it is, it's just the DACSETUP or 
ADCSETUP bits that need toggling. They're independent, so only the 
affected parts need to stop. Using ignore_pmdow_time would result in the 
codec going to a lower bias state, and that is not what should happen 
here. Restarting the ADC or DAC is just a matter of milliseconds, but a 
complete power-down will result in reference voltage instability and 
capacitors recharging, and it may take several minutes for the system to 
completely recover from that.

I'm mostly asking to think about the "big picture" here. As a generic 
case, not specific to this codec.

-- 
Mike Looijmans
