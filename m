From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: Audio on mx6q udoo
Date: Thu, 06 Oct 2016 16:48:47 +0200
Message-ID: <57F6644F.3070500@maciej.szmigiero.name>
References: <CAOMZO5DdwgYBbOG7sik-Wc34zEqfttOc3EZwsisFgzwtcbDPNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id 307AF26646C
 for <alsa-devel@alsa-project.org>; Thu,  6 Oct 2016 16:48:48 +0200 (CEST)
In-Reply-To: <CAOMZO5DdwgYBbOG7sik-Wc34zEqfttOc3EZwsisFgzwtcbDPNA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Fabio,

On 05.10.2016 20:15, Fabio Estevam wrote:
> Hi Maciej,
> 
> I am running today's linux-next on a imx6q-udoo board.
> 
> Removed USB support to avoid the hang and also enabled
> CONFIG_SND_SOC_AC97_CODEC=y.
> 
> When I start a playback it seems to be running:
> 
> # aplay /root/clarinet.wav
> Playing WAVE '/root/clarinet.wav' : Signed 16 bit Little Endian, Rate 44100 Hz
> 
> ,but I don't get any sound out of the CN7 green jack.
> 
> I put the volumes at the maximum via alsamixer.
> 
> Any ideas?

I assume that you tested older kernel on this board and got proper output
there.

Even if you don't get any sound is playing time correct - that is
does for example 30 second file play for 30 seconds?
If not then it might be DMA or sampling rate setup problem.

Is the AC'97 codec model detected correctly
(/proc/asound/card0/codec97#0/ac97#0-0)?
If not then it might be some problem with accessing AC'97 regs
(like SSI clock not running).

You can also try to revert
http://www.spinics.net/lists/alsa-devel/msg54983.html to go back
to RB tree register cache, maybe this will help.

I have tried to run today's linux-next on my UDOO board but it crashes
at boot somewhere in imx6q_pm_pu_power_off(), so unfortunately can't
test it for now.

> Thanks,
> 
> Fabio Estevam

Maciej
