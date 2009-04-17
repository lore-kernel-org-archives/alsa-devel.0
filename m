From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Subject: Re: [PATCH] us122l: Fix signedness in comparisions
Date: Fri, 17 Apr 2009 13:23:05 +0200
Message-ID: <200904171323.06068.fzu@wemgehoertderstaat.de>
References: <200904161935.01883.fzu@wemgehoertderstaat.de>
	<s5hy6tzahiu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout3.freenet.de (mout3.freenet.de [195.4.92.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 1D44410380E
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Apr 2009 13:23:13 +0200 (CEST)
In-Reply-To: <s5hy6tzahiu.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

Am Freitag 17 April 2009 schrieb Takashi Iwai:
> At Thu, 16 Apr 2009 19:35:01 +0200,
> Karsten Wiese wrote:
> > 
> > Within 2.6.30's mergewindow, struct urb's transfer_buffer_length has become
> > unsigned. This changed an "int > int" comparision to an "unsigned > int" one
> > in snd_usb_122l.
> 
> Does this cause any error, i.e. a real bug?  Otherwise this patch isn't
> needed for stable kernel.

struct urb's transfer_buffer_length is still an int in 2.6.29.1.
This patch wouldn't fix a bug in stable. I agree it is not needed for stable.

Thanks,
Karsten
