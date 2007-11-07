From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: Audio quality issues with dmix plugin
Date: Wed, 07 Nov 2007 23:03:04 +0100
Message-ID: <47323618.7090602@keyaccess.nl>
References: <61445c750711060016y1755bd74l87cdc39718b5d226@mail.gmail.com>	
	<473106E7.9050601@keyaccess.nl>
	<61445c750711070049hf2d0f10r1acaccd6b1e2a928@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id A695F24660
	for <alsa-devel@alsa-project.org>; Wed,  7 Nov 2007 23:07:02 +0100 (CET)
In-Reply-To: <61445c750711070049hf2d0f10r1acaccd6b1e2a928@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Pharaoh ." <pharaoh137@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 07-11-07 09:49, Pharaoh . wrote:

> I changed alsa.conf so that dmix does 44.1kHz and tried, without dmix
> 44.1 and 48kHz files sound 'awesome' but with dmix some clicks appear
> at both the rates. Going ahead, I recorded a 8Khz mono sound using my
> driver and played it back without dmix, it plays without any clicks,
> but use dmix and clicks appear. So basically,
> clicks appear at all the sample rates with dmix and without it I could
> play all the sample rate files well since my hw supports hw
> upsampling.

Okay -- I don't even use dmix, so will defer to someone else. If there's 
anything special about your driver/hardware such as non-interleaved PCM 
and/or endianness conversions this is probably the time to say so...

Rene.
