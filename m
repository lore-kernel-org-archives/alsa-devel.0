From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd-bebob and PrismSound Orpheus fails
	with	snd_pcm_hw_params_set_channels
Date: Thu, 23 Apr 2015 14:22:30 +0200
Message-ID: <5538E406.9060407@ladisch.de>
References: <CAJ0eYfU2GbYMZe=RpEecA15OBcVGt=q2xchykrCXLUZcf=886g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 01F7E2619FB
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2015 14:22:32 +0200 (CEST)
In-Reply-To: <CAJ0eYfU2GbYMZe=RpEecA15OBcVGt=q2xchykrCXLUZcf=886g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mike Ood <jh1ood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mike Ood wrote:
> % aplay -D hw:2,0 --channels=2 test.wav

You are trying to play a two-channel file ...

> % cat /proc/asound/card2/firewire/formation
> Output Stream from device:
> Rate PCM MIDI
> 44100 10 1

... on a device that supports only ten channels.

An with "hw", you have disabled any automatic format conversion.

Try "plughw:2" or "default:2".


Regards,
Clemens
