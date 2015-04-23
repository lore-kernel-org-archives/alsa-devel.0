From: Mike Ood <jh1ood@gmail.com>
Subject: Re: snd-bebob and PrismSound Orpheus fails with
	snd_pcm_hw_params_set_channels
Date: Thu, 23 Apr 2015 21:45:07 +0900
Message-ID: <CAJ0eYfWMxiD1HhfD_UC48FGiNfrPdtYPyc7MzVhByde-W4FSqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vn0-f43.google.com (mail-vn0-f43.google.com
 [209.85.216.43])
 by alsa0.perex.cz (Postfix) with ESMTP id AC9082615F7
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2015 14:45:08 +0200 (CEST)
Received: by vnbg62 with SMTP id g62so1136227vnb.6
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2015 05:45:07 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens wrote:

> You are trying to play a two-channel file ...
> ... on a device that supports only ten channels.

This is what I was vaguely afraid of...

> An with "hw", you have disabled any automatic format conversion.
> Try "plughw:2" or "default:2".

Could you be kind enough to suggest how I should write .asoundrc?

I only know the obvious one for jack:

.asoundrc
----------------
pcm.jackplug {
type plug
slave { pcm "jack" }
}

pcm.jack {
type jack
playback_ports {
0 alsa_pcm:playback_1
1 alsa_pcm:playback_2
}
capture_ports {
0 alsa_pcm:capture_1
1 alsa_pcm:capture_2
}
}
----------------

Regards,
Mike Ood
