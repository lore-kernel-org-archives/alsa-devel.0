From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH 08/16] ALSA: line6: Drop superfluous
	spinlock for trigger
Date: Tue, 27 Jan 2015 06:48:22 -0600
Message-ID: <CAEUsAPaN+127mvZvYiFcKcVLSVoLaPWO_tCVDUX_7-ce7YadXw@mail.gmail.com>
References: <1422033203-23254-1-git-send-email-tiwai@suse.de>
 <1422033203-23254-9-git-send-email-tiwai@suse.de>
 <CAEUsAPYJcxq5eGhpZiy58USGwwxaohwjF+j0B0Qi=WRoectJeA@mail.gmail.com>
 <s5hh9vcikmi.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f43.google.com (mail-qa0-f43.google.com
 [209.85.216.43])
 by alsa0.perex.cz (Postfix) with ESMTP id D2BD6260715
 for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2015 13:48:23 +0100 (CET)
Received: by mail-qa0-f43.google.com with SMTP id v10so11147299qac.2
 for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2015 04:48:23 -0800 (PST)
In-Reply-To: <s5hh9vcikmi.wl-tiwai@suse.de>
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

On Tue, Jan 27, 2015 at 4:27 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 27 Jan 2015 00:22:48 -0600, Chris Rorvick wrote:
>> All of this looks racy to me.  Am I missing something?
>
> Yes, the code *is* already racy :)

OK, good to know I'm not seeing ghosts.  :-)

>> Sorry, this is way beyond the scope of this patch.  But I've been
>> spending some time trying to sort this out and haven't answered the
>> above questions.  If I'm missing anything, a pointer to the relevant
>> source would be greatly appreciated!
>
> HTH,

Yes, very much.  Thanks!

Regards,

Chris
