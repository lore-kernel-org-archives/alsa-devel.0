From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Re: CVS compile issue
Date: Thu, 11 Aug 2005 17:13:54 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0508111711270.21860-100000@studcom.urz.uni-halle.de>
References: <s5hek905ynz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hek905ynz.wl%tiwai@suse.de>
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
Cc: Raymond <rayau@netvigator.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> Clemens Ladisch wrote:
>
> > The equivalent code in the 2.6 kernel uses #if, but that wouldn't work
> > with the SuSE kernels where HZ is a variable.
>
> How about to add #ifdef HZ and provide two version?
>
> #ifdef HZ

This wouldn't work if there is a "#define HZ some_variable".

I've now fixed it in CVS with some evil preprocessor magic.
("#if HZ > 0").


Regards,
Clemens



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
