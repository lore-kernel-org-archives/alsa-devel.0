From: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Subject: Re: amp power down event (resend with
	the	correct	email)
Date: Tue, 10 Aug 2010 12:56:51 +0200
Message-ID: <4C613073.80508@gandalf.sssup.it>
References: <4C604381.2080000@gandalf.sssup.it>
	<20100810103120.GA4020@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sssup.it (ms01.sssup.it [193.205.80.99])
	by alsa0.perex.cz (Postfix) with ESMTP id 9154E245A3
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Aug 2010 12:56:53 +0200 (CEST)
In-Reply-To: <20100810103120.GA4020@sirena.org.uk>
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

Hi,

Mark Brown wrote:
> On Mon, Aug 09, 2010 at 08:05:53PM +0200, Michael Trimarchi wrote:
>
>   
>> I'm t rying to unde rstand when the event a re called.
>>     
>
> As I believe I have reminded you on a number of occasions you should
> always CC the maintainers on Linux kernel queries.
>
>   
>> and receive the event => OFF. In the aplay example this happen
>> afte r some seconds but in my application I don't receive the OFF
>> event. What is w rong?
>>     
>
> Your application will have left audio going to the speaker.  This will
> either be a running playback or an analogue path.
>   
I have fixed change to SND_SOC_DAPM_PRE("Front Speaker", amp_event),

so when the stream is closed the amp is deactivated using the event 2

[  400.946232] widget Right DAC
[  400.946237]  Right HiFi Playback stream HiFi Playback event 2
[  400.954813] widget Left DAC
[  400.954819]  Left HiFi Playback stream HiFi Playback event 2
[  400.963617] amp_event: event =>
[  400.966604] OFF

This is ok if the user implements the standby closing the out channel.

Michael Trimarchi


> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>   
