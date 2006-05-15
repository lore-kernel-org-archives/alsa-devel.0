From: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-rc4-mm1
Date: Mon, 15 May 2006 11:11:11 -0700
Message-ID: <20060515111111.510f214a.akpm__8137.3059227646$1147796165$gmane$org@osdl.org>
References: <20060515005637.00b54560.akpm@osdl.org>
	<6bffcb0e0605150940l647273f0jf4e1b9d5737bbd2@mail.gmail.com>
	<20060515100429.5069f6ca.akpm@osdl.org>
	<s5h3bfb5h73.wl%tiwai@suse.de>
	<s5hy7x341f8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4F867226
	for <alsa-devel@alsa-project.org>; Mon, 15 May 2006 20:08:31 +0200 (MEST)
In-Reply-To: <s5hy7x341f8.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: michal.k.k.piotrowski@gmail.com, perex@suse.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> wrote:
>
> -unsigned int snd_cards_lock = 0;	/* locked for registering/using */
> +static unsigned int snd_cards_lock = 0;	/* locked for registering/using */

May as well remove the `= 0' while you're there.  It adds four bytes to the
module unnecessarily.

>  void snd_request_card(int card)
>  {
> -	int locked;
> -
>  	if (! current->fs->root)
>  		return;

I wonder what that's there for.



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
