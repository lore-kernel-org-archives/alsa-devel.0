From: Andrew Burgess <aab@cichlid.com>
Subject: Re: SiS748/963L + CMI9739, no IRQs from card?
Date: Fri, 5 Dec 2003 09:09:03 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200312051709.hB5H93Ei005539@cichlid.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>have you tried enabling the kernel build options 'IO-APIC support on
>uniprocessors' and 'Local APIC Support on Uniprocessors' yet (provided
>your box does ACPI; probably so since you say it is a recent design)?

Good advice. 

Also try changing BIOS setting related to interrupts, mine has a
selection 'assign pci interrupts' or something like that.

HTH


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
