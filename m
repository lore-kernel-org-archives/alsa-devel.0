From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Questions about virtual ALSA driver (dummy),
 PortAudio and full-duplex drops
Date: Thu, 25 Jul 2013 10:37:25 +0200
Message-ID: <51F0E3C5.4020400@ladisch.de>
References: <51EF41C8.2040701@imi.aau.dk>
 <201307241403.28873.gineera@aspect135.co.uk> <51F07150.1060004@imi.aau.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 72C0D26030F
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2013 10:37:27 +0200 (CEST)
In-Reply-To: <51F07150.1060004@imi.aau.dk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Smilen Dimitrov <sd@imi.aau.dk>
Cc: portaudio@music.columbia.edu, alsa-devel@alsa-project.org, audacity-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Smilen Dimitrov wrote:
>> [...] and you are not correctly
>> reporting the number of samples transferred to the hardware?
>
> I agree that it must be the core of the problem - but I have problem
> understanding why, given I currently perceive that I'm doing
> everything right: I know I have a rate of 44100 frames per second; I
> choose either a period for timer functions, and calculate bytes per
> period to match the rate, or vice versa; and in each period, I
> increase stream buffer positions for that bytes per period amount
> (taking care of buffer wrapping).

Your driver's .pointer callback must report the *actual* position at
which the hardware has finished reading from the buffer.  You *must*
read some hardware register of your DMA controller for this.  It is not
possible to deduce this from the current time because the clocks do not
run at the same speed, and any kind of buffering will introduce more
errors.

The dummy driver uses a timer because there is no actual hardware.


Regards,
Clemens
