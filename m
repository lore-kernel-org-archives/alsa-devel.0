From: Konstantin Ozerkov <kozerkov@parallels.com>
Subject: Re: Getting rid of inside_vm in intel8x0
Date: Wed, 30 Mar 2016 10:32:51 +0300
Message-ID: <56FB8123.1020801@parallels.com>
References: <CALCETrWnsn4CoRXcKDXpMTjxCYj8==mZQHkZRuXfZQyvERB3Gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0093.outbound.protection.outlook.com [207.46.100.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B35F2605C3
 for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2016 09:33:12 +0200 (CEST)
In-Reply-To: <CALCETrWnsn4CoRXcKDXpMTjxCYj8==mZQHkZRuXfZQyvERB3Gw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Lutomirski <luto@amacapital.net>, Luis Rodriguez <mcgrof@suse.com>, Takashi Iwai <tiwai@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello.

I'm strongly disagree to revert this path or disable optimization.
This patch fixes real sound issue when Linux runs inside VM.

On 30/03/16 00:37, Andy Lutomirski wrote:
> Would it be possible to revert:
>
> commit 228cf79376f13b98f2e1ac10586311312757675c
> Author: Konstantin Ozerkov <kozerkov@parallels.com>
> Date:   Wed Oct 26 19:11:01 2011 +0400
>
>      ALSA: intel8x0: Improve performance in virtual environment
>
> Presumably one or more of the following is true:
>
> a) The inside_vm == true case is just an optimization and should apply
> unconditionally.
Wrong. Code without optimization gracefully handle some odd hardware.
But code with optimization also fixes real problem in virtual environment.
>
> b) The inside_vm == true case is incorrect and should be fixed or disabled.
Could you explain what is wrong ?
>
> c) The inside_vm == true case is a special case that makes sense then
> IO is very very slow but doesn't make sense when IO is fast.  If so,
> why not literally measure the time that the IO takes and switch over
> to the "inside VM" path when IO is slow?
Measuring IO performance inside VM is not easy as may seen. Most of 
clock sources are
emulated and adjusted to hide VM-exit (emulation) hole, i.e. time flow 
inside VM have
delays and speedups in comparison to wall clock time. To detect "inside 
VM" condition by this
way loop should run at least 1 seconds or more (10 or more preferred) 
without guarantee of
proper detection. I think this is not acceptable at module 
initialization time.
>
> There are a pile of nonsensical "are we in a VM" checks of various
> sorts scattered throughout the kernel, they're all a mess to maintain
> (there are lots of kinds of VMs in the world, and Linux may not even
> know it's a guest), and, in most cases, it appears that the correct
> solution is to delete the checks.  I just removed a nasty one in the
> x86_32 entry asm, and this one is written in C so it should be a piece
> of cake :)
 From drivers view VM is sort of hardware with special requirements and 
capabilities. Sometimes drivers should
be aware about them to work properly.

The simplest way to remove "are we in a VM" checks mess is write 
kernel-wide service that detects this
condition and switch to use it in other places.

I agree that check inside snd_intel8x0_inside_vm() looks very strict. 
Originally this code was designed to enable optimization
only for well tested environments (KVM-based or Parallels VMs).

>
> --Andy
