From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [PATCH 1/2] ca0106 playback 44100Hz support	to
 SPDIF and	playback	format & rate constraints
Date: Wed, 03 Sep 2008 19:36:51 +0100
Message-ID: <48BED943.1080504@superbug.co.uk>
References: <1219415921.32652.254.camel@localhost>
	<s5h63ptf48b.wl%tiwai@suse.de>
	<1219502224.15980.32.camel@localhost>
	<s5h7ia5dpe0.wl%tiwai@suse.de> <1220375467.7459.8.camel@localhost>
	<48BDAD8B.8060007@superbug.co.uk>
	<Pine.LNX.4.58.0809030912020.24305@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-33.mail.demon.net (anchor-post-33.mail.demon.net
	[194.217.242.91])
	by alsa0.perex.cz (Postfix) with ESMTP id 0E28F103826
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Sep 2008 20:36:56 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.58.0809030912020.24305@shell4.speakeasy.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Trent Piepho <xyzzy@speakeasy.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Ben Stanley <Ben.Stanley@exemail.com.au>
List-Id: alsa-devel@alsa-project.org

Trent Piepho wrote:
> On Tue, 2 Sep 2008, James Courtier-Dutton wrote:
>> Ben Stanley wrote:
>>> +		/* We only support 44100 to spdif, not to DAC.
>>> +		   (FIXME WHY?)*/
>> WHY?  Because the DAC cannot be clocked at 44100, only 48000 and 96000
>> from the CA0106 chip.
>> The SPDIF can be clocked at 44100.
>> It is a hardware limitation.
> 
> The DAC supports 44100.  Is the problem that the ca0106 can't provide a
> 44100 clock to the DAC?
It does not really matter why, it does not work at 44100 and that is fact.
