From: "Cai, Cliff" <Cliff.Cai@analog.com>
Subject: Re: [PATCH 1/5] ASoC: Blackfin: fix bug - kernel
	willcrash when record and play in bf527-ezkit
Date: Mon, 9 Mar 2009 18:58:19 +0800
Message-ID: <0F1B54C89D5F954D8535DB252AF412FA03AB85F5@chinexm1.ad.analog.com>
References: <1236326010-683-1-git-send-email-cooloney@kernel.org>
	<1236326010-683-2-git-send-email-cooloney@kernel.org>
	<20090306120145.GF6493@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail11.analog.com (nwd2mail11.analog.com [137.71.25.57])
	by alsa0.perex.cz (Postfix) with ESMTP id B2D421037F3
	for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2009 11:55:17 +0100 (CET)
Content-class: urn:content-classes:message
In-Reply-To: <20090306120145.GF6493@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>, Bryan Wu <cooloney@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

 
This patch should be named : change the configuring way for sport,
Because I found that the previous way is not reliable sometimes.
Application like "tone" ,will call starup() twice before entering
hw_params() to configure SPORT.  
in this case SPORT won't be configured at all.

Cliff

>-----Original Message-----
>From: Mark Brown [mailto:broonie@sirena.org.uk] 
>Sent: Friday, March 06, 2009 8:02 PM
>To: Bryan Wu
>Cc: Cliff Cai; alsa-devel@alsa-project.org; 
>linux-kernel@vger.kernel.org
>Subject: Re: [alsa-devel] [PATCH 1/5] ASoC: Blackfin: fix bug 
>- kernel willcrash when record and play in bf527-ezkit
>
>On Fri, Mar 06, 2009 at 03:53:26PM +0800, Bryan Wu wrote:
>> From: Cliff Cai <cliff.cai@analog.com>
>> 
>> set constraint only if the value is not 0, change the 
>configuring way 
>> for sport
>
>Hrm.  As far as I can tell the actual effect of this patch is 
>to not do any of the per-format configuration for the sport if 
>the sport has been configured once already - as far as I can 
>tell nothing ever resets your 'configured' variable and this 
>is the only place that the data format is taken into account.  
>Won't this mean that if a second data format is played the 
>audio will be mishandled since the hardware will not have been 
>configured for the new audio format?
>
>If it's really not possible to reconfigure the hardware (I'm 
>assuming that this is what the actual crash is?) I would 
>expect to see code added which remembers the format that has 
>been configured and then adds a constraint in the startup() 
>function enforcing that.
>
