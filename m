From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: Re: [PATCH RFC 0/2] da850 mcasp playback ping-pong
	buffers don't work
Date: Mon, 16 May 2011 15:15:51 -0400
Message-ID: <BANLkTin3o0pW2txphBq-61QT6T1kJm_Ydw@mail.gmail.com>
References: <cover.1305321198.git.bengardiner@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog113.obsmtp.com (na3sys009aog113.obsmtp.com
	[74.125.149.209])
	by alsa0.perex.cz (Postfix) with ESMTP id DD82A245B8
	for <alsa-devel@alsa-project.org>;
	Mon, 16 May 2011 21:15:53 +0200 (CEST)
Received: by mail-vx0-f178.google.com with SMTP id 11so4621086vxc.23
	for <alsa-devel@alsa-project.org>; Mon, 16 May 2011 12:15:51 -0700 (PDT)
In-Reply-To: <cover.1305321198.git.bengardiner@nanometrics.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>, alsa-devel@alsa-project.org
Cc: Subhasish Ghosh <subhasish@mistralsolutions.com>, davinci-linux-open-source@linux.davincidsp.com, Sekhar Nori <nsekhar@ti.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi All,

On Fri, May 13, 2011 at 5:26 PM, Ben Gardiner
<bengardiner@nanometrics.ca> wrote:
> [...]
> Does anyone have any clues why ping-pong buffers on da850 to the McASP
> would work? Or any clues why the patches are broken?

To answer my own question: the reason ping-pong buffering was not
working is because the SRAM allocator being used was allocating
buffers from the "ARM local RAM" block @0xFFFF0000 which is not
addressable by the DMA engine -- according to SPRS586.

Ping-pong buffers work when I substitute the allocator for one that
allocates from the 'Shared RAM' block @0x80000000 using Subhasish
Ghosh's patch "davinci: changed SRAM allocator to shared ram."

Best Regards,
Ben Gardiner

---
Nanometrics Inc.
http://www.nanometrics.ca
