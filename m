From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: static build on two machine
Date: Wed, 04 Jul 2012 15:36:31 +0200
Message-ID: <4FF446DF.7010500@ladisch.de>
References: <1341403619.5509.9.camel@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id C9B3824601
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jul 2012 15:36:36 +0200 (CEST)
In-Reply-To: <1341403619.5509.9.camel@debian>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mohsen Pahlevanzadeh <mohsen@pahlevanzadeh.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mohsen Pahlevanzadeh wrote:
> When i compile my own software, i get two warning however my
> co-worker doesn't get them:
> ///////////////////////
> /usr/i686/lib/libasound.a(pcm_dmix.o):-1: In function `snd_pcm_dmix_sync_ptr':
> pcm_dmix.c:-1: warning: Warning: snd_pcm_hwsync() is deprecated, consider to use snd_pcm_avail()

You probably have different compiler options or library versions.

> When i run  my program my program that my co-worker wrote, crashed, But
> when he run it, it's crashed.

Sounds like a bug somewhere.


Regards,
Clemens
