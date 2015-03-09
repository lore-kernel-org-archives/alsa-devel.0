From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Using loopback card to Connect GSM two way call	to
	the real sound card UDA1345TS
Date: Mon, 09 Mar 2015 09:09:16 +0100
Message-ID: <54FD552C.7020902@ladisch.de>
References: <1425878251963.1340@tataelxsi.co.in>
 <1425878360800.70892@tataelxsi.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 1A19C2605A4
 for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2015 09:09:20 +0100 (CET)
In-Reply-To: <1425878360800.70892@tataelxsi.co.in>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivasan S <srinivasan.s@tataelxsi.co.in>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-audio-dev@lists.linuxaudio.org" <linux-audio-dev@lists.linuxaudio.org>
List-Id: alsa-devel@alsa-project.org

Srinivasan S wrote:
> Could you please provide any inputs w.r.t the loopback card using
> snd-aloop & alsaloop, how this loopback card can be used to connect
> the GSM two way call simultanoeusly to the UDA1345TS codec on MCASP0
> of the am335x (UDA1345TS ie., real sound card)

snd-aloop creates a virtual sound card; it is not used with a real sound
card.

> The codec has two output channels VOUTL, VOUTR & two input channels VINL , VINR
>
> With this am able to achieve only one way call at a time by running
> only one application at a time

To allow a capture device to be shared, you need to use dsnoop.  Your
asound.conf already does this.

To allow a playback device to be shared, you need to use dshare or dmix.
(dshare allows to use _different_ channels; dmix allows mixing multiple
sources into the same channels.)  Your asound.conf does not do this; it
uses "hw" instead.


Regards,
Clemens
