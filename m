From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: using ALSA one call
Date: Wed, 11 Feb 2009 09:55:00 +0100
Message-ID: <49929264.1060503@ladisch.de>
References: <1234269014.49917356f0157@mail.inbox.lv>	<49919765.4000706@ladisch.de>
	<1234306055.499204078ce73@mail.inbox.lv>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 40BAC10388C
	for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2009 09:55:08 +0100 (CET)
In-Reply-To: <1234306055.499204078ce73@mail.inbox.lv>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alfs Kurmis <kallipygos@inbox.lv>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Alfs Kurmis wrote:
> As given here
> http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m.html#g6aa164ed37308d66bcc079f5cd265a09
> latency         required overall latency in us (0 = optimum latency for players)
> i have try to set  optimum latency = 0;

That documentation is wrong; 0 is not allowed.  Just use 0.5 s, or some
larger value.

> But why i can not play my wave on notebook sound device "hw:0,0" ??

Because the "hw" device goes straight to the hardware and disallows
any conversion of sample rate/format.

Use "default", or something like "default:0" to select a specific card.

> snd_pcm_set_params(handle, SND_PCM_FORMAT_S16_LE, SND_PCM_ACCESS_RW_INTERLEAVED,
>                    channelz, samplerate ,  0, 500000)

... and setting soft_resample to 0 disallows resampling in any case.


HTH
Clemens
