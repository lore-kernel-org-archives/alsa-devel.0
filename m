From: Josh Haberman <joshua@haberman.com>
Subject: Re: Re: [Jackit-devel] alsa_driver_wait -> libasound?
Date: 14 Jan 2003 11:04:52 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1042571092.10955.142.camel@birdie>
References: <200301141438.h0EEcWFH028649@spider.tela.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200301141438.h0EEcWFH028649@spider.tela.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: jackit-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2003-01-14 at 06:38, Paul Davis wrote:
>  [ cc'ed to alsa-devel ]
> 
> >I think I've asked something to this effect before, but is there any
> >reason why the polling portion of alsa_driver_wait should not be in
> >libasound?  It's a very complicated piece of code that performs an
> >operation that many programs are likely to want.  What if it was written
> >as a companion function to snd_pcm_wait():
> >
> >   int snd_pcm_wait_many( snd_pcm_t **handles, int num_handles,
> >                          int timeout);
> >
> >...not that JACK would have to give up its version with extra error
> >reporting and timing, but for programs with simpler needs it would be a
> >lot nicer than having to set and test all those poll conditions for all
> >of the pfds on all the handles.
> >
> >I should probably ask this on the ALSA list, but I'm more familiar with
> >the people here.  Any reason why this couldn't go into libasound?
> 
> seems like a good idea to me, although there is a small problem. the
> current snd_pcm_wait function waits till the handles is
> readable/writable, whereas the JACK code waits till the handles all
> have a certain minimum amount of data/space.

It does?  Reading the function, I cannot find where it checks to make
sure that a minimum number of frames are available.  The main loop is
while( need_capture || need_playback ), and these two conditions are
satisfied simply by having the poll() not time out on the appropriate
pfds.  Later it checks to see how many frames are available, but never
branches based on the number.

Josh


-------------------------------------------------------
This SF.NET email is sponsored by: Take your first step towards giving 
your online business a competitive advantage. Test-drive a Thawte SSL 
certificate - our easy online guide will show you how. Click here to get 
started: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0027en
