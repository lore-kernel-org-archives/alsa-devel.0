From: Tim Goetze <tim@quitte.de>
Subject: Re: SiS748/963L + CMI9739, no IRQs from card?
Date: Fri, 5 Dec 2003 00:40:58 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0312050020140.524@autumn>
References: <3FCFA7EA.2050708@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FCFA7EA.2050708@gmx.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Friedrich Ewaldt <Friedrich.Ewaldt@gmx.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Friedrich Ewaldt wrote:

>Is there anything else I could try? Any additional debugging information
>I can provide besides the info in the 2 user-list mails mentioned above?
>Thanks in advance for any help!

have you tried enabling the kernel build options 'IO-APIC support on
uniprocessors' and 'Local APIC Support on Uniprocessors' yet (provided
your box does ACPI; probably so since you say it is a recent design)?

i ask because on this box there were dropped interrupts from the audio
interface when the interrupt line was also shared between three
devices. enabling the above options rendered the interface with an
exclusive interrupt line, with good results.

if your kernel was already built with those options turned on, check
the kernel boot options for 'pci=noacpi' or 'acpi=off'.

hth,

tim


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
