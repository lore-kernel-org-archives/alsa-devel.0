From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: sound recording
Date: Mon, 4 Jul 2005 18:27:02 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0507041825510.1989-100000@studcom.urz.uni-halle.de>
References: <c4357ccd050703130445674105@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <c4357ccd050703130445674105@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alexander Sirotkin <demiourgos@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Alexander Sirotkin wrote:
> On 6/30/05, Clemens Ladisch <clemens@ladisch.de> wrote:
> > Alexander Sirotkin wrote:
> > > Sound works OK except for the recording.
> > >
> > > Realtek ALC850
> >
> > What is the output of "amixer contents"?
>
> numid=37,iface=MIXER,name='Line-In As Surround'
>   : values=on
> numid=38,iface=MIXER,name='Mic As Center/LFE'
>   : values=on

Your Line-In and Mic-In jacks have been configured as outputs for 5.1
sound.  Toggle these mixer controls in alsamixer.


HTH
Clemens



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
