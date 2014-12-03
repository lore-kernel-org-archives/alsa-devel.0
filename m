From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH 2/2] ALSA: hda - Drop
	AZX_DCAPS_ALIGN_BUFSIZE
Date: Wed, 3 Dec 2014 17:13:45 +0800
Message-ID: <CAN8cciZ6xf9EQUG5s7QEOGU8j=bKXfTN1PukoS7C3TkbVNGFdQ@mail.gmail.com>
References: <1417597333-15749-1-git-send-email-tiwai@suse.de>
 <1417597333-15749-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f171.google.com (mail-qc0-f171.google.com
 [209.85.216.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 2900326043B
 for <alsa-devel@alsa-project.org>; Wed,  3 Dec 2014 10:13:46 +0100 (CET)
Received: by mail-qc0-f171.google.com with SMTP id r5so10745270qcx.16
 for <alsa-devel@alsa-project.org>; Wed, 03 Dec 2014 01:13:45 -0800 (PST)
In-Reply-To: <1417597333-15749-2-git-send-email-tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
> We introduced AZX_DCAPS_ALIGN_BUFSIZE to explicity show that the
> controller needs the alignment, with a slight hope that the buffer
> size alignment will be disabled as default in future.  But the reality
> tells that most chips need the buffer size alignment, and it'll be
> likely enabled in future, too.
>
> This patch drops AZX_DCAPS_ALIGN_BUFSIZE to give back one more
> previous DCAPS bit for future use.  At the same time, rename
> AZX_DCAPS_BUFSIZE with AZX_DCAPS_NO_ALIGN_BUFSIZE for avoiding
> confusion.
>
> AZX_DCAPS_ALIGN_BUFSIZE are still kept (but commented out) in each
> DCAPS presets for a purpose as markers.

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=2ae66c26550cd94b0e2606a9275eb0ab7070ad0e

Does it mean that there are still a few  hda controllers support arbitrary
period size or no hda controller support arbitrary period size ?
