From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: poll_descriptors_count
Date: Tue, 2 Jul 2002 08:01:18 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0207020756030.523-100000@pnote>
References: <20020701220054.GA13325@reverberate.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020701220054.GA13325@reverberate.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Joshua Haberman <joshua@haberman.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 1 Jul 2002, Joshua Haberman wrote:

> On Mon, 1 Jul 2002, Joshua Haberman wrote:
> > > This gives me the impression that snd_pcm_poll_descriptors_revents() is a
> > > function that somehow "summarizes" all of the pfds into a single revents
> > > that speaks to the status of the entire PCM handle.
> 
> * Paul Davis (pbd@op.net) wrote:
> > I don't use this function at all, considering it something of it a
> > band-aid.-
> 
> * Jaroslav Kysela (perex@suse.cz) wrote:
> > Yes, it translates multiple revents into one for application. Please, use
> > this function for the library flexibility.
> 
> Hmm.  What do I do now?  :-)
> 
> Jaroslav, is it true what Paul says about this function not being robust
> in the case of multithreaded use and poll(2) errors?  Can it be made to
> be more robust?

Paul talks about snd_pcm_wait() function. True, it has limited 
functionality and can be used only for simple applications.

> Looking at the implementation I infer that
> snd_pcm_poll_descriptors_revents() is not designed to handle pfds from
> more than one stream.  Is that correct?

Yes, but don't look to the implementation. It can slightly change in the 
future. The wait_for_poll() function in alsa-lib/test/pcm.c does really 
the correct poll sequence, so use this code and don't try to do things 
differently than designed like Paul often does ;-)

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
