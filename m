From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Volume per voices [Feature Request]
Date: Tue, 2 Aug 2005 16:13:08 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0508021611380.21750-100000@studcom.urz.uni-halle.de>
References: <s5hvf2pmyd8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hvf2pmyd8.wl%tiwai@suse.de>
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

Takashi Iwai wrote:
> Clemens Ladisch wrote:
> > Takashi Iwai wrote:
> > > BTW, I found your changes around IEC958 controls.  Shall we handle
> > > "IEC958 Playback Default" as PCM or mixer?
> >
> > I made those controls PCM where the SPDIF output can be directly
> > accessed as a separate stream, i.e., where the control affects the
> > data (and _only_ the data) sent through this stream.
>
> IMO, the type should be consistent.  "IEC958 Playback Default" and
> "IEC958 Playback PCM Stream" should belong definitely to IFACE_PCM.
> (So "* Mask", too.)  They don't need to be accessed through "mixer".
> It's purpose is just for the PCM.  So, converting them all to
> IFACE_PCM would be better.

But what device should those controls use when there is more than one
stream that can send data to the SPDIF output, or when there is none?


Regards,
Clemens



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
