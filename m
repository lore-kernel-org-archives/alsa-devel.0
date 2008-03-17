From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [alsa-devel] [regression] 2.6.25-rc4 snd-es18xx broken on Alpha
Date: Mon, 17 Mar 2008 23:04:55 +0100
Message-ID: <47DEEB07.7010504@keyaccess.nl>
References: <20080314131344.62A59DBA2@gherkin.frus.com> <200803142118.31974.twhitehe@uwo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <200803142118.31974.twhitehe@uwo.ca>
Sender: linux-alpha-owner@vger.kernel.org
To: twhitehe@uwo.ca
Cc: Bob Tracy <rct@frus.com>, Michael Cree <mcree@orcon.net.nz>, Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>, linux-kernel@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org, Krzysztof Helt <krzysztof.h1@wp.pl>
List-Id: alsa-devel@alsa-project.org

On 15-03-08 02:18, Tyson Whitehead wrote:

> With regard to the sound driver, the es18xx does endless looping on the first 
> second or so of sound on my box (a PWS500au) unless I apply my patch, which 
> just enables the alternative interupt detection code in the driver.  Even 
> then, though, I believe it still only works in 8bit mode.

Could you attach that patch? Links I'm finding are to

http://whitehead.apmaths.uwo.ca/~tyson/

which seems to be dead.

> The sb8 driver also works for me.  For this reason, I basically decided to 
> forget about my es18xx patch.  It doesn't get me anything the sb8 driver 
> doesn't give me, and it forces me to keep compiling my own kernels.
> 
> Cheers!  -Tyson
> 
> PS:  The Debian 2.6.24 kernel actually panicked on me (instead of infinitely 
> looping on the first second of sound) when I tried the stock es18xx driver.

Rene.
