From: Andy Ng <andreas2025@gmail.com>
Subject: Closing the pcm streams
Date: Thu, 18 Feb 2016 18:46:04 +0000
Message-ID: <CAAVaN8wroWe7xQCAnSsx_G0ruuRLiDivL2oXuFZ7U9YGGTsRow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f44.google.com (mail-vk0-f44.google.com
 [209.85.213.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D8012606A9
 for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2016 19:46:06 +0100 (CET)
Received: by mail-vk0-f44.google.com with SMTP id c3so53093638vkb.3
 for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2016 10:46:06 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

I am working on a system that a DSP provides the audio algorithms and
in case where the DSP crashes, I would like to shutdown nicely any
opened PCM streams.
The DSP has an RPC protocol to the external world. I use a small
watchdog on ARM to monitor the "health" of the DSP. When the DSP goes
down, I reset it. However, I would like to close down smoothly the PCM
streams and inform the user that there was an error while playing.  Is
there any way to inform the ALSA kernel framework in the kernel that a
specific PCM stream gone bad? Where is the best point to reset ALSA
kernel framework?

Thank you
Andy
