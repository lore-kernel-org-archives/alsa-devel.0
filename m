From: Luuk van Dijk <lvd@mndmttr.nl>
Subject: Re: full/half duplex support
Date: 19 Nov 2004 21:29:31 +0100
Message-ID: <1100896171.237.15.camel@wonder>
References: <courier.4198D349.0001155D@outpost.mndmttr.nl>
	 <s5hpt2bqosz.wl@alsa2.suse.de> <1100801204.490.4.camel@wonder>
	 <s5hd5yaavfd.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd5yaavfd.wl@alsa2.suse.de>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 2004-11-19 at 13:13, Takashi Iwai wrote:

> Hmm, I don't understand your proposal here.
> 
> AFAIUC, the problem is that the trigger callback is called twice, for
> playback and capture, on the full-duplex mode.  Basically ALSA assumes
> that the playback and the capture streams are accessible
> independently, so no such restriction is implemented (yet).

no it looks like the callback is called multiple times for the second
stream that is started.   so: hwparams() and prepare() and trigger() for
the first, say the capture substream works fine.  then I start the
playback substream.  my prepare() knows to reconfig the dma when either
channel is running, so that goes well too, and the trigger() knows that
if either substream is running it doesn't need to start the dma i/o, but
then the mid-layer queries the current dma pointer for the capture
stream with the pointer() callback, and I think it doesn't like the
answer (my interpretation), because I see that it calls trigger() again
and again.

> If my understanding is right -- I'd recommend to add a code in the
> trigger callback just to check whether another stream has been already
> triggered, then simply ignore the second trigger call.

I already did that. but it doesn't solve the problem, which I described
above.

> Also, it'd be better to provide the sync start option so that the
> full-duplex app triggers only once.

that may be a good idea, thanks so far. I'll look into it & let you
know.

R,
	L.



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
