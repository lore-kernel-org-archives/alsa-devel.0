From: "James Courtier-Dutton" <James@superbug.demon.co.uk>
Subject: RE: AC3 Passthru on SB Live
Date: Wed, 27 Feb 2002 16:07:27 -0000
Message-ID: <NGBBLNODKDFPBFMBBFAFCEDPCCAA.James@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
In-reply-to: <NGBBLNODKDFPBFMBBFAFMEDMCCAA.James@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

As a small extra, the emu10k1 kernel driver which support oss, has a few
bits of info which might be of help
>From the emu10k1 linux kernel developers: -
We allocate memory with pci_alloc_consistent() which according to
DMA-mapping.txt assures 32-bits PCI addresses. On top of that
we set a dma_mask (with pci_set_dma_mask) of 29 bits (512Mib).

Also: -
29 bit (512MiB), mostly speculation/trial-and-error though. See main.c and
the pci_set_dma_mask() calls.

Does this help alsa09 at all ?

Cheers
James


> -----Original Message-----
> From: James Courtier-Dutton [mailto:James@superbug.demon.co.uk]
> Sent: 27 February 2002 15:51
> To: alsa-devel@lists.sourceforge.net
> Subject: AC3 Passthru on SB Live
>
>
> Hello
>
> AC3 passthru on the SB Live does not seem to work on all
> platforms with the latest alsa-cvs. (26-2-2002)
> It works on my system, which is a SB Live Rev 6, which only
> started working recently.
> It does not work on a SB Live rev 7 (I don't have this, but
> others have reported.)
>
> Can anyone comment on which SB Live revisions work, and which do not.
>
> All the SB Live versions seem to work with the emu10k1 kernel drivers.
>
> Cheers
> James
>


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
