From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: ADAU1761 default register value problem
Date: Tue, 26 Apr 2016 10:21:39 +0200
Message-ID: <571F2513.1020005@metafoo.de>
References: <alpine.DEB.2.02.1604211547540.31333@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FC002604BE
 for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2016 10:21:41 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1604211547540.31333@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 04/21/2016 04:01 PM, Ricard Wanderlof wrote:
> 
> Hi Lars,
> 
> A while ago I posted a question to the list regarding the default values 
> set up for the ADAU1761 (and similar CODECs), but I didn't get a response. 
> I really need to try and figure out a way forward here though so I'll 
> bring this up again.
> 
> The problem I have is that the driver assumes that the CODEC has been 
> initialized with the default register settings when the system boots. 
> However, if the system has not been power cycled but just rebooted, this 
> is not necessarily the case, as the CODEC has no external reset pin but 
> derives its reset signal internally from the power level.
> 
> Furthermore, if the system upon reboot tries to set a register value to 
> one of the default settings (for example as the result of a hw_params() 
> call), then the regcache mechanism will disregard the write as it assumes 
> the default value is already set, which is not necessarily the case.
> 
> As I see it the solution to this problem is simply not to assume anything 
> about the register settings, so that the first write to a given register 
> always takes effect.
> 
> I can work on a patch to accomplish this, however, since so much work 
> apparently has been laid down in getting the default values into the 
> driver in the first place, I'm assuming there's something more to the 
> story that I'm missing, so I'd like to get a better grip on this before I 
> dive in.

Hi,

I've been thinking about this for the last few days trying to come up with a
good solution, but it is really difficult.

The issue you are describing is simply an oversight from my side.

One solution would be do drop the register default values and let regmap
fill the register cache on demand when a read is done the first time for a
register. The problem with this approach is that we leave the device in an
unknown state when we probe the driver, but we really want to have it in a
known state of lowest power.

The alternative is to write out the register defaults when the device is
probed, sort of a poor mans software reset, this brings us into a known
state. This approach has the downside that there is the overhead of having
to write all registers.

I don't like either, but given the limitations of the hardware we'll have to
choose one and in that case I'd slightly lean towards the later solution has
it gives us consistent and predictable behavior and the overhead of writing
the registers should be manageable.

- Lars
