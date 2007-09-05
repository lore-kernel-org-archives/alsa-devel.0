From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: How can I make sure the period size is a multiple
 of 16?
Date: Wed, 05 Sep 2007 12:29:54 +1200
Message-ID: <200709051229.54852.linux@audioscience.com>
References: <46DDE137.2070507@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 042A524482
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Sep 2007 02:26:43 +0200 (CEST)
Received: from zaphod (121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp3.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0JNV00M3JD8F4800@smtp3.clear.net.nz> for
	alsa-devel@alsa-project.org; Wed, 05 Sep 2007 12:26:39 +1200 (NZST)
In-reply-to: <46DDE137.2070507@freescale.com>
Content-disposition: inline
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

On Wednesday 05 September 2007 10:50:31 Timur Tabi wrote:
> To work around a hardware issue, my ASoC driver requires the period size to
> be a multiple of 16.  What is the best way to ensure that?

Well, I was going to refer you to
 http://www-old.alsa-project.org/~iwai/writing-an-alsa-driver/index.html
but I just get a blank page today.

Set snd_pcm_hardware.period_bytes_min to 16 or is that 16 * samplesize?

You need to add some constraints to your driver, in the open callback.
E.g.
snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 16);

List of hwparams that can be constrained is in asound.h
List of constraint helpers in pcm.h, or grep for snd_pcm_hw_constraint to see 
usage examples.

--
Eliot
