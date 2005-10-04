From: Dave Jones <davej@redhat.com>
Subject: Re: Re: [ALSA] snd-emu10k1: ALSA bug#1297: Fix a error recognising the SB Live Platinum.
Date: Mon, 3 Oct 2005 20:54:01 -0400
Message-ID: <20051004005401.GC10697@redhat.com>
References: <7a5967f2d895440aa1ca2fa1d201c380@pobox.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EEDA31B9
	for <alsa-devel@alsa-project.org>; Tue,  4 Oct 2005 02:54:05 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <7a5967f2d895440aa1ca2fa1d201c380@pobox.sk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Zubaj <pzad@pobox.sk>
Cc: alsa-devel@alsa-project.org, James@superbug.co.uk, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 03, 2005 at 08:23:28AM +0200, Peter Zubaj wrote:
 > AFAIK this was fixed in CVS. Two cards have same model id (one has AC97, one not).
 > 
 > Fix:
 > 
 > http://sourceforge.net/mailarchive/forum.php?thread_id=8360485&forum_id=33141
 > 

>From the look of that patch, this will just print
"emu10k1: AC97 is optional on this board Proceeding without ac97 mixers..."
and do nothing about actually making things work for people again,
or even to suggest what they can do to work around this situation
when their volume control breaks.  At the least this sounds like it
needs to mention a module parameter to force ac97 support.

What actually happens if we set ac97_chip=1 on the boards that
don't have it ? Is it purely a cosmetic thing, showing some
sliders that do nothing?

		Dave



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
