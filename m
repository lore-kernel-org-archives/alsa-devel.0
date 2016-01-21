From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Use of snd_pcm_format_set_silence
Date: Thu, 21 Jan 2016 08:43:11 +0100
Message-ID: <56A08C0F.8070902@ladisch.de>
References: <CACaQK7C04jg3nP-7ijntq+ADEdO41+Ab1VpRDS1vwFXWAPPTHg@mail.gmail.com>
 <56A002A2.5070200@ladisch.de>
 <CACaQK7ARzW=LJ3Xo5=Qyh42uyR96Pbo_SFGOfCh3j6ZozobjcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 02CE32604EF
 for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2016 08:43:13 +0100 (CET)
In-Reply-To: <CACaQK7ARzW=LJ3Xo5=Qyh42uyR96Pbo_SFGOfCh3j6ZozobjcA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ankhit Vivekananda <ankhit.vivekananda@biscotti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ankhit Vivekananda wrote:
> the snd_pcm_format_set_silence() would simply /replace/ the actual
> buffer read from snd_pcm_readi() to zeros(since my application is
> using signed 32 bit little endian format).

Yes.

> There would be no delay induced in doing so.

Yes; this function does not block.


Regards,
Clemens
