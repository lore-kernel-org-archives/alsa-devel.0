From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Calculated average playback latency
Date: Tue, 14 Dec 2010 17:20:47 +0100
Message-ID: <4D07995F.6020900@ladisch.de>
References: <AANLkTikcrTA4hRp9AvOfZPGN0FrkKwYS3SaFq0W25NdE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 64F3D24664
	for <alsa-devel@alsa-project.org>; Tue, 14 Dec 2010 17:20:51 +0100 (CET)
In-Reply-To: <AANLkTikcrTA4hRp9AvOfZPGN0FrkKwYS3SaFq0W25NdE@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jean-Yves Avenard <jyavenard@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jean-Yves Avenard wrote:
> By default, Myth uses mmap access

Why?

> Problem, turned out his was using a USB audio device, and
> snd_pcm_hw_params_set_access didn't return any error.

USB audio devices do support mmap.

> ... I decided to stop using mmap and instead use snd_pcm_writei.
> 
> Now on my system, this has added quite a bit of latency and the A/V
> sync isn't perfect anymore...

Using mmap neither reduces latency, nor does it improve synchronization.

> Is there an official way to calculate an average system latency
> (doesn't need to be perfectly accurate).

Not the average, but try snd_pcm_delay().


Regards,
Clemens
