From: "Jeff Chua" <jeff.chua.linux@gmail.com>
Subject: Re: [1/3] 2.6.22-rc3: known regressions v2
Date: Fri, 1 Jun 2007 21:28:41 +0800
Message-ID: <b6a2187b0706010628m3d9ffad5y9a76e22719f439b7@mail.gmail.com>
References: <46600F1C.5000302@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.227])
	by alsa0.perex.cz (Postfix) with ESMTP id E2181246B3
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Jun 2007 15:28:42 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id j2so483310nzf
	for <alsa-devel@alsa-project.org>; Fri, 01 Jun 2007 06:28:42 -0700 (PDT)
In-Reply-To: <46600F1C.5000302@googlemail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: alsa-devel@alsa-project.org, Ben Collins <bcollins@ubuntu.com>, Miklos Szeredi <miklos@szeredi.hu>, Takashi Iwai <tiwai@suse.de>, =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>, linux-wireless@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Maximilian Engelhardt <maxi@daemonizer.de>, Jaroslav Kysela <perex@suse.cz>, Michael Buesch <mb@bu3sch.de>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Thierry Volpiatto <tvolpiatt@neuf.fr>, Len Brown <lenb@kernel.org>
List-Id: alsa-devel@alsa-project.org

Can you please add this ...

Got this only after "recompile". "make clean" will make the warnings go awa=
y.

 SYSMAP  System.map
 SYSMAP  .tmp_System.map
 MODPOST vmlinux
WARNING: arch/i386/kernel/built-in.o(.text+0xa677): Section mismatch:
reference to .init.text: (between 'init_intel_cacheinfo' and
'cache_shared_cpu_map_setup')
WARNING: arch/i386/kernel/built-in.o(.text+0xb8c0): Section mismatch:
reference to .init.text: (between 'mtrr_bp_init' and 'mtrr_ap_init')
WARNING: arch/i386/kernel/built-in.o(.text+0xba79): Section mismatch:
reference to .init.text: (between 'mtrr_bp_init' and 'mtrr_ap_init')
WARNING: arch/i386/kernel/built-in.o(.text+0xba7e): Section mismatch:
reference to .init.text: (between 'mtrr_bp_init' and 'mtrr_ap_init')
WARNING: arch/i386/kernel/built-in.o(.text+0xc4a0): Section mismatch:
reference to .init.text: (between 'get_mtrr_state' and 'mtrr_wrmsr')
WARNING: kernel/built-in.o(.text+0x17437): Section mismatch: reference
to .init.text: (between 'kthreadd' and 'init_waitqueue_head')
 AS      arch/i386/boot/setup.o
 LD      arch/i386/boot/setup
 OBJCOPY arch/i386/boot/compressed/vmlinux.bin


Thanks,
Jeff.

On 6/1/07, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> Hi all,
>
> Here is a list of some known regressions in 2.6.22-rc3.
>
> Feel free to add new regressions/remove fixed etc.
> http://kernelnewbies.org/known_regressions
>
>
>
> Unclassified
>
> Subject    : build failed in function `vic_sys_interrupt'
> References : http://lkml.org/lkml/2007/5/31/227
> Submitter  : Toralf F=F6rster <toralf.foerster@gmx.de>
> Status     : Unknown
>
> Subject    : long freezes on thinkpad t60
> References : http://lkml.org/lkml/2007/5/24/100
> Submitter  : Miklos Szeredi <miklos@szeredi.hu>
> Handled-By : Ingo Molnar <mingo@elte.hu>
> Status     : problem is being debugged
>
>
>
> ACPI
>
> Subject    : unable to shutdown on kernel 2.6.22-rc2
> References : http://bugzilla.kernel.org/show_bug.cgi?id=3D8516
> Submitter  : Thierry Volpiatto <tvolpiatt@neuf.fr>
> Status     : Unknown
>
>
>
> ALSA
>
> Subject    : snd-aoa causes badness in lib/kref.c:33
> References : http://bugzilla.kernel.org/show_bug.cgi?id=3D8513
> Submitter  : Ben Collins <bcollins@ubuntu.com>
> Status     : Unknown
>
>
>
> Networking
>
> Subject    : b44: regression in 2.6.22
> References : http://lkml.org/lkml/2007/5/27/108
> Submitter  : Maximilian Engelhardt <maxi@daemonizer.de>
> Handled-By : Michael Buesch <mb@bu3sch.de>
> Status     : problem is being debugged
>
>
>
> Regards,
> Michal
>
> --
> "Najbardziej brakowa=B3o mi twojego milczenia."
> -- Andrzej Sapkowski "Co=B6 wi=EAcej"
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
