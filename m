From: Cameron Stone <camerons.lists@cse.unsw.edu.au>
Subject: Re: Increasing maximum sampling frequency?
Date: Thu, 28 May 2009 23:30:09 +1000
Message-ID: <4A1E91E1.9020801@cse.unsw.edu.au>
References: <4A1DED36.4030008@cse.unsw.edu.au>
	<20090528121255.GJ14868@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tone.orchestra.cse.unsw.EDU.AU (tone.orchestra.cse.unsw.EDU.AU
	[129.94.242.59]) by alsa0.perex.cz (Postfix) with ESMTP id 29C9F245BA
	for <alsa-devel@alsa-project.org>;
	Thu, 28 May 2009 15:30:21 +0200 (CEST)
In-Reply-To: <20090528121255.GJ14868@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:
> On Thu, May 28, 2009 at 11:47:34AM +1000, Cameron Stone wrote:
>> I've got a USB microphone application that I want to sample at 256000 8
>> bit samples per second so I can listen to bats. I know that my device
>> can get close to that rate, but alsa seems to restrict sampling rates to
>> 192kHz.
> 
> Just out of curiosity - which microphone and what kind of codec are you
> using for such frequencies?

I don't know which microphone but I can find out if you're interested. I
do know that its sensitivity starts at 10kHz, if that helps.

There is no codec used. I'm using Type I (uncompressed PCM) because it's
being powered by an AVR running at 16MHz and there's not enough clock
cycles to encode the samples.

Cameron.
