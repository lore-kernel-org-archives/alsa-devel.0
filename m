From: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
Subject: Re: [PATCH] sound: pci: asihpi: hpifunc.c: Remove some
	unused functions
Date: Mon, 22 Dec 2014 11:32:06 +1300
Message-ID: <54974A66.8010209@blennerhassett.gen.nz>
References: <1419180627-8986-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from omr2.mail.isx.net.nz (omr2.mail.isx.net.nz [111.65.230.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 7EDA0260617
 for <alsa-devel@alsa-project.org>; Sun, 21 Dec 2014 23:32:11 +0100 (CET)
In-Reply-To: <1419180627-8986-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 22/12/14 05:50, Rickard Strandqvist wrote:
> Removes some functions that are not used anywhere:

NAK - because  hpi_adapter_set_property() is now used in for-next branch
of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git

Otherwise I have no problem with the patch.
