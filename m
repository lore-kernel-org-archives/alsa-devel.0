From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Using snd_pcm_set_params() on a capture handle
Date: Sun, 25 Oct 2015 21:11:26 +0100
Message-ID: <562D376E.7000308@ladisch.de>
References: <20151025174442.b318e489f0568566a4b82908@mega-nerd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id D52CC26042B
 for <alsa-devel@alsa-project.org>; Sun, 25 Oct 2015 21:11:57 +0100 (CET)
In-Reply-To: <20151025174442.b318e489f0568566a4b82908@mega-nerd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Erik de Castro Lopo <mle+la@mega-nerd.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Erik de Castro Lopo wrote:
> * Is snd_pcm_set_params() supposed to work on capture handles?

Yes.

> * Is my use of snd_pcm_set_params() missing something and if so what?

No.  But it does not set exactly the same parameters as the manual
hw_params calls.

Please check for differences with snd_pcm_hw_params_dump() (or look into
/proc/asound/cardX/pcm0c/sub0/hw_params).

> The program can be compiled and run in two ways:
>
> gcc -Wall -O2 -DUSE_SET_PARAMS=1 alsa_capture.c -lasound -o alsa_capture
> ./alsa_capture
>
> which fails with:
>
> Read from audio interface failed (Input/output error)

Which driver?  Any messages in the system log?

> 	if ((err = snd_pcm_prepare (capture_handle)) < 0) {

This is done automatically by snd_pcm_hw_params().

> 		if ((err = snd_pcm_readi (capture_handle, buffer, buffer_frames)) != buffer_frames) {

If less than the full number of frames have been read, you get a return
value that is not an error code but a positive number.


Regards,
Clemens
