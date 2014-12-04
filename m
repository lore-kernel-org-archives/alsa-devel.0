From: Andrew Jackson <Andrew.Jackson@arm.com>
Subject: Re: [PATCH 2/5] ASoC: dwc: Don't allow negative use
	counts
Date: Thu, 04 Dec 2014 09:00:35 +0000
Message-ID: <548022B3.8050105@arm.com>
References: <547F3C9F.8080102@arm.com> <20141203172526.GC7712@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com
 [217.140.96.140])
 by alsa0.perex.cz (Postfix) with ESMTP id 62B862605E1
 for <alsa-devel@alsa-project.org>; Thu,  4 Dec 2014 10:00:36 +0100 (CET)
In-Reply-To: <20141203172526.GC7712@sirena.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Liviu Dudau <Liviu.Dudau@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rajeev Kumar <rajeevkumar.linux@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On 12/03/14 17:25, Mark Brown wrote:
> On Wed, Dec 03, 2014 at 04:38:55PM +0000, Andrew Jackson wrote:
> 
>>  	case SNDRV_PCM_TRIGGER_STOP:
>>  	case SNDRV_PCM_TRIGGER_SUSPEND:
>>  	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>> -		dev->active--;
>> +		if (dev->active > 0)
>> +			dev->active--;
> 
> How is this triggering - this sounds like you're papering over some
> other bug somewhere?
> 

When I looked at the code paths I couldn't convince myself that STOP wouldn't be called more than once.  Then actuve would be negative and the device might not be restartable.  I didn't have a problem per se, it was just that it seemed to be something of a loophole.

   Andrew
