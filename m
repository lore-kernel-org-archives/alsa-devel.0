From: "Cai, Cliff" <Cliff.Cai@analog.com>
Subject: Re: [PATCH 1/5] ASoC: Blackfin: fix bug -
	kernelwillcrash when record and play in bf527-ezkit
Date: Tue, 10 Mar 2009 17:45:44 +0800
Message-ID: <0F1B54C89D5F954D8535DB252AF412FA03AF7CAA@chinexm1.ad.analog.com>
References: <1236326010-683-1-git-send-email-cooloney@kernel.org>
	<1236326010-683-2-git-send-email-cooloney@kernel.org>
	<20090306120145.GF6493@sirena.org.uk>
	<0F1B54C89D5F954D8535DB252AF412FA03AB85F5@chinexm1.ad.analog.com>
	<20090309112127.GB13593@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail11.analog.com (nwd2mail11.analog.com [137.71.25.57])
	by alsa0.perex.cz (Postfix) with ESMTP id D491B2446F
	for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2009 10:42:41 +0100 (CET)
Content-class: urn:content-classes:message
In-Reply-To: <20090309112127.GB13593@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Bryan Wu <cooloney@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

 

>-----Original Message-----
>From: Mark Brown [mailto:broonie@sirena.org.uk] 
>Sent: Monday, March 09, 2009 7:21 PM
>To: Cai, Cliff
>Cc: Bryan Wu; alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org
>Subject: Re: [alsa-devel] [PATCH 1/5] ASoC: Blackfin: fix bug 
>- kernelwillcrash when record and play in bf527-ezkit
>
>On Mon, Mar 09, 2009 at 06:58:19PM +0800, Cai, Cliff wrote:
>
>> This patch should be named : change the configuring way for sport, 
>> Because I found that the previous way is not reliable sometimes.
>> Application like "tone" ,will call starup() twice before entering
>> hw_params() to configure SPORT.  
>> in this case SPORT won't be configured at all.
>
>This doesn't address the concerns I raised with the patch:
>
>> >Won't this mean that if a second data format is played the 
>audio will 
>> >be mishandled since the hardware will not have been configured for 
>> >the new audio format?
>

I think I understand your concerns,I will send a new patch if I'm free.

Thanks

Cliff 
