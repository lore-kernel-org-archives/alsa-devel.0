From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: dB gain
Date: Tue, 30 May 2006 21:49:28 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0605302141510.9178@tm8103.perex-int.cz>
References: <4478A290.80702@superbug.co.uk> <s5hverp7zcr.wl%tiwai@suse.de>
	<447B0A19.2050408@superbug.co.uk> <s5hy7wkddyf.wl%tiwai@suse.de>
	<447B308E.2050502@superbug.co.uk> <s5hirnod7l2.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0605292017280.11164@tm8103-a.perex-int.cz>
	<447C962E.3010103@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0FFE5140
	for <alsa-devel@alsa-project.org>;
	Tue, 30 May 2006 21:49:29 +0200 (MEST)
In-Reply-To: <447C962E.3010103@superbug.co.uk>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 30 May 2006, James Courtier-Dutton wrote:

> So, from what I can see, there have been no real reasons why I should
> not commit my db gain code now.

I would suggest to reduce the driver code (remove TLV parsing) and create 
two ioctls (one global and one numid based). Or we can even add the global 
ioctl later and parse TLV in driver, when we add something else to TLV.
This means that the ioctl semantics will change from "operate with TLV"
to "gather all possible information to TLV" which is all we need now.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
