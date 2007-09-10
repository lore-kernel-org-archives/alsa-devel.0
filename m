From: Krzysztof Helt <krzysztof.h1@gmail.com>
Subject: Re: [PATCH] ad1848 and cs4231 busy loop replacement
Date: Mon, 10 Sep 2007 19:05:33 +0200
Message-ID: <20070910190533.e5382668.krzysztof.h1@gmail.com>
References: <20070909001208.b2e54c13.krzysztof.h1@gmail.com>
	<46E46109.5040704@gmail.com>
	<8c74410a0709100008v5497e870j7495b3ea054ae00b@mail.gmail.com>
	<46E53072.2040404@gmail.com>
	<8c74410a0709100542x6b5997d0hc893afb6f94acf4@mail.gmail.com>
	<46E542F4.7060608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.190])
	by alsa0.perex.cz (Postfix) with ESMTP id A68491038AB
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Sep 2007 18:58:47 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id d21so1142430nfb
	for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2007 09:58:47 -0700 (PDT)
In-Reply-To: <46E542F4.7060608@gmail.com>
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

On Mon, 10 Sep 2007 15:13:24 +0200
Rene Herman <rene.herman@gmail.com> wrote:

> On 09/10/2007 02:42 PM, Krzysztof Helt wrote:
> 
> > On 9/10/07, Rene Herman <rene.herman@gmail.com> wrote:
> 
> >> Well, no, sorry, but I consider that to be completely breaking the logic of
> >> the code.
> > 
> > No I changed the logic of this code not to wait for specifically for
> > callibration "start" but into calibration "under way".
> 
> No, waiting for calibration the be under way is what my 0/1 ms does. You are 
> waiting for it to be nearly done, which is complete nonsense. One line below 
> we are waiting for 250 ms (generally with _one_ pass through the loop -- we 
> only wake up through signals) anyway!
> 

I don't buy your argument that it is complete nonsense.
I want some merit argument like:
your code uses more memory/cpu, 
your code is longer,
your code drives hardware into undefined states,
your code push hardware outside hardware limits,
your code is slower/adds more delay.

Also, I don't think mimicking the hardware behaviour in driver code is 
correct paradigm. I think that correct way is to _drive_ the hardware. If the
hardware must be taken from state A to state C and goes through state B
, the driver may wait only for the C completely ignoring the B if the B
is irrelevant (no need to set or get something from the hardware until the C).

Another thing I believe is that driver should be "CPU friendly" means it should
gives back control to the CPU every time it knows the hardware is busy
and nothing can be done for some known period of time. That's why I don't
want to use all these m/udelay functions. They make CPU busy. Sometimes
they are must have, sometimes not. If one knows that it must wait at least
7ms why it should wait 1ms than makes another 6ms inside the loop?

Actually, if you look into the lower delay argument, the waiting loop after 
the change is inefficient. The whole calibration takes 2-3ms at the highest 
rate, but one has to wait in 10ms blocks. In order to lower this delay one 
must change it to some finer way of returning time to the CPU (cpu_relax()
or schedule_timeout() - like ad1848). If it is done, the loop will make 
thousands of iterations every few miliseconds. Taking your argument 
that loop should be passed in the least possible iterations (you wrote 
"preferably one pass"), the only way is to wait longer before entering the loop.

> 
> No, we are arguing maintaining code. Do not obscure the code flow for no 
> reason. Fix your logic or (for what it's worth) I am going to NAK the change.
> 

The code does not be obscured with one simple comment before msleep: 
/* wait till calibration is nearly done */

Also comments like "my way or highway" (NAK) won't make you many friends.

Krzysztof
