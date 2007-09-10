From: "Krzysztof Helt" <krzysztof.h1@gmail.com>
Subject: Re: [PATCH] ad1848 and cs4231 busy loop replacement
Date: Mon, 10 Sep 2007 14:42:43 +0200
Message-ID: <8c74410a0709100542x6b5997d0hc893afb6f94acf4@mail.gmail.com>
References: <20070909001208.b2e54c13.krzysztof.h1@gmail.com>
	<46E46109.5040704@gmail.com>
	<8c74410a0709100008v5497e870j7495b3ea054ae00b@mail.gmail.com>
	<46E53072.2040404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.184])
	by alsa0.perex.cz (Postfix) with ESMTP id CCFE8103864
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Sep 2007 14:42:44 +0200 (CEST)
Received: by rv-out-0910.google.com with SMTP id k20so989624rvb
	for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2007 05:42:43 -0700 (PDT)
In-Reply-To: <46E53072.2040404@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 9/10/07, Rene Herman <rene.herman@gmail.com> wrote:
> On 09/10/2007 09:08 AM, Krzysztof Helt wrote:
>
> > Rene wrote:

> Well, no, sorry, but I consider that to be completely breaking the logic of
> the code.

No I changed the logic of this code not to wait for specifically for
callibration "start" but into calibration "under way".

> One line after this bit, we're doing the "wait for calibration to
> finish" loop (and already schedule ourselves away while doing so, for 250ms
> no less) meaning that at this point we should only wait long enough to be
> guaranteed that the ACI bit reflects reality -- those 5 cycles.
>
> Your: wait unconditionally until calibration _nearly_ done, then go wait for
> it for 250 ms to be really done.
>
> Mine: wait unconditionally until calibration has started, then go wait for
> it for 250 ms to finish.
>

This discussion get me amused. Look at the code:

Mine:

msleep(7); /* or msleep(2) for CS4231 */

/*waiting loop 250ms*/
while ...

Yours:
msleep(1); /* or msleep(1) for CS4231 */

/*waiting loop 250ms */
while ...

So the only difference is 6 (or 1) ms and this time will be spent in
the loop anyway. Are we arguing 1ms (for CS4231) in 250ms waiting
loop?
If you really want it can be substracted from the waiting loop 250ms
to be exactly the same as it was.

> Really -- please just do the 1 ms delay for ad1848 and either no delay or
> the same 1 ms for cs4231 if you want to keep them in sync

I don't understand "keep them in sync". After the patch they behave
the same but with different delay (they have different speed). It can
be 2ms (as for faster one) for both but I wanted to avoid doing many
loop iterations if possible.

Regards,
Krzysztof
