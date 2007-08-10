From: "Wei Kai" <kai.wei.cn@gmail.com>
Subject: Re: Why there is no SNDRV_PCM_RATE_24000 in pcm.h
Date: Fri, 10 Aug 2007 16:54:44 +0800
Message-ID: <579fa30a0708100154n1cc555f9v806e4216ae056811@mail.gmail.com>
References: <579fa30a0708092335w4c2383e5se192b96e112dce81@mail.gmail.com>
	<1186731597.24600.1204693985@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.235])
	by alsa0.perex.cz (Postfix) with ESMTP id B03CF1038C4
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Aug 2007 10:54:46 +0200 (CEST)
Received: by qb-out-0506.google.com with SMTP id q12so849325qba
	for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2007 01:54:45 -0700 (PDT)
In-Reply-To: <1186731597.24600.1204693985@webmail.messagingengine.com>
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
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thank you, Clemens.

2007/8/10, Clemens Ladisch <cladisch@fastmail.net>:
> Wei Kai wrote:
> > I checked the include/sound/pcm.h in kernel and find this problem, it
> > seemed strange, so many codecs support the 24000 sample rate, why
> > there is no such definition.
>
> When the header file was created many years ago, 24000 Hz wasn't a
> common sample rate.
>
> To support a sample rate that is not in that list of predefined rates,
> your driver should set the RATE_KNOT bit and call the
> snd_pcm_hw_constraint_list() function; see the section "Constraints" in
> the "Writing an ALSA Driver" document.
>
>
> HTH
> Clemens
>
