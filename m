From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: [PATCH RFC 0/2] da850 mcasp playback ping-pong buffers
	don't work
Date: Fri, 13 May 2011 17:26:44 -0400
Message-ID: <cover.1305321198.git.bengardiner@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog104.obsmtp.com (na3sys009aog104.obsmtp.com
	[74.125.149.73])
	by alsa0.perex.cz (Postfix) with ESMTP id 726D31037FB
	for <alsa-devel@alsa-project.org>;
	Fri, 13 May 2011 23:26:51 +0200 (CEST)
Received: by mail-yx0-f181.google.com with SMTP id 8so1371772yxm.40
	for <alsa-devel@alsa-project.org>; Fri, 13 May 2011 14:26:50 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Troy Kisky <troy.kisky@boundarydevices.com>, Chaithrika U S <chaithrika@ti.com>, alsa-devel@alsa-project.org
Cc: davinci-linux-open-source@linux.davincidsp.com, Sekhar Nori <nsekhar@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi All, 

I've been testing playback on the da850evm. The good news is on 2.6.39-rc7
playback works fine. The bad news is that if the patches in the series 
are applied -- playback does not work. 

The first patch copies the sram-size platform data to the dma parameters
used by davinci-pcm the same way that the existing davinci-i2s driver 
does. The second patch assigns a buffer size to the playback sram platform
data and sets the queues as per Troy's introduction of ping-pong buffers.

I was hoping this would result in playback of audio; but instead there is 
soft click and then silence. I added pointer debug and observed that the 
period_update and hwptr_update events progress; but that's as far as I 
have probed. 

Does anyone have any clues why ping-pong buffers on da850 to the McASP 
would work? Or any clues why the patches are broken?

Best Regards,
Ben Gardiner

Ben Gardiner (2):
  [RFC] ASoC: davinci-mcasp: enable ping-pong SRAM buffers
  [RFC] da850evm: enable mcasp ping-pong buffers

 arch/arm/configs/da8xx_omapl_defconfig  |    1 +
 arch/arm/mach-davinci/board-da850-evm.c |    4 +++-
 sound/soc/davinci/davinci-mcasp.c       |    2 ++
 3 files changed, 6 insertions(+), 1 deletions(-)

-- 
1.7.4.1
