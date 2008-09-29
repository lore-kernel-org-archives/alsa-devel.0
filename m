From: Eran Tromer <eran@tromer.org>
Subject: Re: Driver: EMU USB 0404 driver development
Date: Mon, 29 Sep 2008 18:01:50 -0400
Message-ID: <48E1504E.3080104@tromer.org>
References: <d9690f190809221113p1b410102oa733628ccfe8fc95@mail.gmail.com>	<fd3eb9bf0809260320r71a9f46bp30be1a2535b0c557@mail.gmail.com>
	<d9690f190809260644q48897b4drdcaf2418dc7784b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from outgoing.csail.mit.edu (outgoing.csail.mit.edu [128.30.2.149])
	by alsa0.perex.cz (Postfix) with ESMTP id D5F27243FB
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Sep 2008 00:01:57 +0200 (CEST)
In-Reply-To: <d9690f190809260644q48897b4drdcaf2418dc7784b2@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Klaus Schulz <kls.schlz@googlemail.com>
Cc: =?ISO-8859-2?Q?Vedran_Mileti=E6?= <rivanvx@gmail.com>, alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 2008-09-26 09:44, Klaus Schulz wrote:
> What's missing, is the complete control of the card modes, register settings
> etc.
> 
> If the registers are known, which I assume, according to EMU statement, it
> shouldn't be a big deal to get it working.
> 
> Now it would be interesting to know who sits on these information. I'd be
> happy to get in touch with him to support the design process.

James Courtier-Dutton has the E-MU USB specs. Quoting
<https://bugtrack.alsa-project.org/wiki/wikka.php?wakka=emu>:

"EMU have also now sent me a datasheet for the EMU USB sound cards. I
just need the time to play with them a bit to get them working.
Please feel free to send me donations to my paypal account: James at
superbug dot co dot uk
The support for the EMU USB cards has started, and basic support is now
in the latest alsa hg. It only supports 48000 rate, but all the in/outs
should work. Still TODO: Control of extension units that are used for
setting the rate,spdif options etc."

That's the last update, from 2007-10-07. Many people have offered help...

BTW, I guess the 48000Hz rate refers to the hardware's default sample
rate. The E-MU Tracker Pre (and recent 0202/0404 USB firmware) actually
defaults to 44100Hz, so it seems only that rate works with ALSA usb-audio.

  Eran
