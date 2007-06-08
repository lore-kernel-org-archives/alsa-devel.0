From: Timur Tabi <timur@freescale.com>
Subject: Re: [ASoC] machine driver and channel configuration
Date: Fri, 08 Jun 2007 10:31:35 -0500
Message-ID: <46697657.2000302@freescale.com>
References: <loom.20070608T161908-148@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 145602433E
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Jun 2007 17:31:38 +0200 (CEST)
In-Reply-To: <loom.20070608T161908-148@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Matthieu CASTET <matthieu.castet@parrot.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Matthieu CASTET wrote:
> Hi,
> 
> If the platform/cpu_dai driver and codec support capture and playback channels.
> But on the board only the playback link is connected.
> 
> In this configuration, the codec and platform/cpu_dai driver shouldn't try to
> use the capture path (and the resource associated to this).
> 
> 
> Is there a way to do something like that ?

I'm just learning about ASoC myself, but using wm8731.c as an example, wouldn't this work:

struct snd_soc_codec_dai wm8731_dai = {
	.name = "WM8731",
	.playback = {
		.stream_name = "Playback",
		.channels_min = 1,
		.channels_max = 2,
		.rates = WM8731_RATES,
		.formats = WM8731_FORMATS,},
	.capture = {
		.stream_name = "Capture",
		.channels_min = 1,
		.channels_max = 2,
		.rates = WM8731_RATES,
		.formats = WM8731_FORMATS,},

Just change capture.channels_min and channels_max to 0.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
