From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: pthread or snd_async_add_pcm_handler
Date: Wed, 14 Sep 2011 17:06:17 +0200
Message-ID: <4E70C2E9.80203@ladisch.de>
References: <892B4BD9-F32C-4B24-87BF-F54EC5722330@resorama.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id C3FC52434F
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Sep 2011 17:06:02 +0200 (CEST)
In-Reply-To: <892B4BD9-F32C-4B24-87BF-F54EC5722330@resorama.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Maarten de Boer <maarten@resorama.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Maarten de Boer wrote:
> I looked at the direct_loop code in the alsa-lib/test/pcm.c example. 
> 
> Now I want to run do the audio processing asynchronously. The
> async_direct_loop in the example does this, but I was wondering: is
> there any advantage to using snd_async_add_pcm_handler over using
> a simple pthread?

No; the async handler is neither portable nor recommended.
That test program ist just for testing the API.


Regards,
Clemens
