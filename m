From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Variable Delay through ALSA driver
Date: Wed, 18 Sep 2013 22:16:12 -0500
Message-ID: <523A6C7C.3010608@linux.intel.com>
References: <B02206F4ACA2904A8270028316B8DAFF01149AB8@mercury.corp.adaptivedigital.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id CA638261728
 for <alsa-devel@alsa-project.org>; Thu, 19 Sep 2013 05:16:15 +0200 (CEST)
In-Reply-To: <B02206F4ACA2904A8270028316B8DAFF01149AB8@mercury.corp.adaptivedigital.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brandon Yates <Brandon.Yates@adaptivedigital.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 9/17/13 3:07 PM, Brandon Yates wrote:
> I have an application using the ALSA API that writes to playback device
> and simultaneously reads from capture device.  My processing loop is :
>
> 1)Read from microphone (blocking)
> 2)Process Data
> 3)Write to speaker
>
> I am measuring the delay from the time I play a series of frames to the
> speaker until I detect the echo of this coming back in through the
> microphone.  This delay seems to be changing every time I initialize the
> devices with ALSA. I have measured in the range of 60-160ms delay.  I
> know things like period size effect delay, but using the exact same
> software and hardware configuration I would expect this to be constant
> across runs.  What are some parameters that can help me make the delay
> deterministic?

snd_pcm_link can help make sure your playback and capture devices start 
at the same time, if supported in hardware (HDAudio works well). 
Otherwise you need a cross-correlation to find out the delay and 
compensate for it in software.
-Pierre
