From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Re: [Jackit-devel] alsa_driver_wait -> libasound?
Date: Tue, 14 Jan 2003 14:20:33 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301141920.h0EJKBCg014475@spider.tela.com>
References: <1042571092.10955.142.camel@birdie>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "14 Jan 2003 11:04:52 PST."
             <1042571092.10955.142.camel@birdie>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Josh Haberman <joshua@haberman.com>
Cc: jackit-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>> seems like a good idea to me, although there is a small problem. the
>> current snd_pcm_wait function waits till the handles is
>> readable/writable, whereas the JACK code waits till the handles all
>> have a certain minimum amount of data/space.
>
>It does?  Reading the function, I cannot find where it checks to make
>sure that a minimum number of frames are available.  The main loop is
>while( need_capture || need_playback ), and these two conditions are
>satisfied simply by having the poll() not time out on the appropriate
>pfds.  Later it checks to see how many frames are available, but never
>branches based on the number.

i'm sorry, you're right about that. it returns the minimum number of frames
that are available modulo the period size (i.e. the number of whole
periods that can be processed at this time, expressed in frames). this
is quite different than the current function of snd_pcm_wait(), which
merely waits till a handle is ready (or has an error) according to poll.

--p


-------------------------------------------------------
This SF.NET email is sponsored by: Take your first step towards giving 
your online business a competitive advantage. Test-drive a Thawte SSL 
certificate - our easy online guide will show you how. Click here to get 
started: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0027en
