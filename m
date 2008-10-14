From: ext-jukka.hynninen@vaisala.com
Subject: Re: ASoC: Merging at91 and avr32 dirs - test report
Date: Tue, 14 Oct 2008 15:38:22 +0300
Message-ID: <B9D3C48C98930741A166756A50C44A610F17B564@helx1.corp.vaisala.com>
References: <B9D3C48C98930741A166756A50C44A610F17B561@helx1.corp.vaisala.com>
	<20081010185312.GA10766@sirena.org.uk>
	<B9D3C48C98930741A166756A50C44A610F17B562@helx1.corp.vaisala.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw.vaisala.com (mailgw.vaisala.com [192.81.123.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 84030244F4
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Oct 2008 14:38:44 +0200 (CEST)
Received: from helsrv02.vaisala.com (helsrv02.vaisala.com [192.81.123.16])
	by mailgw.vaisala.com (8.13.6/8.13.6) with SMTP id m9ECcPb3008521
	for <alsa-devel@alsa-project.org>; Tue, 14 Oct 2008 15:38:25 +0300
Content-class: urn:content-classes:message
In-Reply-To: <B9D3C48C98930741A166756A50C44A610F17B562@helx1.corp.vaisala.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@sirena.org.uk
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>>> However, there seems to be some problem with PM, occasionally ASoC
is
>>> stuck with Standby mode (looking at dapm_widgets) when I start the
>>> playback. Restarting the player brings the sound back. I'll carry
out
>>> some further investigation and get back to this.
>> How does this compare with the behaviour of the original at32 machine
>> support - did that have similar issues?
> Actually I was previously using at91 support. Nevertheless, didn't
notice 
> such problems. 

This is propably a false alarm, exactly the same happens with at91-ssc.c

The above described behaviour was due to mpg123, which (for some reason)
does 
not wake up system from D3 state. Furthermore, running mpg123 confuses
DAPM
to think the codec is powered up properly, and waiting for delayed
shutdown.
Running aplay within anti-pop timeout will result in no-sound situation.

Using mpg123, the soc_pcm_prepare() never gets called, which makes me
suspect 
that the real problem might lie in mpg123 code. A similar issue has been

reported here in the past, but I couldn't find a solution:

http://thread.gmane.org/gmane.linux.alsa.devel/47908


-Jukka
