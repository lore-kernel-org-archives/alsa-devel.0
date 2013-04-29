From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: Missing patches for 3.10 merge?
Date: Mon, 29 Apr 2013 13:33:42 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1304291328310.1377@xoschi>
References: <s5hhaip1zfz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f49.google.com (mail-bk0-f49.google.com
 [209.85.214.49])
 by alsa0.perex.cz (Postfix) with ESMTP id C83C42619FD
 for <alsa-devel@alsa-project.org>; Mon, 29 Apr 2013 13:33:46 +0200 (CEST)
Received: by mail-bk0-f49.google.com with SMTP id w5so2670332bku.36
 for <alsa-devel@alsa-project.org>; Mon, 29 Apr 2013 04:33:46 -0700 (PDT)
In-Reply-To: <s5hhaip1zfz.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On Mon, 29 Apr 2013, Takashi Iwai wrote:

> Hi,
> 
> if anyone posted fix patches that should be applied to 3.10, but still
> unapplied, please let me know ASAP.
> 
> I got a complete home (and system) FS crash on Friday (due to too much
> experiment with btrfs) and might have lost some incoming mails.

FWIW, I posted the pcm_format_to_bits patch, but there's no 
functional change in it:

   http://mailman.alsa-project.org/pipermail/alsa-devel/2013-April/061451.html

There's also this small fix: 

   http://mailman.alsa-project.org/pipermail/alsa-devel/2013-April/061452.html

Cheers,
Eldad
