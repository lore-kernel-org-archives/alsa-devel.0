From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Tue, 15 Apr 2008 16:33:28 +0200
Message-ID: <4804BCB8.9060707@keyaccess.nl>
References: <20080411204610.GA32413@tango.0pointer.de>	<20080414172839.GA26513@tango.0pointer.de>	<4803C78A.3020109@superbug.co.uk>	<200804150552.13578.faber@faberman.de>
	<20080415131203.GA2818@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 84C962471D
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Apr 2008 16:30:33 +0200 (CEST)
In-Reply-To: <20080415131203.GA2818@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Rigg <aldev@sound-man.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 15-04-08 15:12, John Rigg wrote:

> The dB setting in a mixer refers to gain, not level. Expecting the same
> absolute level from pro and consumer sound cards at the same gain setting
> is a little ridiculous. If I set a control at 0dB I want just that: 0dB
> gain.

Quite right.

There is still the issue that we probably don't so much want a distribution 
to have to decide if it's speaking to a pro or consumer card and that there 
are differences between (cheap consumer only I gather?) cards as well, which 
might be classified hardware bugs but which exist nonetheless.

Attempt to summarize:

1. ALSA mutes everything by default which as discussed is the only possibly 
sane thing to do especially in a pro environment (although I myself think 
that headphone using consumers and expensive gear using pros have a very 
similar need here: to avoid heart attacks).

2. Distributions have been set up to save and restore the levels over driver 
uses but since they obviously can't expect those poor, poor consumer users 
to be able to find a volume slider upon not hearing sound come out they want 
to unmute/init first time even -- which seems a somewhat flimsy motivation 
for having this discussion, but oh well.

3. Other than muted, 0 dB is the other potentially sane default value with 
it being defined as the no gain point. At least one (USB) driver has been 
identified as not producing 0 dB gain at the 0 dB ALSA slider setting; it 
gets the scale information from the hardware and the hardware is evidently 
buggy. Fixing this in the driver through model specific quirks would be the 
most sensible here as then the "0 dB" actually could start to mean what it 
should mean again.

4. Personally, I'd actually like to have a complete set of "unmuted default" 
controls on a per card basis. ALSA could distribute state files for those 
cards that like to be inited to anything other than all mute/minimal. Bit of 
a maintenance chore, and the usefulness depends on how much level variation 
there actually is generally. Are we in essence only talking about Lennart's 
buggy USB crap or is this more involved?

Rene.
