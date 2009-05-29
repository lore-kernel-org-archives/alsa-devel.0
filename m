From: Cameron Stone <camerons.lists@cse.unsw.edu.au>
Subject: Re: Increasing maximum sampling frequency?
Date: Fri, 29 May 2009 12:20:20 +1000
Message-ID: <4A1F4664.3020802@cse.unsw.edu.au>
References: <4A1DED36.4030008@cse.unsw.edu.au>	
	<20090528121255.GJ14868@buzzloop.caiaq.de>	
	<4A1E91E1.9020801@cse.unsw.edu.au>
	<53baa24a0905281222t46596693y8899174cc2d06f44@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tone.orchestra.cse.unsw.EDU.AU (tone.orchestra.cse.unsw.EDU.AU
	[129.94.242.59]) by alsa0.perex.cz (Postfix) with ESMTP id 1100324541
	for <alsa-devel@alsa-project.org>;
	Fri, 29 May 2009 04:20:26 +0200 (CEST)
In-Reply-To: <53baa24a0905281222t46596693y8899174cc2d06f44@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alex Austin <circuitsoft.alex@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The A/D chip is an Analog Devices 7928. It can do 2 mega-samples per
second, multiplexed across 8 inputs. The USB audio interface is provided
by my firmware code, assisted by the AVR AT90USB647 micro which has some
low-level USB support.

HTH.

Cameron.

Alex Austin wrote:
> By Codec, I think he's asking about the A/D chip. For example, the TI
> PCM2902E is a stereo USB audio codec.
> 
> - Alex Austin
> (651) 238-9273
> 
> "...and then I visited Wikipedia ...and the next 8 hours are a blur."
> 
> 
> On Thu, May 28, 2009 at 8:30 AM, Cameron Stone
> <camerons.lists@cse.unsw.edu.au <mailto:camerons.lists@cse.unsw.edu.au>>
> wrote:
> 
>     Daniel Mack wrote:
>     > On Thu, May 28, 2009 at 11:47:34AM +1000, Cameron Stone wrote:
>     >> I've got a USB microphone application that I want to sample at
>     256000 8
>     >> bit samples per second so I can listen to bats. I know that my device
>     >> can get close to that rate, but alsa seems to restrict sampling
>     rates to
>     >> 192kHz.
>     >
>     > Just out of curiosity - which microphone and what kind of codec
>     are you
>     > using for such frequencies?
> 
>     I don't know which microphone but I can find out if you're interested. I
>     do know that its sensitivity starts at 10kHz, if that helps.
> 
>     There is no codec used. I'm using Type I (uncompressed PCM) because it's
>     being powered by an AVR running at 16MHz and there's not enough clock
>     cycles to encode the samples.
> 
>     Cameron.
>     _______________________________________________
>     Alsa-devel mailing list
>     Alsa-devel@alsa-project.org <mailto:Alsa-devel@alsa-project.org>
>     http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
> 
