From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Backported sbxfi driver, possible fix
Date: Mon, 27 Oct 2008 20:08:04 +0000
Message-ID: <49061FA4.5010201@superbug.co.uk>
References: <4900A4FA.7020300@jasonline.co.uk>	<4900DBBD.2020806@jasonline.co.uk>	<s5hljwee68t.wl%tiwai@suse.de>	<49017FBF.4030005@jasonline.co.uk>	<s5hfxmm47kb.wl%tiwai@suse.de>	<20081025130652.GA27621@rzle423.uni-duisburg.de>	<s5hej24psn6.wl%tiwai@suse.de>	<20081025194255.GA27872@rzle423.uni-duisburg.de>	<s5hod18fntg.wl%tiwai@suse.de>	<49038448.3090704@jasonline.co.uk>	<5501535d0810251457k165cc4ceid2e34930a2bdc8ec@mail.gmail.com>	<s5h7i7v22cl.wl%tiwai@suse.de>
	<ge3irb$knf$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-36.mail.demon.net (anchor-post-36.mail.demon.net
	[194.217.242.86])
	by alsa0.perex.cz (Postfix) with ESMTP id DC7DF2438F
	for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2008 21:08:11 +0100 (CET)
In-Reply-To: <ge3irb$knf$1@ger.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Alexander E. Patrakov wrote:
> Takashi Iwai wrote:
> 
>> Note: 44.1kHz is possible, but is more complex because it uses a method
>> whereby the channel ring marks each sample in the channel ring as valid
>> or not, so to get 44.1kHz, some samples are simply tagged invalid. The
>> "channel ring" is not the ring buffer that is used to get sound samples
>> to the card. The "channel ring" is used to pass samples between
>> different processing modules on the card. One of these processing
>> modules is the SRC, another is the INs/OUTs, another is the hardware
>> mixer, and yet another is the DSP.
> 
> Do I understand correctly that the card internally resamples the sound 
> to a different rate using the zero-order-hold method? If so, I'd rather 
> not see this feature at all unless the "i_want_horrible_sound" parameter 
> is passed, because software can do it better, and some program will 
> surely default to using this hardware misfeature.
> 


Alex,

I added that comment (takashi cut and pasted my text). No resampling is
done.
Say you have a buffer that is running at 48kHz.
So you have say 480 samples at the 48kHz rate.
But if you want to transfer 44.1kHz rate samples over it, you only want
441 samples to be there, so what to do with the left over 39 samples.
What the xfi does is next to each sample it adds a "valid" tag.
So, the xfi adds those 39 samples but marks them as "invalid".
The xfi then drops the 39 "invalid" samples, leaving only the 441
"valid" samples just before sending them at 44.1kHz to the DAC.
Does this explain things a bit better.
FYI, the xfi actually works internally at 384kHz, so it is actually
marking a lot of samples as "invalid".

Kind Regards

James
