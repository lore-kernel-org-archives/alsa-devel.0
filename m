From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: aplay appication failed to open the alsa device
Date: Wed, 24 Oct 2007 08:24:07 +0200
Message-ID: <1193207047.11987.1217520753@webmail.messagingengine.com>
References: <1193200898.2827.18.camel@tharma.e-con>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id E165B24B26
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Oct 2007 08:24:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1193200898.2827.18.camel@tharma.e-con>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tharma@e-consystems.com, alsa-devel@alsa-project.org
Cc: maharajan <maharajan@e-consystems.com>
List-Id: alsa-devel@alsa-project.org

Tharmarajan G wrote:
> 	I have built the kernel image with ALSA audio support and the
> applications aplay and arecord for playing and recording audio data
> using ALSA api.
> 
> 	I have got the alsa related entries in the /proc filesystem . But when
> playing the aplay, it failed to open the device.
> 
> [root@SIRIUS /flash2]#./aplay /usr/local/Songs/AjRaj-Anthimanthirai-Theme4.mp3
> ALSA lib pcm.c:2144:(snd_pcm_open_noupdate) Unknown PCM default

Apparently, alsa-lib's .conf files are not installed in /usr/share/alsa/.


HTH
Clemens
