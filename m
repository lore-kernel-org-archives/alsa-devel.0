From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
	cards, especially Aureon 5.1 MkII
Date: Wed, 17 Feb 2010 16:17:24 +0000
Message-ID: <ad2655cb1002170817i6cf90f6bh90ffe778390adada@mail.gmail.com>
References: <20100216154015.GA612@tango.0pointer.de>
	<20100216210703.GA18109@tango.0pointer.de>
	<20100216223938.GA23623@sirena.org.uk>
	<20100216224212.GA1486@tango.0pointer.de>
	<4B7B2E9F.3080809@audioscience.com>
	<20100217001047.GB6766@tango.0pointer.de>
	<alpine.LNX.2.00.1002170924570.28127@eeebox2.perex-int.cz>
	<20100217130612.GD24165@tango.0pointer.de>
	<ad2655cb1002170555l462981cheff2b1798a14c9d0@mail.gmail.com>
	<20100217143540.GA404@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gv-out-0910.google.com (gv-out-0910.google.com [216.239.58.188])
	by alsa0.perex.cz (Postfix) with ESMTP id B99041038BF
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 17:17:25 +0100 (CET)
Received: by gv-out-0910.google.com with SMTP id n40so40523gve.24
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 08:17:25 -0800 (PST)
In-Reply-To: <20100217143540.GA404@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 17 February 2010 14:35, Lennart Poettering <mznyfn@0pointer.de> wrote:
>
>> This is a good aim, but I still think getting the correct 0dB points
>> is more important to ensure the best audio quality.
>> I personally think that PA should just set the hardware ALSA controls
>> to 0dB and do all the volume control in software within PA.
>> The 0dB points in hardware should result in the best sound quality.
>
> I don't think this would be a good idea. In a lot of hardware you
> definitely want to make as much use of the built-in volume adjustment
> capabilities as you can. For example, on my integrated USB speakers
> you may control the built-in amplifier with the alsa mixer, and that's
> definitely much better than attenuating the 16bit PCM stream and
> having the USB speakers amplifier constantly configured to a very high
> volume level.
>

I was thinking more specifically of the line-out and line-in where
knowing the 0dB gain points is very useful and what most people need,
with maybe a new dBv or dBu

Mic and Speaker amp levels is a whole other kettle of fish.
