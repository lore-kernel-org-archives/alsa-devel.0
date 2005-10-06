From: Sasha Khapyorsky <sashak@smlink.com>
Subject: Re: ac97 oops in ali modem driver
Date: Thu, 6 Oct 2005 13:00:10 +0300
Message-ID: <20051006100009.GA32039@tecr>
References: <20051003010109.GA27888@redhat.com> <20051003143448.GA15786@tecr> <s5hy859czkw.wl%tiwai@suse.de> <20051005000132.GA23616@tecr> <s5hbr24cmlg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sa9.bezeqint.net (sa9.bezeqint.net [192.115.104.23])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9D587163
	for <alsa-devel@alsa-project.org>; Thu,  6 Oct 2005 11:44:50 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <s5hbr24cmlg.wl%tiwai@suse.de>
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
Cc: Dave Jones <davej@redhat.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11:57 Wed 05 Oct     , Takashi Iwai wrote:
> 
> The NULL ac97[] and pcm[] are referred in suspend/resume code, too.

Sure, and there are already pcm[i] and ac97[i] != NULL checkings.

> It should be fixed in your case.  Or correct codec->num_of_codecs as
> in my patch.
> 
> Anyway, I already committed my patch to ALSA CVS tree.

Yeah, I see :). Let's run your patch - my note was really cosmetic.

Sasha.

> A clean up patch is welcome, of course :)
> 
> 
> Takashi
> 


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
