From: Stephen Warren <swarren@nvidia.com>
Subject: Re: Jack event API - decision needed
Date: Thu, 23 Jun 2011 08:32:57 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF049D2EBD5A@HQMAIL01.nvidia.com>
References: <4DFF973A.1080404@canonical.com>
	<20110620234053.GA1905@opensource.wolfsonmicro.com>
	<4E008A63.5080403@canonical.com>
	<20110621123908.GA25980@opensource.wolfsonmicro.com>
	<4E01C847.7060505@canonical.com>
	<20110622114826.GD18726@opensource.wolfsonmicro.com>
	<BANLkTikGd+3_=JA5rEkpH0iNGkashgT7DQ@mail.gmail.com>
	<20110622132518.GB21802@opensource.wolfsonmicro.com>
	<20110622210131.GA6861@tango.0pointer.de>
	<20110623011045.GB20949@opensource.wolfsonmicro.com>
	<20110623094925.GB25686@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 1507424491
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jun 2011 17:33:09 +0200 (CEST)
In-Reply-To: <20110623094925.GB25686@tango.0pointer.de>
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

Lennart Poettering wrote at Thursday, June 23, 2011 3:49 AM:
> On Thu, 23.06.11 02:10, Mark Brown (broonie@opensource.wolfsonmicro.com) wrote:
> I can give you a thousand of real-life usecases for wanting to match up
> PCM devices with controls, but the one for wanting to match up HDMI
> audio with HDMI video is much weaker, since machines usually have
> multiple PCM streams, but not multiple HDMI ports.

As an example, all NVIDIA GPUs, and some chipsets, built within the last
perhaps 2 or 3 years contain an HD-audio controller with 4 PCM devices.
Any/all of these could be routed out to actual connectors on the board.
For audio purposes, HDMI, DVI (connected to an HDMI sink), and DisplayPort
connectors all can carry audio and end up being exposed identically by
ALSA. In practice, it's very common to have at least 2 such digital
connectors on a GPU.

I believe both Intel and AMD/ATI chipsets and GPUs that support audio
are in exactly the same boat, although perhaps only supporting up to
2 or 3 PCMs total?

> I am not saying that such a match-up shouldn't be possible, but I'd say
> it could be relatively easy to implement. One option would be to go by
> names. i.e. simply say that if an alsa control device is called "HDMI1
> Jack Sensing", and an X11 XRANDR port is called "HDMI1", then they
> should be the same, and apps should comapre the first words of these
> names, and that both can be traced to the same udev originating device.

It'll be challenging to implement this based on device name alone. The
X driver probably has enough information to know the difference between
DVI, HDMI, and DP ports and hence could name ports appropriately.
However, the generic HD-audio HDMI driver has basically zero knowledge
of which HDA pin complexes are routed to connectors at all, or for those
that are, whether they're routed to DVI, HDMI, or DP ports, and equally
no idea what port number X might choose if there are say 2 DVI ports.

(well, HDMI vs. DP is pin complex property, but HDMI vs. DVI certainly
isn't, and numbering order when there are n HDMI pins isn't defined, and
only very recent NVIDIA GPUs mark unconnected pin complexes)

This is what I attempted to start talking about in my somewhat recent
email titled " EDID-like data for audio: Port correlation between	ALSA
and X"; see:

http://mailman.alsa-project.org/pipermail/alsa-devel/2011-May/040186.html

The basic idea: This X vs. ALSA correlation is probably going to be
through ELD data, at least internally to the kernel.

-- 
nvpublic
