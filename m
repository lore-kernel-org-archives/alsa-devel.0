From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Lots of BUG alerts with latest CVS and Audigy2
Date: Fri, 11 Mar 2005 19:08:46 -0500
Message-ID: <1110586126.19972.6.camel@mindpipe>
References: <20050311235606.71286.qmail@web52906.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050311235606.71286.qmail@web52906.mail.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chris Rankin <rankincj@yahoo.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-03-11 at 23:56 +0000, Chris Rankin wrote:
> Yes, I was using the wavetable synth. (Try the game for yourself..)
> 

OK.  I don't have Wine set up, so that's not a trivial undertaking.

But, if this message is only showing up in conjunction with using the
wavetable synth, and never appears with regular PCM, then it's OK.  The
synth will grab all the available voices, then if PCM needs them they
are reclaimed.

I will submit a patch to silence it.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
