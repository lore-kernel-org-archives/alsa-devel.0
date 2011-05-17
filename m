From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: Alsa Support for Korg Pandora Mini, Vox ToneLab ST
Date: Tue, 17 May 2011 15:44:16 +0200
Message-ID: <4DD27BB0.8040600@showlabor.de>
References: <BANLkTikGDzzhXQLTpsHvqqJ=b30JgkumJQ@mail.gmail.com>	<BANLkTinXgstKju=8-Ow7o542-zZxvKZdTQ@mail.gmail.com>	<loom.20110514T184918-282@post.gmane.org>	<BANLkTi=uT5xEJ1xtOqXFqPAH6ghRcJhEhg@mail.gmail.com>	<BANLkTimWe6OJjRLjNFKKSKyPuSjuZcBLgQ@mail.gmail.com>	<BANLkTin7JRp6wZeX049Atqn+zmZdkQ1vGQ@mail.gmail.com>	<BANLkTinFu=NLm+8dkM8h_KLMT=PtrutjYg@mail.gmail.com>	<BANLkTik5LMFp-W2q9yhadPdJwswYXUbDgA@mail.gmail.com>	<BANLkTimuaynDA+0wq9kqwizL5kp+b+AuLA@mail.gmail.com>	<BANLkTiksbKfS5QdOobDn=2=o3EwrcYXMtA@mail.gmail.com>
	<BANLkTimWSVAGNmfxpXPTWsWAx-MH8WU5KQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vwp5738.webpack.hosteurope.de (vwp5738.webpack.hosteurope.de
	[83.169.30.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 17F5310381E
	for <alsa-devel@alsa-project.org>;
	Tue, 17 May 2011 15:44:18 +0200 (CEST)
In-Reply-To: <BANLkTimWSVAGNmfxpXPTWsWAx-MH8WU5KQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Hi Daniel,

Am 16.05.2011 08:48, schrieb Daniel Mack:
> The solution is most probably rather simple by handling the Fasttrack
> as composite device that has non-standard and standard interfaces
> mixed. There is a macro for that which we just need to use.
>
> Can you give the attached patch a change?
>
> HTH,
> Daniel
>

as expected, the patch works for the Fast Track Ultra 8R (0x0763, 
0x2081), too.

Thanks,

Felix
