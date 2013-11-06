From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How to apply rate conversion in asound.conf
Date: Wed, 06 Nov 2013 17:30:25 +0100
Message-ID: <527A6EA1.4080909@ladisch.de>
References: <DUB122-W45C29A2FD0EE3B2FC1A459AAF00@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 192DF261ACB
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 17:30:30 +0100 (CET)
In-Reply-To: <DUB122-W45C29A2FD0EE3B2FC1A459AAF00@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dolevo Jay <cmst@live.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dolevo Jay wrote:
> pcm.!default {
> 	type plug
> 	slave.pcm multi
> }
>
> pcm.multi {
>         slaves.a.pcm "hw:0,1";
>         slaves.b.pcm "hw:1,1";
> ...
>
> My purpose is to apply rate conversion to the "hw:1,1" and have 44100 rate
> out.

All slaves must use the same rate.

The easiest way is apply this to the plug plugin:

pcm.!default {
	type plug
	slave {
		pcm multi
		rate 44100
	}
}


Regards,
Clemens
