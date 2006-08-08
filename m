From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: pcm_multi poll timeout error
Date: Tue, 08 Aug 2006 08:35:59 +0200
Message-ID: <1155018959.29357.267870152@webmail.messagingengine.com>
References: <20051209171605.GA4132@localhost.localdomain>
	<200512091755.jB9HtR5i008279@sith.maoz.com>
	<20051209201502.GA3751@localhost.localdomain>
	<s5h4q5ezh4e.wl%tiwai@suse.de> <1154397867.14540.5.camel@mindpipe>
	<s5hmzao91nj.wl%tiwai@suse.de>
	<20060806150349.GA3461@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20060806150349.GA3461@localhost.localdomain>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: John Rigg <ad@sound-man.co.uk>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

John Rigg wrote:
> On Tue, Aug 01, 2006 at 12:43:44PM +0200, Takashi Iwai wrote:
> > John, could you check whether the problem still appears with the
> > latest ALSA HG version, especially with alsa-lib?  I remember that
> > some fixes have been done on multi plugin.
> 
> The problem still appears with alsa-lib-1.0.12rc2 version. There are
> no changes in pcm_multi since 1.0.11.

I can reproduce this problem.  It seems to be a bug in the multi plugin.

snd_pcm_multi_start() does not call snd_pcm_start() for any of its slave
PCMs that are linked to another, i.e., for slaves where the 'linked'
field in the slaves array is set.

snd_pcm_multi_hw_params() sets 'linked' for all but one of the slaves.
snd_pcm_multi_link_fd(), however, sets 'linked' for all its slaves, and
gets called for both the playback and capture PCMs in the full duplex
case.

This means that none of the slave PCMs ever gets started.  After jackd's
snd_pcm_start() call, the state is still PREPARED.


Regards,
Clemens
-- 
  Clemens Ladisch
  cladisch@fastmail.net


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
