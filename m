From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Lots of BUG alerts with latest CVS and Audigy2
Date: Fri, 11 Mar 2005 14:35:53 -0500
Message-ID: <1110569754.18889.5.camel@mindpipe>
References: <20050311001056.21034.qmail@web52903.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050311001056.21034.qmail@web52903.mail.yahoo.com>
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

On Fri, 2005-03-11 at 00:10 +0000, Chris Rankin wrote:
> Hi,
> 
> I don't know what this means, but it's a very persistent error!
> 
> Mar  9 23:06:22 volcano kernel: BUG (or not enough voices), number 1, next free 30!

Please try a newer CVS checkout (from today or tomorrow).  I believe the
"Oops in emu10k1_efx_playback_prepare" bug could have also caused this
error.

Also, the above error message is a little buggy, as the condition does
not always represent an error.

Were you using the wavetable synth at the time?

Also, if you get the error again please post the contents
of /proc/asound/card0/voices.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
