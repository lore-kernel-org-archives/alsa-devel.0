From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: HDA: no sound [was: mmotm 2010-10-20-15-01
	uploaded]
Date: Thu, 21 Oct 2010 19:59:27 +0200
Message-ID: <4CC07F7F.5050608@gmail.com>
References: <201010202233.o9KMXNoL008303@imap1.linux-foundation.org>
	<4CBFEE94.7020103@gmail.com> <s5hlj5sc7do.wl%tiwai@suse.de>
	<4CBFF25C.2080908@gmail.com> <13987.1287674569@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) by alsa0.perex.cz (Postfix) with ESMTP id 56F7E243FE
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Oct 2010 19:59:36 +0200 (CEST)
Received: by qwd7 with SMTP id 7so3890368qwd.38
	for <alsa-devel@alsa-project.org>; Thu, 21 Oct 2010 10:59:34 -0700 (PDT)
In-Reply-To: <13987.1287674569@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Valdis.Kletnieks@vt.edu
Cc: alsa-devel@alsa-project.org, mm-commits@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, clemens@ladisch.de, linux-kernel@vger.kernel.org, akpm@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

On 10/21/2010 05:22 PM, Valdis.Kletnieks@vt.edu wrote:
> Didn't we have some flustercluck a while back that gave pulseaudio
> similar indigestion?  Oh, here it is, it was an fsnotify botch, of all things.
> 
> commit 2069601b3f0ea38170d4b509b89f3ca0a373bdc1
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Thu Aug 12 14:23:04 2010 -0700
> 
>     Revert "fsnotify: store struct file not struct path"

Yes, I was attacked by that in the past, but I doubt that's it now.
Pulse was unable to start -- the second open of the snd device failed
which doesn't seem to happen now.

Going to switch hda intel from Y to M and play with that (revert the
patches at first).

regards,
-- 
js
