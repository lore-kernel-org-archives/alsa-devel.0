From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: [RFC] Echoaudio driver
Date: Thu, 23 Sep 2004 10:22:31 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20040923102231.pochini@shiny.it>
References: <s5h6566zhlq.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h6566zhlq.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 22-Sep-2004 Takashi Iwai wrote:
> Hi,
>
> sorry I've overseen this post.

No problems, it's not urgent... and I was busy debugging
that sync-drain problem.


> I'd suggest either to ask Echo about the permission for BSD/GPL dual
> license or to rewrite the BSD part.  Above all, the generic wrapper
> is hated by kernel developers, so we'll need to rewrite them later
> anyway.  So, I'd prefer rewriting them.

The overall structure of the driver is about the same of the
au88x0 driver (I took it as model). Some functions are indeed
too ugly (eg. the enumerated controls) and I already planned to
change them. But I don't like the idea of including lowlevel
functions inside the control and pcm functions because they
would become overly big and ugly. If you're talking about the
*eg thing, well, it's not a problem at all moving the EchoGals
structure inside chip_t and passing it to the lowlevel
functions in place of &eg just like au88x0 does. That would
also allow some cleanup and maybe tighter locking.


>> - Userspace firmware loading is still missing.
>
> The problem is similar, the license of this firmware is unclear.
> Let's push it to user-space.  You can replace it easily with
> request_firmware() (although it's for 2.6 kernels only).

I don't thing the licence is a big problem: the people at
Echoaudio are very friendly. I'll contact them.


>> - Coding style: yes, I'll replace all C++ comments :)
>
> Comments are relatively accepted, but the C++ style variables
> and functions are disliked by many people...

Ok.


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
