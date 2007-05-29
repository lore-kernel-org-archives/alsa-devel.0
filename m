From: Jan Kara <jack@suse.cz>
Subject: Re: [1/4] 2.6.22-rc3: known regressions
Date: Tue, 29 May 2007 16:34:59 +0200
Message-ID: <20070529143459.GE25278@duck.suse.cz>
References: <465C2225.2000100@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761840AbXE2OX3@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <465C2225.2000100@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Ingo Molnar <mingo@elte.hu>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Thierry Volpiatto <tvolpiatt@neuf.fr>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, Ben Collins <bcollins@ubuntu.com>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, Florin Iucha <florin@iucha.net>, Sam Ravnborg <sam@ravnborg.org>, Andrey Borzenkov <arvidjaar@mail.ru>
List-Id: alsa-devel@alsa-project.org

  Hi,

On Tue 29-05-07 14:52:53, Michal Piotrowski wrote:
> Here is a list of some known regressions in 2.6.22-rc3.
> 
> Feel free to add new regressions/remove fixed etc.
> http://kernelnewbies.org/known_regressions
> 
  <snip>
> File systems
> 
> Subject    : Oops in dentry_iput with 2.6.22-rc2 on AMD64
> References : http://lkml.org/lkml/2007/5/22/4
> Submitter  : Florin Iucha <florin@iucha.net>
> Status     : Unknown
  Actually, the bug seems to be unreproducible and it has probably been a
1-bit flip. So I'd be reluctant to call it a regression...

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
