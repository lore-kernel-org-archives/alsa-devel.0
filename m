From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Audio Driver Works In Ubuntu but Crash in
	Debian	After 2nd Run
Date: Tue, 16 Jun 2015 09:50:14 +0200
Message-ID: <557FD536.3020906@ladisch.de>
References: <CA+k7WwYp8aN0OWmSNjtYq-4w4s+00Ej7tcsjiqbj7BbiJ+MtQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 753D52654CE
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2015 09:50:16 +0200 (CEST)
In-Reply-To: <CA+k7WwYp8aN0OWmSNjtYq-4w4s+00Ej7tcsjiqbj7BbiJ+MtQQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Azizul Hakim <azizulfahim2002@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Azizul Hakim wrote:
> kernel: ALSA sound/core/pcm_lib.c:1910 playback write error (DMA or IRQ trouble?)

This message means that the playback position did not advance.

This typically indicates that your driver did not actually start the
DMA, or that interrupts do not arrive correctly, or that your .pointer
callback is buggy.


Regards,
Clemens
