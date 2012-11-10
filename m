From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Non-blocking snd_pcm_drain?
Date: Sat, 10 Nov 2012 18:28:45 +0100
Message-ID: <509E8ECD.7080205@ladisch.de>
References: <CAHU0+dREbMHoAKOHgPpHfEO+kr93d1FmtrrQ6-nXUN3=7MqGxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 75CD7261614
 for <alsa-devel@alsa-project.org>; Sat, 10 Nov 2012 18:29:02 +0100 (CET)
In-Reply-To: <CAHU0+dREbMHoAKOHgPpHfEO+kr93d1FmtrrQ6-nXUN3=7MqGxw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Sanz <daniellsanz2@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Daniel Sanz wrote:
> I noticed that the snd_pcm_drain call blocks until the buffer is
> completely drained. Is there any way to drain the buffer without
> a block?

Try calling snd_pcm_nonblock(handle, 1).

> I've tried calling snd_pcm_nonblock(handle, 1) before the call to
> snd_pcm_drain but it does not work.

How so?

> The context is that this is an application that plays a particular WAV
> sound repeatedly, so I don't want to wait until the sound is played
> completely before it is played again.

Then why do you drain at all?  Just write the new data into the buffer.


Regards,
Clemens
