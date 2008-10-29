From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: Backported sbxfi driver, possible fix
Date: Wed, 29 Oct 2008 09:38:41 +0100
Message-ID: <49082111.8070603@insite.cz>
References: <4900A4FA.7020300@jasonline.co.uk>	<4900DBBD.2020806@jasonline.co.uk>	<s5hljwee68t.wl%tiwai@suse.de>	<49017FBF.4030005@jasonline.co.uk>	<s5hfxmm47kb.wl%tiwai@suse.de>	<20081025130652.GA27621@rzle423.uni-duisburg.de>	<s5hej24psn6.wl%tiwai@suse.de>	<20081025194255.GA27872@rzle423.uni-duisburg.de>	<s5hod18fntg.wl%tiwai@suse.de>	<49038448.3090704@jasonline.co.uk>	<5501535d0810251457k165cc4ceid2e34930a2bdc8ec@mail.gmail.com>	<s5h7i7v22cl.wl%tiwai@suse.de>	<ge3irb$knf$1@ger.gmane.org>
	<49061FA4.5010201@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.insite.cz (cable.insite.cz [84.242.84.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 2A48F24157
	for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2008 09:38:42 +0100 (CET)
In-Reply-To: <49061FA4.5010201@superbug.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:
> Alexander E. Patrakov wrote:
> Alex,
> 
> I added that comment (takashi cut and pasted my text). No resampling is
> done.
> Say you have a buffer that is running at 48kHz.
> So you have say 480 samples at the 48kHz rate.
> But if you want to transfer 44.1kHz rate samples over it, you only want
> 441 samples to be there, so what to do with the left over 39 samples.
> What the xfi does is next to each sample it adds a "valid" tag.
> So, the xfi adds those 39 samples but marks them as "invalid".
> The xfi then drops the 39 "invalid" samples, leaving only the 441
> "valid" samples just before sending them at 44.1kHz to the DAC.
> Does this explain things a bit better.
> FYI, the xfi actually works internally at 384kHz, so it is actually
> marking a lot of samples as "invalid".
> 
> Kind Regards
> 
> James


James,

Thanks a lot for the info. Does it mean that the core runs at 384kHz, 
while codes are clocked by another clock signal PLL'd from the master 
clock to the required frequency? Theoretically this could allow running 
different outputs/channels at diferrent sample rates :)

Pavel.
