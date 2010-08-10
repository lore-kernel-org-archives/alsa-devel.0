From: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Subject: Re: amp power down event (resend with
	the	correct	email)
Date: Tue, 10 Aug 2010 14:09:27 +0200
Message-ID: <4C614177.9090708@gandalf.sssup.it>
References: <4C604381.2080000@gandalf.sssup.it>	<20100810103120.GA4020@sirena.org.uk>	<4C613073.80508@gandalf.sssup.it>
	<20100810115306.GB4020@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sssup.it (ms01.sssup.it [193.205.80.99])
	by alsa0.perex.cz (Postfix) with ESMTP id 09F98245E2
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Aug 2010 14:09:28 +0200 (CEST)
In-Reply-To: <20100810115306.GB4020@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, peter.ujfalusi@nokia.com
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Tue, Aug 10, 2010 at 12:56:51PM +0200, Michael Trimarchi wrote:
>   
>> Mark Brown wrote:
>>     
>
>   
>> I have fixed change to SND_SOC_DAPM_PRE("Front Speaker", amp_event),
>>     
>
> This is not a good fix, you've totally misunderstood what that widget
> does and it won't be sequenced in the expected fashion.  You should use
> a speaker widget for a speaker.
>   
Ok, I will fix

When the amp_event is supposed to be called in the speaker widget? After the
stream is closed?

Michael
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>   
