From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: changed snd_pcm_close() behaviour
Date: Wed, 26 Jun 2002 22:42:42 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0206262242370.795-100000@pnote.perex-int.cz>
References: <3D1A081D.C1D86EE9@alsa-project.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3D1A081D.C1D86EE9@alsa-project.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Abramo Bagnara <abramo@alsa-project.org>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 26 Jun 2002, Abramo Bagnara wrote:

> Jaroslav Kysela wrote:
> > 
> > Hi all,
> > 
> >         after discussion with Takashi and others on this list, the
> > behaviour of snd_pcm_close() function has been changed in this way:
> > 
> > The stream is stoped and all samples (if any) are droped. It means, that
> > if the user space code wants to flush samples to output, the
> > snd_pcm_drain() function must be called before the snd_pcm_close() call.
> > 
> >         I hope that this change doesn't cause any problems in any
> > application. Anyway, please, report all problems.
> 
> Please don't forget to fix alsa-oss.

Done.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
