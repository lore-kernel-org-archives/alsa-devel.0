From: "Mathieu Rondonneau" <mathieu.rondonneau@polymtl.ca>
Subject: Using preallocate pci, isa or nothing?
Date: Sun, 8 Feb 2004 18:29:10 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <009601c3eea3$bca696e0$c4f9cb18@win2K>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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

Hi,
I'm sorry for the html format, these are some questions according to my
problems.

I'm writing an ALSA driver for a CSB337 board (AT91RM9200). There is no PCI
or ISA on this board. Should I preallocate memory with:
snd_pcm_lib_preallocate_pages_for_all,
snd_pcm_lib_preallocate_isa_pages_for_all() or
snd_pcm_lib_preallocate_pci_pages_for_all()?

There is a specific DMA (PDC) on the AT91RM9200, so i'm trying to use
snd_pcm_lib_preallocate_pages_for_all() but seems complicated to understand
what is needed by the ALSA pcm and what i have to write.
What does the function snd_..._pointer() mean? should i need it if i don't
use ISA or PCI mecanism?
What does the function snd_pcm_period_elapsed() mean? Should i need it if i
don't use ISA or PCI mecanism?

Thanks
any help would be very appreciate.

Mathieu Rondonneau



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
