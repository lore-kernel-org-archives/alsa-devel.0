From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: [alsa-cvslog] CVS: alsa-kernel/core/oss
 pcm_oss.c,1.87,1.88
Date: Fri, 27 May 2005 12:12:55 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0505271212440.1757@pnote.perex-int.cz>
References: <Pine.HPX.4.33n.0505271112380.8310-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4CD7220D
	for <alsa-devel@alsa-project.org>; Fri, 27 May 2005 12:12:57 +0200 (MEST)
In-Reply-To: <Pine.HPX.4.33n.0505271112380.8310-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 27 May 2005, Clemens Ladisch wrote:

> This still uses a misleading type for buffer_size, and uses 'frames'
> for a value not measure in frames.  I think I'd better rename these.
> Any objections?

Done.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
