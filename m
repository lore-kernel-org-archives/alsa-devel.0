From: Krzysztof Helt <krzysztof.h1@gmail.com>
Subject: Re: [PATCH] ad1848 and cs4231 busy loop replacement
Date: Mon, 10 Sep 2007 19:17:11 +0200
Message-ID: <20070910191711.1a087308.krzysztof.h1@gmail.com>
References: <20070909001208.b2e54c13.krzysztof.h1@gmail.com>
	<46E46109.5040704@gmail.com> <46E4637C.9000809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 35FA81038AE
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Sep 2007 19:10:25 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id h2so531218ugf
	for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2007 10:10:24 -0700 (PDT)
In-Reply-To: <46E4637C.9000809@gmail.com>
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
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 09 Sep 2007 23:19:56 +0200
Rene Herman <rene.herman@gmail.com> wrote:

> On 09/09/2007 11:09 PM, Rene Herman wrote:
> 
> > Given that the only difference is that I wait less, yours would've 
> > worked as well -- thanks for looking into this! And could you viceversa 
> > test this on AD1848 and perhaps resubmit if you agree?
> 
> Oh, and I forgot to say (sigh) that I use a mdelay() and not an msleep() in 
> the ad1848 one due to the 1 ms being short enough and didn't keep the 
> snd_printd() because if one, then all please...
> 

I tested CS4231 on 450MHz sparc with 1000Hz kernel (I don't have PC card yet).
The waiting loop was changed as in my second patch (the 10ms blocks 
to schedule_timeout()). I played 48kHz wav (alsa "Front_Center.wav").

The waiting loop was passed 340 times after mce was down with msleep(1).
The delay between snd_printd "2 jiffies" and "8 jiffies" was 3 jiffies.

The waiting loop was passed 34 times after mce was down with msleep(2).
The delay between snd_printd "2 jiffies" and "8 jiffies" was 3 jiffies too.

It took about ten times less loop passes if the driver waits 2ms.
The 2ms seems like the optimal value for the CS4231.

Regards,
Krzysztof
