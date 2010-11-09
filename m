From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: question about sound/pci/ctxfi/ctpcm.c
Date: Tue, 09 Nov 2010 09:07:41 +0100
Message-ID: <4CD9014D.20800@ladisch.de>
References: <Pine.LNX.4.64.1011081753110.21375@pc-004.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 4A5C910382A
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2010 09:06:04 +0100 (CET)
In-Reply-To: <Pine.LNX.4.64.1011081753110.21375@pc-004.diku.dk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <julia@diku.dk>
Cc: tiwai@suse.de, tj@kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Julia Lawall wrote:
> The file sound/pci/ctxfi/ctpcm.c contains the functions 
> ct_pcm_playback_open and ct_pcm_capture_open that contain the following 
> pattern of code:
> 
>         runtime->private_data = apcm;
> 	...
> 	if (err < 0) {
>                 kfree(apcm);
>                 return err;
>         }
> 
> I wonder if this leaves a dangling pointer to apcm in runtime?

The runtime structure contains data that is valid only while the
substream is open; it is allocated by the ALSA framework before
calling the open callback, and deallocated after calling the close
callback (or if the open callback fails).

> The function ct_atc_pcm_free_substream on the other hand does set the 
> private_data field to NULL after freeing apcm.

This is superfluous.

> But perhaps there is something in the calling context of open that
> ensures that if the open function fails, the private_data field of
> runtime will never be used?

If the open callback fails, the close callback will not be called.
However, the runtime->private_free callback, if set, will be called.

So there is indeed a dangling pointer.


Regards,
Clemens
