From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Problem in testing ALSA
Date: Tue, 02 Aug 2005 23:49:56 -0400
Message-ID: <1123040996.6189.9.camel@mindpipe>
References: <20050803033745.82284.qmail@web54605.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050803033745.82284.qmail@web54605.mail.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chow Raymond <usher_raymond82@yahoo.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2005-08-02 at 20:37 -0700, Chow Raymond wrote:
> --- Lee Revell <rlrevell@joe-job.com> wrote:
> 
> 
> > No, that probably just means that the default pcm is
> > not defined.  This
> > is actually a userspace (alsa-lib) problem, it
> > sounds like the kernel
> > side might be OK.
> 
> I don't get it. Default pcm is not defined? How do i
> define it then? Does it mean that aplay cannot find
> the appropriate libraries? Besides, I do not know how
> to configure my /etc/modules.conf too since Im using
> Compulab ArmCore board. There is no built in
> soundcard. It only has built in AC97 codec.

See /usr/share/alsa/alsa.conf.  Some devices can define their own
default PCM in /usr/share/alsa/cards/*.  But I have no idea how the AC97
codec on ARM fits into this scheme.

Try aplay -D hw:0,0 file.wav.  And make sure alsa-lib is installed
properly.

Lee



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
