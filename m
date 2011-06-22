From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Jack event API - decision needed
Date: Wed, 22 Jun 2011 14:25:18 +0100
Message-ID: <20110622132518.GB21802@opensource.wolfsonmicro.com>
References: <4DFF4D15.6050809@canonical.com>
	<20110620170739.GD32056@opensource.wolfsonmicro.com>
	<4DFF973A.1080404@canonical.com>
	<20110620234053.GA1905@opensource.wolfsonmicro.com>
	<4E008A63.5080403@canonical.com>
	<20110621123908.GA25980@opensource.wolfsonmicro.com>
	<4E01C847.7060505@canonical.com>
	<20110622114826.GD18726@opensource.wolfsonmicro.com>
	<BANLkTikGd+3_=JA5rEkpH0iNGkashgT7DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4F2ED1039E6
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jun 2011 15:25:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTikGd+3_=JA5rEkpH0iNGkashgT7DQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Lennart Poettering <lennart@poettering.net>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 22, 2011 at 02:50:59PM +0200, Kay Sievers wrote:

> I'm still pretty sure that there should be no fake input devices
> involved for any jack related things. Especially not in the simple and
> common desktop case, where the input devices are created by, and
> direct child devices of the ALSA card device (like Intel HDA). I'm
> sure, such things just belong to the ALSA control device directly.

It would really helpful if you could engage with some of the discussion
about this...  Apart from anything else "fake" seems a bit misleading,
a jack is a physical thing which really exists and which I can point to
on the system and in may cases has buttons on it.

> There might be odd use cases or use cases where multiple device
> classes are involved for the same type of jacks, which can probably
> not be covered by the ALSA-only control device, and where some

Like I said in reply to your earlier mail on this subject that's not a
terribly unusual case for PC class hardware, HDMI is very widely
deployed and obviously carries both audio and video over a single
physical connector.

> To me the ALSA control device events for audio-related jack events
> seems like the natural interface and the best option currently. Unless
> there are good technical reasons not to do that, I like to see them
> made working, instead of adding support for input devices, or wait for
> some (magic) meta multimedia device to be defined, or an additional
> userspace event daemon requirement.

To summarise some of the issues from the rest of the thread:

 - This isn't a new interface at all, it's been implemented in the
   kernel for quite some time now (the first switch was added in
   2.6.18).  All that's changed here is that PulseAudio is trying to
   use the information that the kernel is exporting.
 - Mixed function jacks aren't that unusual; if anything they're more
   common on PCs than anything else.  HDMI is the obvious one for PC
   class hardware and where these things happen we do need to be able to
   join the audio and the video up with each other.
 - Many jacks include buttons so need an input device anyway which again
   we want to join up with the other functions.
 - We still need to handle cases where the jack isn't particularly
   closely connected to the audio subsystem.
 - There are other non-audio non-jack things being exposed via the same
   interface which we need to have some method for handling even if we
   end up doing something audio specific for some subset of jacks.

and probably some others I forget.
