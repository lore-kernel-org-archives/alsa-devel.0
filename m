From: "Martin Tufnel" <martin.tufnel@gmail.com>
Subject: Re: hdsp rpm support
Date: Tue, 27 May 2008 22:59:26 +1000
Message-ID: <c62722740805270559q6a47d5fq3e3084a995494e1@mail.gmail.com>
References: <c62722740805260033t68f1ab1cu7ed5908f803fbacd@mail.gmail.com>
	<47321.137.248.1.11.1211815832.squirrel@webmail.naturestudies.eu>
	<c62722740805262000i33e9ea00p88bc808ef286732c@mail.gmail.com>
	<200805270814.36011.faber@faberman.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B14C243B0
	for <alsa-devel@alsa-project.org>;
	Tue, 27 May 2008 14:59:28 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m28so2339646wag.8
	for <alsa-devel@alsa-project.org>; Tue, 27 May 2008 05:59:27 -0700 (PDT)
In-Reply-To: <200805270814.36011.faber@faberman.de>
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
To: Florian Faber <faber@faberman.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Flo

On Tue, May 27, 2008 at 4:14 PM, Florian Faber <faber@faberman.de> wrote:

> Martin,
>
> > Just to clarify, given the driver is finished but the user tools are
> > still under development, this means that the unit will basically work
> > but not have its full functionality - is this correct?
>
> You have IO, you can adjust the input levels, switch standby and
> disconnect the box. So everything works as you would expect it.
>

Great!


>
> > Also, did you use the new patched version of the firmware that Karl
> > worked on?
>
> No, it's the original firmware. Why would one want to patch it?
>

My understanding from Roman's previous posts was that there was a problem
loading the firmware from within Linux.  If I understood him correctly, he
needed to load the fireware from within a Windows boot and then boot into
Linux (without turning off the machine of course).  Perhaps I misunderstood
him.

Clearly, you're not suffering from the same problem!



>
> > And, when do you think the driver will be incorporated into the main
> > Alsa code branch?
>
> The driver itself won't help you since the old user space tools don't
> know the io box. You wouldn't be able to upload the firmware, adjust
> the mixer levels etc. (unless you patch the old user space tools, of
> course).
>

I'm sorry, I'm a bit confused here.  You said above that "You have IO, you
can adjust the input levels, switch standby and disconnect the box. So
everything works as you would expect it."  I'm assuming here that you're
talking about the driver as you said that that was finished.  However, what
you've just said above seems to contradict this as it seems you're saying
that you can't do anything with just the driver - you need the user space
tools??

Thanks again for your efforts, Martin
