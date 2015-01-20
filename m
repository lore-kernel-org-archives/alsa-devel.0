From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH 00/17] More line6 driver code reorg and
	cleanups
Date: Tue, 20 Jan 2015 00:24:24 -0600
Message-ID: <CAEUsAPZPBTjpnGBPdC-enxM9G17mkmEdHinb1a4CoGQZ7qvW-w@mail.gmail.com>
References: <1421682891-11594-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f52.google.com (mail-qa0-f52.google.com
 [209.85.216.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 072672606A6
 for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2015 07:24:26 +0100 (CET)
Received: by mail-qa0-f52.google.com with SMTP id x12so26809931qac.11
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 22:24:25 -0800 (PST)
In-Reply-To: <1421682891-11594-1-git-send-email-tiwai@suse.de>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 19, 2015 at 9:54 AM, Takashi Iwai <tiwai@suse.de> wrote:
> The current merged code is found in topic/line6 branch of sound.git
> tree while this development code is found in test/line6 branch.
> The devel branch hasn't been merged to linux-next yet, I'm waiting
> for any good/bad test results.  So, give me any feedback.  Thanks!

Looks good to me.  I tried it out briefly with a TonePort UX2 without
issue.

Tested-by: Chris Rorvick <chris@rorvick.com>

> (BTW, the next step would be to straighten the init code in pod.c,
>  etc instead of (ab)using the system timer.  Instead, it should be
>  a flat function with wait_event() of such.)

Are you planning on doing this?  Otherwise I can probably poke at it
this week.

Thanks!

Chris
