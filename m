From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: capture buffers on SBLIVE...
Date: Sat, 29 Jun 2002 16:59:50 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0206291658100.22066-100000@cmn37.stanford.edu>
References: <3D1E09F4.46DDF834@folkwang-hochschule.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3D1E09F4.46DDF834@folkwang-hochschule.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> i'm tracking down a nasty problem i have with jack. is there any way to
> increase the periods-per-hardware-buffer setting on an sblive for
> capture ? jackd refuses to do that, and i wonder whether it's a hardware
> limitation.

Has to be, apparently the playback and record channels of the sblive are
not symetric. For recording you can only use two periods and that's it
(but for playback you can use more). I assume the alsa driver reflects the
underlying hardware as usual.

-- Fernando



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
No, I will not fix your computer.
http://thinkgeek.com/sf
