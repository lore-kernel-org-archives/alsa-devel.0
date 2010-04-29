From: Yu Hang <hangy@fortemedia.com.cn>
Subject: Re: How to retrieve the final data being played by HW
Date: Thu, 29 Apr 2010 17:46:26 +0800
Message-ID: <4BD95572.9020504@fortemedia.com.cn>
References: <4BD94E3A.2040301@fortemedia.com.cn>
	<20100429091957.GB21607@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mxvip36.hichina.com (mxvip36.hichina.com [218.106.248.86])
	by alsa0.perex.cz (Postfix) with ESMTP id 4071024451
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Apr 2010 11:46:26 +0200 (CEST)
In-Reply-To: <20100429091957.GB21607@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 4/29/2010 5:19 PM, Mark Brown wrote:
> On Thu, Apr 29, 2010 at 05:15:38PM +0800, Yu Hang wrote:
>
>    
>> For example, the 1st instance had mixes the data into destination
>> buffer, but 2nd instance haven't complete the mix operation. Would the
>> data in destination buffer be playing by HW?
>> Or there is some mechanism to guarantee the data will be played after
>> all mix operation is done.
>>      
> You need to ensure that the user configures the plugin stack
> appropriately to ensure that your plugin is the last one that's run, you
> can't do this purely from within your plugin.  Even if that's done you'd
> also need to rely on them not configuring any DSP in the hardware which
> would disrupt things.
>
>    
 From the pcm_dmix.c, dmix plugin must be followed by HW plugin. Which 
means I cannot insert my own plugin below dmix. Unless I patch 
pcm_dmix.c, I cannot retrieve the final data. Or I can patch pcm_hw.c in 
order to achieve my goal.
Even if I patch pcm_hw.c, how can I know when the data is actually sent 
to HW?
I have totally no idea about ALSA driver mechanism. A biggest question 
is, how alsa lib (in user space) knows the HW needs new data (it must 
happen by interrupt) and feed HW with new data.
