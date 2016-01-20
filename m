From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Use of snd_pcm_format_set_silence
Date: Wed, 20 Jan 2016 22:56:50 +0100
Message-ID: <56A002A2.5070200@ladisch.de>
References: <CACaQK7C04jg3nP-7ijntq+ADEdO41+Ab1VpRDS1vwFXWAPPTHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 4BC8F260439
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2016 22:57:58 +0100 (CET)
In-Reply-To: <CACaQK7C04jg3nP-7ijntq+ADEdO41+Ab1VpRDS1vwFXWAPPTHg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ankhit Vivekananda <ankhit.vivekananda@biscotti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ankhit Vivekananda wrote:
> I have an application where in I need to silence the first few samples of
> the buffer that is read from snd_pcm_readi(). In order to do this, I call
> the snd_pcm_format_set_silence() providing the same buffer that the
> snd_pcm_readi() reads to.
>
> 1) By doing this, is there going to be a timing delay due to the use of
> snd_pcm_format_set_silence()?

That function just modifies memory; it does not affect any PCM device.

> 2) Is snd_pcm_format_set_silence() the correct function to achieve this
> goal or are there better methods?

You already know your sample format; memset(0) might be simpler.


Regards,
Clemens
