From: Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [Alsa-devel] alsa-driver will not compile with kernel
 2.6.9-rc2-mm4-S7
Date: Sat, 2 Oct 2004 13:47:32 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20041002134732.7c38d39e@mango.fruits.de>
References: <1096675930.27818.74.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262085AbUJBLcl@vger.kernel.org>
In-Reply-To: <1096675930.27818.74.camel@krustophenia.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
List-Id: alsa-devel@alsa-project.org

On Fri, 01 Oct 2004 20:12:10 -0400
Lee Revell <rlrevell@joe-job.com> wrote:

> At first I thought my build was incorrect, but I reproduced this error
> with a clean build and ALSA CVS from today:
> 
>   CC [M] 
>   /home/rlrevell/cvs/alsa/alsa-driver/kbuild/../acore/pcm_native.o
> /home/rlrevell/cvs/alsa/alsa-driver/acore/pcm_native.c:3202:57: macro
> "io_remap_page_range" requires 5 arguments, but only 4
> given/home/rlrevell/cvs/alsa/alsa-driver/acore/pcm_native.c: In
> function
> `snd_pcm_lib_mmap_iomem':/home/rlrevell/cvs/alsa/alsa-driver/acore/pc
> m_native.c:3200: error: `io_remap_page_range' undeclared (first use in
> this
> function)/home/rlrevell/cvs/alsa/alsa-driver/acore/pcm_native.c:3200:
> error: (Each undeclared identifier is reported only
> once/home/rlrevell/cvs/alsa/alsa-driver/acore/pcm_native.c:3200:
> error: for each function it appears in.) make[3]: ***
> [/home/rlrevell/cvs/alsa/alsa-driver/kbuild/../acore/pcm_native.o]
> Error 1 make[2]: ***
> [/home/rlrevell/cvs/alsa/alsa-driver/kbuild/../acore] Error 2 make[1]:
> *** [_module_/home/rlrevell/cvs/alsa/alsa-driver/kbuild] Error 2
> make[1]: Leaving directory
> `/home/rlrevell/kernel-source/linux-2.6.9-rc2-mm4-S7' make: ***
> [compile] Error 2
> 
> I am not sure if this is an ALSA issue or -mm4.  I suspect -mm4
> because-mm3-S6 worked.  The VP patch does not seem to be involved.


Hmm, i have no problems compiling the alsa drivers included with the
kernel [yes, i'm on mm4-S7]..

tapas@mango:~$ gcc --version
gcc (GCC) 3.3.4 (Debian 1:3.3.4-13)

flo
