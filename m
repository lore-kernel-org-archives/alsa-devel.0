From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd-fireworks requires larger period sizes than
	FFADO
Date: Mon, 23 Nov 2015 11:40:56 +0100
Message-ID: <5652ED38.6080409@ladisch.de>
References: <56510A5F.4080004@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 74DCC265205
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2015 11:40:57 +0100 (CET)
In-Reply-To: <56510A5F.4080004@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?Q?Dominic_Sacr=c3=a9?= <dominic.sacre@gmx.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dominic Sacr=E9 wrote:
> I'm trying to use an Echo AudioFire 4 with the snd-fireworks driver.
> With FFADO the device works reasonably well at a period size of
> 64 samples (on a PREEMPT_RT kernel), whereas with snd-fireworks the
> lowest possible period size seems to be 256 samples.
>
> The lowest achievable analog roundtrip latency seems to be around 19ms
> (at 2x256 frames), as opposed to 8.3ms with FFADO (at 2x64). Are there
> any known limitations of the snd-fireworks driver in this regard?

At the moment, the driver uses a minimum period size of 5 ms.

You could try reducing INTERRUPT_INTERVAL and the parameter to
snd_pcm_hw_constraint_minmax() in sound/firewire/amdtp-stream.c, and
recompiling the driver.


Regards,
Clemens
