From: Marco Vermeulen <vermeulen.mp@gmail.com>
Subject: Re: No sound on MacBook 3.1
Date: Thu, 26 Jun 2008 00:08:40 +0100
Message-ID: <7D07D569-9984-4D79-8FD0-9D83C8EC7F27@gmail.com>
References: <1214384314.21257.12.camel@blackadder.site>
	<48627AD7.4070109@cox.net>
Mime-Version: 1.0 (iPod Mail 4A102)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 583F824500
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Jun 2008 01:08:55 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id e27so154656nfd.32
	for <alsa-devel@alsa-project.org>; Wed, 25 Jun 2008 16:08:54 -0700 (PDT)
In-Reply-To: <48627AD7.4070109@cox.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: stan <ghjeold_i_mwee@cox.net>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi all,
I just wanted to let everyone know that I got it working on my  
Macbook. I got hold of Leonardo, and we compared specs (to rule out  
that my machine was some fringe case). It turned out that we had  
identical machines...

Next up I started playing with the module options, restarted the alsa  
daemon and then it worked!

Thanks for pointing me in the right direction!

One last thing: my volume in Linux seems far lower than in OSX. All  
the faders are on max, yet the volume remains low. Any ideas how I  
might boost this?

Thanks again,
Marco.

On 25 Jun 2008, at 18:05, stan wrote:
>>
>>
>>
>>
> It looks like you should have sound.  Alsa is recognizing your card  
> and loading the driver.
>
> You could upgrade to alsa 1.0.17.RC2 to see if that helps.
> You could try sending parameters to the driver load (3-stack, 6- 
> stack, etc.) to see if that helps.
>
> Also try aplay -D plughw:0,0  some.wav to see if there is any sound.
>
> Are you running any sound servers?  They can interfere if the rest  
> of the system isn't compatible with them.
>
> Maybe someone else here knows exactly what is wrong.
