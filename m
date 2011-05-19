From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: A plea for help on mixer support for Fast Track
 Ultra (8R)
Date: Thu, 19 May 2011 09:15:22 +0200
Message-ID: <4DD4C38A.2070209@ladisch.de>
References: <4DD3E39D.30100@showlabor.de>	<BANLkTinCn2Q+asKhGAoq+3S+AtqyHrg2wg@mail.gmail.com>	<4DD413FC.2090808@showlabor.de>	<BANLkTi=2NeMGL6n7B0n-2p9La=45pM7ZHg@mail.gmail.com>	<s5hhb8r1c20.wl%tiwai@suse.de>
	<4DD4BC97.5090702@showlabor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 7E7D4103996
	for <alsa-devel@alsa-project.org>;
	Thu, 19 May 2011 09:13:04 +0200 (CEST)
In-Reply-To: <4DD4BC97.5090702@showlabor.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felix Homann <linuxaudio@showlabor.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Grant Diffey <gdiffey@gmail.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Felix Homann wrote:
> Am 19.05.2011 07:42, schrieb Takashi Iwai:
> > I see no big reason to make things more complex.  If you want to avoid
> > the standard audio parsing after quirk but only parse mixer, just call
> > snd_usb_create_mixer() in your quirk function.
> 
> Maybe I'm misunderstanding your point. But I think your suggestion is 
> making things more complex.
> 
> I don't want to avoid the standard audio parsing. I want to use standard
> quirks if possible and still would like a means to call
> snd_usb_create_mixer(). That's all.

The quirks-table.h framework handles only quirks that attach to a USB
interface.  So create a FTU mixer quirk for intf 0 (or a generic quirk
with a separate table of mixer controls).

> Moreover, I can't believe that the Fast Track Ultra devices are the only
> ones in the world which have a standard USB mixer without exposing it
> through the descriptors.

So far, they are the only ones where somebody bothered to find out what
the controls are.

(Many vendor-specific controls don't implement the complex class-
compliant mixer protocol.)

> I knew it wasn't ready for submission. After generating the patch I send 
> I had already corrected the whitespaces and those lines with over 80 
> characters that weren't just copies from other locations. The remaining 
> issues like "! cval" and "ERROR: do not use assignment in if condition" 
> were all taken literally from other locations inside the respective 
> files.

"Do as I say, not as I do."  ;-)


Regards,
Clemens
