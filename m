From: Stephen Warren <swarren@nvidia.com>
Subject: periods*period_size vs. buffer_size;
	should they be equal?
Date: Fri, 17 Dec 2010 12:04:05 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF030FD787C0@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 55CDE1037FC
	for <alsa-devel@alsa-project.org>; Fri, 17 Dec 2010 21:05:07 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I'm attempting to understand the layout of the DMA buffer used by ASoC
devices. It seems like the buffer should consist of runtime->periods entries
each of runtime->period_size frames of audio data. Hence, runtime->buffer_size
should be equal to runtime->periods * runtime->period_size in frames.

This assumption holds true in many cases. However, it doesn't in others:

(sizes in hex)

Playing WAVE '8000.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Stereo
[  217.910867] Trigger: runtime->periods=4
[  217.914696] Trigger: runtime->period_size=3e8
[  217.919043] Trigger: runtime->buffer_size=fa0
[  217.923389] Trigger: f2b(4)=10

Playing WAVE '11025.wav' : Signed 16 bit Little Endian, Rate 11025 Hz, Stereo
[  268.543821] Trigger: runtime->periods=5
[  268.547651] Trigger: runtime->period_size=400
[  268.551998] Trigger: runtime->buffer_size=1589

Playing WAVE '16000.wav' : Signed 16 bit Little Endian, Rate 16000 Hz, Stereo
[  315.889280] Trigger: runtime->periods=7
[  315.893109] Trigger: runtime->period_size=400
[  315.897456] Trigger: runtime->buffer_size=1f40

Yet for any higher sample rate the layout is identical:

Playing WAVE '96000.wav' : Signed 16 bit Little Endian, Rate 96000 Hz, Stereo
[  385.494764] Trigger: runtime->periods=8
[  385.498594] Trigger: runtime->period_size=400
[  385.502941] Trigger: runtime->buffer_size=2000

Is my assumption wrong? Is there some bug somewhere?

The reason I ask is because the DMA engine I'm writing for doesn't directly
handle circular buffers. Hence, I'm kicking off a separate DMA request for
each period's worth of data. Originally, the code was wrapping based on
runtime->buffer_size, but this didn't work correctly when buffer_size wasn't
a multiple of the period size.

Thanks for any pointers!

-- 
nvpublic
