From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [PATCH] Allow ioplugins to override snd_pcm_delay()
Date: Fri, 26 May 2006 13:41:56 +0100
Message-ID: <4476F794.7010306@superbug.co.uk>
References: <4476CC83.8080103@cendio.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from anchor-post-33.mail.demon.net (anchor-post-33.mail.demon.net
	[194.217.242.91])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 22965177
	for <alsa-devel@alsa-project.org>;
	Fri, 26 May 2006 14:41:58 +0200 (MEST)
In-Reply-To: <4476CC83.8080103@cendio.se>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Pierre Ossman <ossman@cendio.se>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pierre Ossman wrote:
> Some io plug-ins might want to adjust the reported delay value and not
> strictly follow the current buffer usage (that's why we have two calls
> after all).
>
> Allow them to specify a delay() callback and use the previous behaviour
> if they don't.
>
> Signed-off-by: Pierre Ossman <ossman@cendio.se>
>   
Can you give an example of a plugin that would want to adjust the delay 
value?

James
