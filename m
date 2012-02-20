From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Direct use of the DMA buffer?
Date: Mon, 20 Feb 2012 09:11:03 +0100
Message-ID: <4F420017.70508@ladisch.de>
References: <4F4181AF.1060303@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 1CB5F103CC3
	for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2012 09:08:17 +0100 (CET)
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id A13AD206DD
	for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2012 03:08:16 -0500 (EST)
In-Reply-To: <4F4181AF.1060303@ivitera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pavel Hofman <pavel.hofman@ivitera.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Pavel Hofman wrote:
> Please excuse my ignorance, but is it possible for an application to
> directly use/output to the DMA buffer allocated by the kernel in
> hw_params?

Set one of the SND_PCM_ACCESS_MMAP_* access types and then use
snd_pcm_mmap_begin/commit.


Regards,
Clemens
