From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Broken playback
Date: Thu, 22 Nov 2007 09:14:26 +0100
Message-ID: <1195719266.22048.1222696087@webmail.messagingengine.com>
References: <BLU107-W438E9F5D7EFEF18ED543BDC1780@phx.gbl>
	<1195644962.10939.1222529331@webmail.messagingengine.com>
	<BLU107-W5983EEB0D75DFABAC2EC60C1780@phx.gbl>
	<1195658907.11141.1222567701@webmail.messagingengine.com>
	<BLU107-W413B1F3D204AF054EDB272C1780@phx.gbl>
	<1195661375.18942.1222573455@webmail.messagingengine.com>
	<BLU107-W25C7A8D036E93269A46276C1780@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 39CB0243AA
	for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2007 09:14:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <BLU107-W25C7A8D036E93269A46276C1780@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Gabriele Melia <gabmelia84@msn.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Gabriele Melia wrote:
> > snd_pcm_hw_params_set_buffer_size_near(), but the allowed values are
> > hardware dependent. You might want to add your own circular buffer that
> > is bigger than ALSA's.
>  
> So your suggestion is to limit my buffer_size after decode to be same of
> ALSA's?

No; my suggestion is to use your own buffer which is big enough for your
decoder, and use this buffer to fill ALSA's buffer, whenever possible.

If one call to your decoder function needs so much time that ALSA's
buffer can become emptied, you need another thread to re-fill the ALSA
buffer in parallel with the decoding.


Regards,
Clemens
