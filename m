From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Re: alsa driver, repeat playback of buffer contents
Date: Tue, 15 Mar 2005 09:14:20 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0503150910010.186-100000@studcom.urz.uni-halle.de>
References: <1110846019.15588.28.camel@mindpipe>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1110846019.15588.28.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> On Mon, 2005-03-14 at 23:20 +0100, M=E5ns Rullg=E5rd wrote:
> > Lee Revell <rlrevell@joe-job.com> writes:
> > > Why in the heck are you using write() instead of mmap()?
> >
> > snd_pcm_writei() often uses mmap() behind the scenes.
>
> Right, but AFAICT mmap() should not call write() behind the scenes
> (unless you use the plug layer?).  So if you want to be sure to avoid
> unnecessary copying you should just use mmap() directly.

mmap() is only a win if the code that generates/loads the audio data
can write directly to the mapped buffer.  If the audio data is just
copied from elsewhere (i.e., with memcpy), there is no difference to
using snd_pcm_writei(), and, additionally, you can avoid having to
handle wrapping at the buffer boundary.


Regards,
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
