From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: Re: apm and alsa driver for intel8x0 on dell inspiron 8200
Date: Mon, 17 Mar 2003 13:37:43 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030317123743.GA25114@rhlx01.fht-esslingen.de>
References: <E18utYR-0006kU-00@sc8-sf-list2.sourceforge.net>
Reply-To: andi@rhlx01.fht-esslingen.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <E18utYR-0006kU-00@sc8-sf-list2.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

On Mon, Mar 17, 2003 at 04:16:19AM -0800, alsa-devel-request@lists.sourceforge.net wrote:
> Message: 6
> Date: Sun, 16 Mar 2003 17:44:02 -0800 (PST)
> From: "Quod E. Demonstrandum" <nib_maps@yahoo.com>
> To: alsa-devel@lists.sourceforge.net
> Subject: [Alsa-devel] apm and alsa driver for intel8x0 on dell inspiron 8200
> 
> 
> Hello,
> 
> It would seem that apm/acpi access (reading /proc/apm
> or /proc/acpi, whichever is compiled into the kernel)
> corrupts sound on my computer, a dell i8200 running
> linux 2.4.20 and alsa 0.9.1.
Ah, so the Inspiron 8200 uses intel8x0 instead of maestro3 driver?
If so, then the following comment:
        /* FIXME: Inspiron 8100 and 8200 ids should be here, too */
        /* END */
        { 0 }
in alsa-kernel/pci/maestro3.c about some hacks is incorrect.
Or are there 8200 versions with Maestro chip?

> This does not happen with the OSS driver.  Moreover,
> gnomemeeting seems to work well, but .wav samples
> played by esd get corrupted if apm/acpi is accessed
> while they are played.
Continuously accessing /proc/apm in a loop doesn't corrupt sound
on my Inspiron 8000 w/ Maestro 3i.

> Is this a known phenomenon?
> I know nothing about the ALSA project, but I can code:
> could you give me a few tips as to where to start
> debugging this?
Hmm, on my Inspiron 5000 (NOT my 8000! ;-), the BIOS completely hangs the
system for several seconds if it blanks the screen (thus, sound loops!).
Maybe your BIOS commits the same crime for every power management call?
Oh, and please detail "corruption"...

Andreas Mohr

-- 
Help prevent Information Technology Fascism! - before it's too late...
http://www.againsttcpa.com


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
