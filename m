From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: PXA2xx i2Sound: support for PXA2xx I2S audio
Date: Fri, 04 Nov 2005 11:49:34 +0000
Message-ID: <1131104974.10911.41.camel@cearnarfon>
References: <200511041152.22570.giorgio@mandarinlogiq.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200511041152.22570.giorgio@mandarinlogiq.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giorgio Padrin <giorgio@mandarinlogiq.org>
Cc: alsa-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-11-04 at 11:52 +0100, Giorgio Padrin wrote:

> I wish to know whether there are other similar works in development.

Yes there is. Richard Purdie and I have been working on an ALSA SoC
audio layer. It's designed to make audio codec drivers SoC processor
independent and provide dynamic power management for each codec.

Currently, we only have support for the pxa2xx platform on the Mainstone
and corgi machines (more are in progress). SoC supports all 3 pxa audio
interfaces (i.e. AC97, I2S and SSP) and can support them in both master
and slave modes. 

I do plan to add support for more platforms and machines in the near
future. I'll be working on iMX (mx21) and AMD Alchemy as I have both
boards available.

SoC currently has support for the following codecs:-

 o WM8753
 o WM8731
 o WM8750
 o WM8971
 o All AC97 codecs (that are supported by ac97_codec.c)
 o WM9713 voice interface

SoC also provides dynamic power management (dpm) to reduce the power
used by the codec to the minimum at all times.  dpm works by powering
(up/down) the codecs internal system blocks depending on it's usage and
internal audio routing. This is all done by the SoC layer and is
transparent to any audio application.

I'm planning to send a more detailed announcement to alsa dev next
week. 

The current development release of ALSA SoC is currently available from
http://www.rpsys.net/openzaurus/patches/alsa/alsa_soc_0.5-r0.patch
 

Liam



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
