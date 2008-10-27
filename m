From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: Backported sbxfi driver, possible fix
Date: Mon, 27 Oct 2008 10:15:07 +0500
Message-ID: <ge3irb$knf$1@ger.gmane.org>
References: <4900A4FA.7020300@jasonline.co.uk>	<4900DBBD.2020806@jasonline.co.uk>
	<s5hljwee68t.wl%tiwai@suse.de>	<49017FBF.4030005@jasonline.co.uk>
	<s5hfxmm47kb.wl%tiwai@suse.de>	<20081025130652.GA27621@rzle423.uni-duisburg.de>	<s5hej24psn6.wl%tiwai@suse.de>	<20081025194255.GA27872@rzle423.uni-duisburg.de>	<s5hod18fntg.wl%tiwai@suse.de>
	<49038448.3090704@jasonline.co.uk>	<5501535d0810251457k165cc4ceid2e34930a2bdc8ec@mail.gmail.com>
	<s5h7i7v22cl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id D6DEF245DE
	for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2008 06:17:03 +0100 (CET)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KuKSw-0004uY-Nm
	for alsa-devel@alsa-project.org; Mon, 27 Oct 2008 05:16:45 +0000
Received: from 90.151.140.69 ([90.151.140.69])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2008 05:16:34 +0000
Received: from patrakov by 90.151.140.69 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2008 05:16:34 +0000
In-Reply-To: <s5h7i7v22cl.wl%tiwai@suse.de>
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

Takashi Iwai wrote:
> A few important features are in my mind:
> - continuous rate support

In the sources, you have:

> Note: 44.1kHz is possible, but is more complex because it uses a method
> whereby the channel ring marks each sample in the channel ring as valid
> or not, so to get 44.1kHz, some samples are simply tagged invalid. The
> "channel ring" is not the ring buffer that is used to get sound samples
> to the card. The "channel ring" is used to pass samples between
> different processing modules on the card. One of these processing
> modules is the SRC, another is the INs/OUTs, another is the hardware
> mixer, and yet another is the DSP.

Do I understand correctly that the card internally resamples the sound 
to a different rate using the zero-order-hold method? If so, I'd rather 
not see this feature at all unless the "i_want_horrible_sound" parameter 
is passed, because software can do it better, and some program will 
surely default to using this hardware misfeature.

OTOH, Wine is doing this for ages and nobody except me complains 
(http://bugs.winehq.org/show_bug.cgi?id=14717)

-- 
Alexander E. Patrakov
(not an owner of any Creative card)
