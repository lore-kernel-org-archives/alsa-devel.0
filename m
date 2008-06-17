From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: ALSA 1.0.17rc2 release
Date: Tue, 17 Jun 2008 10:18:52 +0100
Message-ID: <200806171018.52879.gineera@aspect135.co.uk>
References: <Pine.LNX.4.61.0806161121530.1798@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (smtp-out-4.talktalk.net [62.24.128.234])
	by alsa0.perex.cz (Postfix) with ESMTP id 710282470A
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Jun 2008 11:08:04 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.61.0806161121530.1798@tm8103-a.perex-int.cz>
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
To: ALSA devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Monday 16 June 2008 10:24, Jaroslav Kysela wrote:
> 	ALSA 1.0.17rc2 packages (except tools, oss, python - no changes)
> were released and are available for download on ALSA server.

> 	The alsa-driver compilation with 2.4 kernels should be fixed in
> this release.

The posted ak4531_codec issues are fixed.  I didn't get to post details of the 
other error, which still occurs with this 2.4.21-99 system:

In file included from memory.c:3:
../../alsa-kernel/pci/emu10k1/memory.c: In function `synth_alloc_pages':
../../alsa-kernel/pci/emu10k1/memory.c:466: error: `GFP_DMA32' undeclared 
(first use in this function)
../../alsa-kernel/pci/emu10k1/memory.c:466: error: (Each undeclared identifier 
is reported only once
../../alsa-kernel/pci/emu10k1/memory.c:466: error: for each function it 
appears in.)
../../alsa-kernel/pci/emu10k1/memory.c:467: warning: implicit declaration of 
function `page_to_pfn'
make[2]: *** [memory.o] Error 1
make[2]: Leaving directory `/usr/share/alsa1.0.17rc2/alsa-driver-1.0.17rc2/
pci/emu10k1'

Alan
