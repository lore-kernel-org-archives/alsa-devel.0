From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: OSS app works but aplay does not with
 SNDRV_PCM_FMTBIT_U32_LE
Date: Wed, 19 Sep 2007 08:46:17 +0200
Message-ID: <1190184377.23573.1211414421@webmail.messagingengine.com>
References: <0MKpCa-1IXhxr0egN-0007WC@mrelay.perfora.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id E9EF024444
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Sep 2007 08:46:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <0MKpCa-1IXhxr0egN-0007WC@mrelay.perfora.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Steve Strobel <steve.strobel@link-comm.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Steve Strobel wrote:
> If I set up the snd_pcm_hardware_t structure with
> 
>    .formats =          SNDRV_PCM_FMTBIT_U32_LE,
> 
> the OSS test application sends a nice sine wave, but aplay fails with 
> the following messages:
> 
> root:~> aplay < /dev/urandom
> ALSA sound/blackfin/ad1836.c:1050: snd_ad1836_playback_open
> Playing raw data 'stdin' : Unsigned 8 bit, Rate 8000 Hz, Mono
> snd_pcm_hw_refine()
> ACCESS = 00000000ffffffffffffffff -> 0000000000000008
> FORMAT = 0000000000000400 -> 0000000000000000

aplay tries to set S32_LE, but the driver doesn't accept it.

Where does this S32_LE come from?  Did you set up some devices in
~/.asoundrc or /etc/asound.conf, or did you create a card-specific .conf
file for your controller?  (I would guess that the "default" device is
set up to use dmix.)


Regards,
Clemens
