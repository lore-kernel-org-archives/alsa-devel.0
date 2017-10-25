From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] sound: oss: waveartist: Convert timers to
	use timer_setup()
Date: Wed, 25 Oct 2017 03:17:25 -0700
Message-ID: <CAGXu5j+eGu3gi6yhsZ7FbEK5CKvf_UAthzutaa4k+qB4bJ1Ppw@mail.gmail.com>
References: <20171024153521.GA112921@beast> <s5hshe8pcub.wl-tiwai@suse.de>
 <CAGXu5jLBDjeNs=yP76yhLvZXd2v3hH66K1QuMp5+LkCrQ+pW8w@mail.gmail.com>
 <s5hpo9bo837.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f68.google.com (mail-it0-f68.google.com
 [209.85.214.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 5977026741F
 for <alsa-devel@alsa-project.org>; Wed, 25 Oct 2017 12:17:29 +0200 (CEST)
Received: by mail-it0-f68.google.com with SMTP id f187so440467itb.1
 for <alsa-devel@alsa-project.org>; Wed, 25 Oct 2017 03:17:28 -0700 (PDT)
In-Reply-To: <s5hpo9bo837.wl-tiwai@suse.de>
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

On Wed, Oct 25, 2017 at 3:06 AM, Takashi Iwai <tiwai@suse.de> wrote:
> On Tue, 24 Oct 2017 22:07:34 +0200,
> Kees Cook wrote:
>>
>> On Tue, Oct 24, 2017 at 12:25 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> > On Tue, 24 Oct 2017 17:35:21 +0200,
>> > Kees Cook wrote:
>> >>
>> >> In preparation for unconditionally passing the struct timer_list pointer to
>> >> all timer callbacks, switch to using the new timer_setup() and from_timer()
>> >> to pass the timer pointer explicitly.
>> >>
>> >> Cc: Jaroslav Kysela <perex@perex.cz>
>> >> Cc: Takashi Iwai <tiwai@suse.com>
>> >> Cc: David Howells <dhowells@redhat.com>
>> >> Cc: alsa-devel@alsa-project.org
>> >> Signed-off-by: Kees Cook <keescook@chromium.org>
>> >
>> > I'll skip this as sound/oss/* is already disabled in recent kernels in
>> > kbuild, and we're going to remove the whole code soon later.
>>
>> At the end of these conversions, the old init_timer() and
>> setup_timer() APIs will be removed, which would break anything still
>> trying to use it (obviously). But if sound/oss/* is _already_
>> unbuildable, then sure, this is fine by me to leave out. :)
>
> I see a few still remaining users of setup_timer() in sound/*.
> Do you already have conversion patches?  They are all trivial, so I
> can cook up in minutes, too.

I haven't sent the trivial ones (since I am expecting to do a treewide
mechanical change for those). I can send you the rest as a patch
instead, if you want?

-Kees

-- 
Kees Cook
Pixel Security
