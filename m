From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 2/5] ALSA: usb-audio: unify UAC macros and
	struct names
Date: Wed, 16 Jun 2010 19:40:44 +0200
Message-ID: <20100616174044.GA17833@buzzloop.caiaq.de>
References: <1276703851-22199-1-git-send-email-daniel@caiaq.de>
	<1276703851-22199-3-git-send-email-daniel@caiaq.de>
	<s5hr5k6nao6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 118561038F0
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Jun 2010 19:40:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hr5k6nao6.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alexlee188@gmail.com, alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 16, 2010 at 07:34:49PM +0200, Takashi Iwai wrote:
> At Wed, 16 Jun 2010 17:57:28 +0200,
> Daniel Mack wrote:
> > 
> > diff --git a/include/linux/usb/audio.h b/include/linux/usb/audio.h
> > index c51200c..a54b825 100644
> > --- a/include/linux/usb/audio.h
> > +++ b/include/linux/usb/audio.h
> > @@ -39,8 +39,8 @@
> >  #define UAC_MIXER_UNIT			0x04
> >  #define UAC_SELECTOR_UNIT		0x05
> >  #define UAC_FEATURE_UNIT		0x06
> > -#define UAC_PROCESSING_UNIT_V1		0x07
> > -#define UAC_EXTENSION_UNIT_V1		0x08
> > +#define UAC1_PROCESSING_UNIT		0x07
> > +#define UAC1_EXTENSION_UNIT		0x08
> 
> So now we have mixed prefix here, UAC_ and UAC1_.
> Isn't it a bit confusing, too?
> 
> Honestly, I have no much preference about this name-ruling.
> But it's of course better if it's stabilized :)

Well yeah, I hate that too, especially as it is a matter of taste
eventually. However, the idea is: things that are common for both UAC1
and UAC2 are prefixed with UAC_, and only those things that are special
get a number suffix. Which is the case in the block you quoted above.

(This perticular detail is really the greatest unnecessary confusion in
the UAC2 spec, btw. They just drop one enumeration value and shuffled
two others around for no obvious reason. Now we have to live with that.)

Thanks,
Daniel
