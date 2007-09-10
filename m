From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] ad1848 and cs4231 busy loop replacement
Date: Mon, 10 Sep 2007 15:13:24 +0200
Message-ID: <46E542F4.7060608@gmail.com>
References: <20070909001208.b2e54c13.krzysztof.h1@gmail.com>	
	<46E46109.5040704@gmail.com>	
	<8c74410a0709100008v5497e870j7495b3ea054ae00b@mail.gmail.com>	
	<46E53072.2040404@gmail.com>
	<8c74410a0709100542x6b5997d0hc893afb6f94acf4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id B6A0E243FD
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Sep 2007 15:20:17 +0200 (CEST)
In-Reply-To: <8c74410a0709100542x6b5997d0hc893afb6f94acf4@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 09/10/2007 02:42 PM, Krzysztof Helt wrote:

> On 9/10/07, Rene Herman <rene.herman@gmail.com> wrote:

>> Well, no, sorry, but I consider that to be completely breaking the logic of
>> the code.
> 
> No I changed the logic of this code not to wait for specifically for
> callibration "start" but into calibration "under way".

No, waiting for calibration the be under way is what my 0/1 ms does. You are 
waiting for it to be nearly done, which is complete nonsense. One line below 
we are waiting for 250 ms (generally with _one_ pass through the loop -- we 
only wake up through signals) anyway!

The no delay at all from cs4231 is the logic -- when we've dropped MCE, ACI 
comes up (when auto-calibrating) and we only wait for it to finish. For 
ad1848, ACI up may take 5 cycles from MCE down so we delay 1 ms so we know 
we're testing correctly.

>> Your: wait unconditionally until calibration _nearly_ done, then go wait for
>> it for 250 ms to be really done.
>>
>> Mine: wait unconditionally until calibration has started, then go wait for
>> it for 250 ms to finish.

[ ... ]

> So the only difference is 6 (or 1) ms and this time will be spent in
> the loop anyway. Are we arguing 1ms (for CS4231) in 250ms waiting
> loop?

No, we are arguing maintaining code. Do not obscure the code flow for no 
reason. Fix your logic or (for what it's worth) I am going to NAK the change.

> I don't understand "keep them in sync".

In sync source-code wise. While the no delay from cs4231 may be the rule, 
ad1848 needs a small delay so if you'd wanted to keep them looking the same 
I wouldn't care about a 1 ms delay for cs4231 as well. If you don't, fine as 
well.

Rene.
