From: Stephen Warren <swarren@nvidia.com>
Subject: Re: Jack event API - decision needed
Date: Wed, 22 Jun 2011 14:57:07 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF049D2EBC55@HQMAIL01.nvidia.com>
References: <4DFF4D15.6050809@canonical.com>
	<20110620170739.GD32056@opensource.wolfsonmicro.com>
	<4DFF973A.1080404@canonical.com>
	<20110620234053.GA1905@opensource.wolfsonmicro.com>
	<4E008A63.5080403@canonical.com>
	<20110621123908.GA25980@opensource.wolfsonmicro.com>
	<4E01C847.7060505@canonical.com>
	<20110622114826.GD18726@opensource.wolfsonmicro.com>
	<BANLkTikGd+3_=JA5rEkpH0iNGkashgT7DQ@mail.gmail.com>
	<20110622132518.GB21802@opensource.wolfsonmicro.com>
	<20110622210131.GA6861@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id D44D524487
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jun 2011 23:57:24 +0200 (CEST)
In-Reply-To: <20110622210131.GA6861@tango.0pointer.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lennart Poettering <mznyfn@0pointer.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Kay Sievers <kay.sievers@vrfy.org>, Henningsson <david.henningsson@canonical.com>, David@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Lennart Poettering wrote at Wednesday, June 22, 2011 3:02 PM:
> On Wed, 22.06.11 14:25, Mark Brown (broonie@opensource.wolfsonmicro.com) wrote:
> > On Wed, Jun 22, 2011 at 02:50:59PM +0200, Kay Sievers wrote:
> >
> > > I'm still pretty sure that there should be no fake input devices
> > > involved for any jack related things. Especially not in the simple and
> > > common desktop case, where the input devices are created by, and
> > > direct child devices of the ALSA card device (like Intel HDA). I'm
> > > sure, such things just belong to the ALSA control device directly.
> >
> > It would really helpful if you could engage with some of the discussion
> > about this...  Apart from anything else "fake" seems a bit misleading,
> > a jack is a physical thing which really exists and which I can point to
> > on the system and in may cases has buttons on it.
> 
> I fully agree with Kay here btw.
> 
> Input devices should really just be used for input, i.e. interfacing
> with humans via keyboards, mice, joystick, touchscreens and
> suchlike. However Jack sensing does not qualify as such. The main reason
> why input device exist to do jack sensing right now appears to be that
> there was no other infrastructure readily available for it. But that is
> a poor excuse, which might be acceptable early in the game where things
> aren't really clear yet but not for the long run. On top of that there
> actually always has been a more appropriate place for signalling audio
> jack sensing events: the alsa control layer. Because that is what Jack
> sensing ultimately is: audio control. And if you have it in audio
> control this has many benefits: for example it's in the same namespace
> as the other audio controls (a very weakly defined namespace, but still
> the same namespace), so you could by employing some rules match up mute
> and volume controls with their matching jacks.
> 
> On top of that Takashi has patches ready to port HDA over to jack
> sensing via control devices, and hence I believe this is definitely the
> way to go.
> 
> Jack sensing for video plugs should similarly be handled by the video
> layer -- and actually is handled like that for VGA hotplug already.
> 
> HDMI is a composite technology, but I don't think this should be used as
> excuse to implement jack sensing via an independent subsystem. If it is
> composite it should simply use the native sensing interfaces for its
> technologies, i.e. send plug notifications via both video and audio
> control, the way they want.

For composite devices such as HDMI, with audio and video "sub ports",
user space needs to know which audio port and which video port are the
same physical port. For example, when displaying UI to select an audio
output device, this information is needed to display an X display ID,
monitor name, etc. as an option, which is much more informative to a
user than some random GPU's ALSA PCM device name/number.

It seems like this correlation would be easier to represent with a
single unified jack model, with "sub ports" on each jack for audio,
video, etc.

However, if the jack information is pushed into separate APIs, can they
please at least have some unified naming for the physical ports, so that
user-space can determine which audio jacks are the same as which video
jacks etc.

Thanks!

-- 
nvpublic
