From: Joshua Haberman <joshua@haberman.com>
Subject: Re: poll_descriptors_count
Date: Mon, 1 Jul 2002 15:00:54 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020701220054.GA13325@reverberate.org>
References: <20020701171541.GA13023@reverberate.org> <Pine.LNX.4.33.0207012331310.2013-100000@pnote>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0207012331310.2013-100000@pnote>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 1 Jul 2002, Joshua Haberman wrote:
> > This gives me the impression that snd_pcm_poll_descriptors_revents() is a
> > function that somehow "summarizes" all of the pfds into a single revents
> > that speaks to the status of the entire PCM handle.

* Paul Davis (pbd@op.net) wrote:
> I don't use this function at all, considering it something of it a
> band-aid.-

* Jaroslav Kysela (perex@suse.cz) wrote:
> Yes, it translates multiple revents into one for application. Please, use
> this function for the library flexibility.

Hmm.  What do I do now?  :-)

Jaroslav, is it true what Paul says about this function not being robust
in the case of multithreaded use and poll(2) errors?  Can it be made to
be more robust?

Looking at the implementation I infer that
snd_pcm_poll_descriptors_revents() is not designed to handle pfds from
more than one stream.  Is that correct?

Josh


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
