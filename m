From: Florian Faber <faber@faberman.de>
Subject: Re: PROPOSAL: Layer Signal Processing Architecture
Date: Thu, 29 Jul 2010 22:52:01 +0200
Message-ID: <4C51E9F1.3090601@faberman.de>
References: <20100729202024.GA14426@00110101.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from india820.server4you.de (india820.server4you.de [85.25.152.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 2FBBE1039DF
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jul 2010 22:52:09 +0200 (CEST)
In-Reply-To: <20100729202024.GA14426@00110101.home>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 07/29/10 22:20, Ilya D wrote:

> it's not to replace ALSA, but just to bring a different approach for
> design engineers of professional audio applications.
> we all know that these days a lot manufactuares chose Linux
> for their Mixing Consoles (such as Midas, Lawo, Calrec and others),
> also other products use Linux, but there might be only a few who use
> ALSA (as far as i could find out there rather NONE in pro-audio Linux devices).

What for would I use ALSA in a mixing console? In a mixing console I
control the user interface and a bunch of external DSP units.

Besides, audio interfaces become less important in pro audio with
upcoming transport over ethernet.

> ALSA had been designed for conventional sound-cards (largely) also there
> drivers for RME, DigiGram and other pro-interfaces,
> but the hardware is still proprietary and it isn't quite flexible.

What do you want to say with the latter? They are just interfaces, what
more should they do?

> Another motivating factor is upcomming completition of AVB ethernet
> standard from IETF/IEEE, there had been no publicaly avaliable code
> for this, nor i could find any discussions of how it could be
> implemented in Linux. However i have contact with a professor Richard
> Foss from Rhodes University, and there they have implemented a library
> and packet generator for AVB, though they haven't yet published this code.

You cannot do AVB in software.

> There also hasn't heppend any wide adoption of OSC, and may be OSC is
> not that great?

That depends on the job. For the purpose you stated - no it is not.


Flo
-- 
Machines can do the work, so people have time to think.
public key DA43FEF4          x-hkp://wwwkeys.eu.pgp.net
