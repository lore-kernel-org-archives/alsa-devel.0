From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: S24_LE Mode for USB Driver
Date: Wed, 13 Aug 2008 13:17:44 +0200
Message-ID: <48A2C2D8.4040401@ladisch.de>
References: <489B5A4E.3040903@ieee.org> <s5htzdpi62s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 8D505244CD
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Aug 2008 13:17:50 +0200 (CEST)
In-Reply-To: <s5htzdpi62s.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, charles.eidsness@ieee.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Charles Eidsness wrote:
> > It looks like the parse_audio_format_i_type function at line 2369 of usbaudio.c
> > (linux v2.6.23) doesn't support the case where  bSubframeSize (fmt[5]) = 4 bytes
> > and  bBitResolution (fmt[6]) = 24 bits, which should correspond to a S24_LE (or
> > BE) type. I'm developing a new USD DAC which supports this mode (24-bit sample
> > in a 4 byte package). Right now Linux sends me S32_LE formated data, which is
> > wrong. Would it be possible to expand this function to support S24_LE/BE? It
> > would only require adding a few lines of code.
>
> Yes, it's possible, of course.
>
> BTW, is this behavior strictly defined?  I fail to find in the
> usb-audio spec that bBitResolution specifies the lower bits, not the
> higher bits...

The spec assumes that 24-bit samples use S24_3LE.  24-bit samples in
32-bit words are an extension that must be handled with some device-
specific code (like with the UA-1000).

(The audio 2.0 spec allows 32-bit words, and the wording seems to imply
that samples are aligned to the most significant bit, i.e., that S32_LE
would be used in this case.)


Regards,
Clemens
