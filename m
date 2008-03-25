From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Wrong offset,
	step and size passed from alsa-lib layers to external io type plugin
Date: Mon, 24 Mar 2008 20:07:32 -0700
Message-ID: <61445c750803242007i627f6db5t6802ee716110de53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.232])
	by alsa0.perex.cz (Postfix) with ESMTP id 15D8D2485E
	for <alsa-devel@alsa-project.org>; Tue, 25 Mar 2008 04:07:34 +0100 (CET)
Received: by wr-out-0506.google.com with SMTP id 50so2353665wri.2
	for <alsa-devel@alsa-project.org>; Mon, 24 Mar 2008 20:07:33 -0700 (PDT)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

In my external io type plugin, the alsa buffer is not accessible in the
transfer function, symptom of this
is I am unable to memcpy period size data from alsa buffer to my local
buffers.

after debugging a little I found out that values of offset, size and
areas->step are wrong.


#aplay --period-size =1024 --buffer-size=8192 test.wav

static snd_pcm_sframes_t alsa_transfer(snd_pcm_ioplug_t *io,
                   const snd_pcm_channel_area_t *areas,
                   snd_pcm_uframes_t offset,
                   snd_pcm_uframes_t size)

I get following,

Buffer size = 32768 bytes
Period size = 4096 bytes
*ALSA buffer base addr = 0x2c6e0               //wrong
Offset = 0xbeb4c7dc                                  **//wrong*
*size = 1063777280                                     **//wrong*
step = 32

What could be the reason?
-Pharaoh.
