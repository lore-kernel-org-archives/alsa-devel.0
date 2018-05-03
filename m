From: noman pouigt <variksla@gmail.com>
Subject: Buffer size calculation based on period size
Date: Thu, 3 May 2018 13:17:08 -0700
Message-ID: <CAES_P+_d1Di+P_cs3PU6Kqw=6i1WCNf00SB=KXgzVvei4_zmLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f171.google.com (mail-pf0-f171.google.com
 [209.85.192.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 97084267235
 for <alsa-devel@alsa-project.org>; Thu,  3 May 2018 22:17:10 +0200 (CEST)
Received: by mail-pf0-f171.google.com with SMTP id f20so6810965pfn.0
 for <alsa-devel@alsa-project.org>; Thu, 03 May 2018 13:17:10 -0700 (PDT)
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
Cc: tiwai@suse.de, broonie@kernel.org, ckeepax@opensource.cirrus.com, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

I am at my wits end trying to figure out how
period_size is being calculated in pcm_native
layer based on period_size and period_count
being set by the userspace.

I am using tinycap to capture the audio and
setting below settings:
bitwidth =  16
rate =  16000
channel =  1
period_size =  320
period_count = 2

I am wondering how is below
period_size and buffer_size calculated?

Shouldn't period_size of 320 bytes and
period_count of 2 fail?

cat sub0/hw_params

access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 1
rate: 16000 (16000/1)
period_size: 2042
buffer_size: 4084


And this is my settings in pcm_hardware structure:
static struct snd_pcm_hardware s1000_pcm_hw = {
.buffer_bytes_max = 1024*1024,
.period_bytes_min = 4084,
.period_bytes_max = (1024*1024)/2,
.periods_min =      2,
.periods_max =      32,
 };
