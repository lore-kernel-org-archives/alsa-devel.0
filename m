From: Mikhail Ramendik <mr@ramendik.ru>
Subject: Re: Compiling the newest code for testing?
Date: Fri, 7 Jan 2005 21:27:38 +0300
Message-ID: <200501072127.38967.mr@ramendik.ru>
References: <200501070525.45603.mr@ramendik.ru> <s5hu0ptwkuc.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hu0ptwkuc.wl@alsa2.suse.de>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
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

You wrote:

> > - Which alsa kernel code should I run for testing? The 2.6.10-kernel
> > version? 1.0.8rc2? CVS? 1.0.8rc2 plus some files from CVS [those related
> > to i8x0]?
>
> For testing purpse, I recommend ALSA CVS version.
> ATM, 1.0.8rc2 is very new, so it should be fine in most cases, too.

OK, I'll do 1.0.8rc2, to avoid CVS-related issues.

> > - Is it OK to compile this kernel code by merely copying the relevant
> > directories (sound [except for sound/oss] and include/sound) from the
> > alsa tree into the kernel tree? I run an RPM-based system, and would like
> > to keep the existing approach to kernel building (full RPM rebuild)
> > alive; it's slow but reliable.
>
> Not always.  The ALSA cvs may contain the codes for the very latest
> kernel (rc or mm).  Copying the files to kernel might not work when
> the kernel function / API is changed.  The difference is usually
> absorbed by patches in alsa-driver tree.

Which kernel is 1.0.8rc2 for? There apparently is no recent -rc at the moment. 
If it's against an -mm version, I can compile that too, at least for the alsa 
tests. I just need to be sure which kernel version it's tied to.

And, will compiling ALSA separately resolve the kernel version vs. ALSA 
version issues? (I have read the INSTALL file and have questions, but I won't 
ask them until I'm sure this stuff will be needed; I'd really prefer to go 
with in-kernel compilation).
 
> > - Which alsa-lib and alsa-utils code should I be running? (I know how to
> > compile it using RPM, I just need to understand the version).
>
> It should match with the ALSA driver version.
> The library itself has backward compatibility, but the configurations
> included in alsa-lib package may not match with the old drivers.

OK, that's clear.

> > And an i8x0-specific question: in the above-mentioned current code,
> > should output to hw:0,0 go only to analog, or to both analog and spdif?
>
> Analog only.
>
> Basically, you should avoid to access "hw:0,0".  If you want to output
> to analog front, you can use "front", instead.  Similarly, for spdif,
> use "spdif" (or "iec958").

But OSS emulation is needed for some of the stuff I use, and that writes to 
hw:0,0 . I know I should be searching for fixed on the other end as well.

> Regarding the dubbed output to analog and spdif - I once had a patch
> for testing but the tester couldn't apply it.  The latest patch is
> attached below (to 1.0.8rc2 or CVS).  If you're interested in it,
> please give it a try.

I suspect I was that tester.

As soon as I get an alsa+kernel that works, I'll try the patch.

Thanks!

-- 
Yours, Mikhail Ramendik



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
