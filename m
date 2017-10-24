From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] sound: oss: waveartist: Convert timers to
	use timer_setup()
Date: Tue, 24 Oct 2017 13:07:34 -0700
Message-ID: <CAGXu5jLBDjeNs=yP76yhLvZXd2v3hH66K1QuMp5+LkCrQ+pW8w@mail.gmail.com>
References: <20171024153521.GA112921@beast> <s5hshe8pcub.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f193.google.com (mail-io0-f193.google.com
 [209.85.223.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 201CE266DB1
 for <alsa-devel@alsa-project.org>; Tue, 24 Oct 2017 22:07:37 +0200 (CEST)
Received: by mail-io0-f193.google.com with SMTP id 97so25204274iok.7
 for <alsa-devel@alsa-project.org>; Tue, 24 Oct 2017 13:07:37 -0700 (PDT)
In-Reply-To: <s5hshe8pcub.wl-tiwai@suse.de>
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
Cc: David Howells <dhowells@redhat.com>, moderated for non-subscribers <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 24, 2017 at 12:25 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Tue, 24 Oct 2017 17:35:21 +0200,
> Kees Cook wrote:
>>
>> In preparation for unconditionally passing the struct timer_list pointer to
>> all timer callbacks, switch to using the new timer_setup() and from_timer()
>> to pass the timer pointer explicitly.
>>
>> Cc: Jaroslav Kysela <perex@perex.cz>
>> Cc: Takashi Iwai <tiwai@suse.com>
>> Cc: David Howells <dhowells@redhat.com>
>> Cc: alsa-devel@alsa-project.org
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>
> I'll skip this as sound/oss/* is already disabled in recent kernels in
> kbuild, and we're going to remove the whole code soon later.

At the end of these conversions, the old init_timer() and
setup_timer() APIs will be removed, which would break anything still
trying to use it (obviously). But if sound/oss/* is _already_
unbuildable, then sure, this is fine by me to leave out. :)

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
