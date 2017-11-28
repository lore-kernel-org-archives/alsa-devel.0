From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 00/24] ALSA: ctl: refactoring compat layer
Date: Tue, 28 Nov 2017 22:32:51 +0900
Message-ID: <41eb40d0-8e12-e6d0-abf5-d37915eb503b@sakamocchi.jp>
References: <20171125092006.24408-1-o-takashi@sakamocchi.jp>
 <s5h1skjmp4w.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 7801A266B0F
 for <alsa-devel@alsa-project.org>; Tue, 28 Nov 2017 14:32:53 +0100 (CET)
In-Reply-To: <s5h1skjmp4w.wl-tiwai@suse.de>
Content-Language: en-US
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Nov 28 2017 05:40, Takashi Iwai wrote:
 > Basically I like this kind of refactoring, but I hesitate applying at
 > this time.  First off, the patches make codes bigger in both source
 > codes and binaries:
 >
 >   sound/core/control.c        | 242 ++++++++-----
 >   sound/core/control_compat.c | 837 
+++++++++++++++++++++++++-------------------
 >   2 files changed, 630 insertions(+), 449 deletions(-)
 >
 > (original)
 >   % size sound.ko
 >     text    data     bss     dec     hex filename
 >    59494    2188    6272   67954   10972 sound/core/snd.ko
 >
 > (patched)
 >   % size sound.ko
 >     text    data     bss     dec     hex filename
 >    60186    2200    6272   68658   10c32 sound/core/snd.ko

Yes. This patchset increases binary size. In my build envoronment
(make x86_64_defconfig + disable debug configurations), they're:

(at v4.15-rc1[1])
$ size -A /tmp/snd.ko.master
/tmp/snd.ko.master  :
section                      size   addr
.note.gnu.build-id             36      0
.text                       26244      0 <-
.init.text                    470      0
.exit.text                     45      0
.altinstr_replacement          20      0
__ksymtab                     832      0
__ksymtab_gpl                  96      0
.rodata                      1784      0 <-
.rodata.str1.1                733      0
.rodata.str1.8                559      0
__ksymtab_strings            1133      0
.modinfo                      423      0
__param                       120      0
.orc_unwind_ip               5220      0
.orc_unwind                  7830      0
.smp_locks                     24      0
.altinstructions               52      0
.data                         480      0
__bug_table                    12      0
.gnu.linkonce.this_module     768      0
.bss                         2240      0
.comment                      324      0
.note.GNU-stack                 0      0
Total                       49445

(with whole this patchset, at a branch in my repo[2])
$ size -A /tmp/snd.ko.compat
/tmp/snd.ko.compat  :
section                      size   addr
.note.gnu.build-id             36      0
.text                       26692      0 <-
.init.text                    470      0
.exit.text                     45      0
__ksymtab                     832      0
__ksymtab_gpl                  96      0
.rodata                      2104      0 <-
.rodata.str1.1                733      0
.rodata.str1.8                511      0
__ksymtab_strings            1133      0
.modinfo                      424      0
__param                       120      0
.orc_unwind_ip               5212      0
.orc_unwind                  7818      0
.smp_locks                     24      0
.data                         480      0
__bug_table                    12      0
.gnu.linkonce.this_module     768      0
.bss                         2240      0
.comment                      324      0
.note.GNU-stack                 0      0
Total                       50074

Both of sections of '.rodata' and '.text' are increased. As a summary:

             v4.15-rc1   compat
.text:      26244       26692
.rodata:    1784        2104
total:      49445       50074

The increase of former comes from 'handlers[]' in
'snd_ctl_ioctl_compat()' and this is unavoided. On the other hand, the
increase of latter comes from a series of function named as
'ctl_compat_ioctl_xxx()'. If 'control.c' got proper arrangements, the
increase can be suppressed somehow.

Actually, this patchset has a next patchset, to apply refactoring the
file[3] (I should have added some comments about it, but they were not
prepared when posting this patchset, sorry...). In the unposted
patchset, the similar idea as this patchset is introduced; i.e. handler,
allocator and deallocator. As a result:

(with the unposted patchset, at a branch in my repo[3])
/tmp/snd.ko.unlocked  :
section                      size   addr
.note.gnu.build-id             36      0
.text                       26164      0 <-
.init.text                    470      0
.exit.text                     45      0
__ksymtab                     832      0
__ksymtab_gpl                  96      0
.rodata                      2328      0 <-
.rodata.str1.1                733      0
.rodata.str1.8                511      0
__ksymtab_strings            1133      0
.modinfo                      424      0
__param                       120      0
.orc_unwind_ip               5252      0
.orc_unwind                  7878      0
.smp_locks                     24      0
.data                         480      0
__bug_table                    12      0
.gnu.linkonce.this_module     768      0
.bss                         2240      0
.comment                      324      0
.note.GNU-stack                 0      0
Total                       49870

As a summary:
             v4.15-rc1   compat  unlocked
.text:      26244       26692   26164
.rodata:    1784        2104    2428
total:      49445       50074   49870

The .text section decreases its size, while .rodata increases. Total
size of included sections increases +0.8%. Of course, any debug sections
are excluded from the calculation.

In my opinion, in a point of binary size, the increase is enough
acceptable.

 > Another slight concern is that the new code requires one extra kmalloc
 > at each execution. The kctl ioctls aren't very hot code path, but
 > they can be called yet relatively frequently, hence a slowdown isn't
 > good unless the modification brings significantly (read
 > "dramatically") improvement of code readability.

Hm. I guess that you actually found some advantages of this patchset to
increase code readability and maintainability. The additional step for
allocation on kernel space belongs to optimization domain, however as
you noted code path via ALSA control interface is not designed for
severe use cases such as real-time data transmission. We can be
optimistic for the overhead as long as it's not so large.

 > Also, did you actually test with all possible architectures, not only
 > trusting the written spec?  It should be relatively easy to set up the
 > cross-compilation just only for checking this stuff.  You don't need
 > to build the whole kernel.

I've already done it. To check size of structure and offsets of members
on it, I've generate assembly list, like:

$ cat test.c
#include <stdio.h>
#include <stdlib.h>
#include <stddef.h>
#include <sound/asound.h>
struct snd_ctl_elem_value_32 {
     ...
} __attribute__((packed));
int main(void)
{
     printf("%zd\n", offsetof(struct snd_ctl_elem_value, value));
     return EXIT_SUCCESS;
}
$ x86_64-linux-gnu-gcc-7 -S -o - /tmp/test.c | grep -B 4 printf
     .cfi_def_cfa_register 6
     movl    $72, %esi
     leaq    .LC0(%rip), %rdi
     movl    $0, %eax
     call    printf@PLT
$ aarch64-linux-gnu-gcc-7 -S -o - /tmp/test.c | grep -B1 printf
     mov x1, 72
     bl  printf

Inner GCC, the value of sizeof() and offsetof() is decied in compilation
time, by builtin functions (e.g. '__builtin_offsetof()'). So the list
includes immediate values and easy to read.

But I did the above in user space, so didn't build kernel land stuffs
directly, to save my time.

Actual test is done on x86_64 machine for programs with i386, x32 and
amd64 ABIs. As you know, I used a test program in alsa-lib. (but for
x32, I wrote a small program just to test ELEM_READ/ELEM_WRITE).

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/?id=4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323
[2] https://github.com/takaswie/sound/tree/topic/ctl-compat-refactoring
[3] https://github.com/takaswie/sound/tree/topic/ctl-ioctl-refactoring


Thanks

Takashi Sakamoto
