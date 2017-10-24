From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] ALSA: wavefront: Convert timers to use
	timer_setup()
Date: Tue, 24 Oct 2017 13:08:54 -0700
Message-ID: <CAGXu5jKf6s6OemAbvDXHFi6dRTM+UDjPCothMXjcE+qkOQxfmw@mail.gmail.com>
References: <20171024153509.GA112907@beast> <s5hr2tspcjs.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f196.google.com (mail-io0-f196.google.com
 [209.85.223.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 5CF2D266DB1
 for <alsa-devel@alsa-project.org>; Tue, 24 Oct 2017 22:08:56 +0200 (CEST)
Received: by mail-io0-f196.google.com with SMTP id p186so25182277ioe.12
 for <alsa-devel@alsa-project.org>; Tue, 24 Oct 2017 13:08:56 -0700 (PDT)
In-Reply-To: <s5hr2tspcjs.wl-tiwai@suse.de>
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
Cc: moderated for non-subscribers <alsa-devel@alsa-project.org>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 24, 2017 at 12:32 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Tue, 24 Oct 2017 17:35:09 +0200,
> Kees Cook wrote:
>>
>> In preparation for unconditionally passing the struct timer_list pointer to
>> all timer callbacks, switch to using the new timer_setup() and from_timer()
>> to pass the timer pointer explicitly.
>>
>> Cc: Jaroslav Kysela <perex@perex.cz>
>> Cc: Takashi Iwai <tiwai@suse.com>
>> Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>> Cc: alsa-devel@alsa-project.org
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Thanks, applied.
>
> I guess we may deduce the card pointer from substream_output[], but
> this approach will be simpler in the end.

Yeah, I looked at that as an option, and I couldn't tell if the
lifetime might change out from under the timer, so I opted for an
explicit pointer since that's no worse than what the old struct
timer_list did anyway. :)

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
