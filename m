From: "Alexandre BOUIN" <a.bouin@kerlink.fr>
Subject: Re: Random inverted audio channels
Date: Thu, 20 Mar 2008 11:27:46 +0100
Message-ID: <20851.0536155247$1206008950@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from scanner-relay-corvus2.pulsation.fr
	(scanner-relay-corvus2.pulsation.fr [80.74.64.70])
	by alsa0.perex.cz (Postfix) with SMTP id 2D9A12471E
	for <alsa-devel@alsa-project.org>; Thu, 20 Mar 2008 11:28:11 +0100 (CET)
References: 
In-Reply-To: 
Content-Language: fr
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

> I'm currently working on an internal project.
> Here is some details :
> This embedded project includes a AT91SAM9260 CPU and a WM8900 codec.
> Audio driver is using ASoC API.
> Audio data could be either switch from I2S or DSP A, but I prefer the
> second one.
> Audio Codec is master.
> 
> We have an issue : when we play a right channel stereo track, sound is
> played on right channel, but sometimes on left.
> This issue could happen right after starting kernel, or later after 10-
> 20 sounds played.

Hi list,

I'm back on this issue. I have few questions about it and I'd hope someone
could answer : 
- does someone have already used AT91 SSC controller in slave mode ? Can he
send me his register configuration and tell if he already heard and L/R
channels swaps ?
- is there a way to play a sound at the lowest software level, maybe without
using alsa or dsp devices ?
- where is the software audio buffer ?

As you can see I really want to trace any difficulties to find where comes
this problem.
As always, if you have any other ideas to test, I'll be glad to hear them.

Thanks and regards,
Alex.
