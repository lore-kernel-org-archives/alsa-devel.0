From: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Subject: Re: alsa device drain power
Date: Fri, 18 Dec 2009 11:03:27 +0100
Message-ID: <4B2B536F.4060800@gandalf.sssup.it>
References: <4B29F03F.4020100@gandalf.sssup.it>
	<20091217110334.GB12245@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from panicking.kicks-ass.org (unknown [77.224.194.88])
	by alsa0.perex.cz (Postfix) with ESMTP id B33A7103815
	for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2009 11:03:47 +0100 (CET)
In-Reply-To: <20091217110334.GB12245@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Thu, Dec 17, 2009 at 09:47:59AM +0100, Michael Trimarchi wrote:
>
>   
>> I have a simple question is the general behavior that an alsa device 
>> start to drain power
>> when it starts to play sound or start to recording. What happen if there 
>> is an external amplifier
>> connect to sound device?
>>     
>
> In general any audio component is going to draw more power if there is a
> signal going through it than if it's idle.  This is true regardless of
> how the audio subsystem is split in terms of physical chips.
>
> What are you trying to find out here?
>
>   
As reported by the datasheet the LM4853 has a bias circuitry shutdown.
This shutdown function is activated by applying a logic high to the
SHUTDOWN pin. This pin as command by the

static int lm4853_event(struct snd_soc_dapm_widget *w,
                        struct snd_kcontrol *k,
                        int event)

in gta02. I don't put any debug stuff there but I suppose
if I open the device with and asound.conf that set
the value to true of the Stereo Out this event is called. Is it right?

Michael
