From: Mark Rages <markrages@mlug.missouri.edu>
Subject: Re: DTMF recognition
Date: Thu, 25 Jul 2002 14:26:20 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020725192620.GA16882@mlug.missouri.edu>
References: <200207251412.59730.do1ypv@linux> <E17Xjod-0005Qf-00@usw-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <E17Xjod-0005Qf-00@usw-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: Philipp Vollmer <vollmer.philipp@t-online.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 25, 2002 at 10:45:27AM -0400, Paul Davis wrote:
> >Hello to all,
> >
> >who has already done DTMF recognition with ALSA ( OSS )?
> >I searched for examples in google, but I have found that
> >only in TODO lists ;-(.
> >
> >Is this so difficult or why doesn't exist anything about that?
> 
> its a relatively trivial FFT problem. use FFTW to analyse the signal,
> then look for two predominant frequencies, and check their values
> against a table.
> 

This is hardly an ALSA problem... linux-audio-devel maybe?

I have some Matlab/Octave code to do this. I wrote it for a DSP class.
I used the Goertzel algorithm. I could actually get pretty good rejection 
of false activation this way.

Email me if you want the code.

Regards,
Mark Rages
markrages@mlug.missouri.edu





-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
