From: Mark Canter <marcus@vfxcomputing.com>
Subject: Re: Re: intel 8x0 went silent in 2.6.11
Date: Tue, 8 Mar 2005 20:53:41 -0500 (EST)
Message-ID: <Pine.LNX.4.62.0503082050270.3821@krusty.vfxcomputing.com>
References: <4227085C.7060104@drzeus.cx> <29495f1d05030309455a990c5b@mail.gmail.com>
 <Pine.LNX.4.62.0503031342270.19015@krusty.vfxcomputing.com>
 <1109875926.2908.26.camel@mindpipe> <Pine.LNX.4.62.0503031356150.19015@krusty.vfxcomputing.com>
 <1109876978.2908.31.camel@mindpipe> <Pine.LNX.4.62.0503031527550.30702@krusty.vfxcomputing.com>
 <20050303154929.1abd0a62.akpm@osdl.org> <4227ADE7.3080100@drzeus.cx>
 <4228D013.8010307@drzeus.cx> <s5hmztfwon1.wl@alsa2.suse.de> <422CB68A.1050900@drzeus.cx>
 <s5hekerurz8.wl@alsa2.suse.de> <422CFB6E.1020002@drzeus.cx>
 <s5h1xaquzf0.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
In-Reply-To: <s5h1xaquzf0.wl@alsa2.suse.de>
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
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, Andrew Morton <akpm@osdl.org>, rlrevell@joe-job.com, nish.aravamudan@gmail.com, linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


I think I've gone through every possible value here from asound.state to 
each setting in KDE itself.  Still, the only sound that works is the one 
coming from line-out, without the port replicator, no sound exists 
whatsoever.  Both of the below controls are set to false in asound.state 
and cooresponding KDE settings in kmix.

I think the concern becomes though, regardless of what kde was doing after 
the fact, this condition didn't exits in <= 2.6.10 when no other 
applications where changed around it.

On Tue, 8 Mar 2005, Takashi Iwai wrote:
>
> My question is its 'value'.  The entry in /etc/asound.state should
> have a boolean value.
>
> Let me repeat the explanation of the situation:
>
> The existence of 'Headphone Jack Sense' and 'Line-in Jack Sense'
> controls themselves are not the problem.  If they are set off, the
> behavior of the driver must be identical with the older version.
> No regression. The patch I mentionted turns off them as default unless
> the device is known to work.  But the controls still exist, and you
> can change them afterward manually.
>
> So, the solution is once to turn off these controls via a mixer and
> save the state via alsactl (usually the system does at shutdown), so
> that the correct states are restored at the next reboot.  That's why I
> asked you - to check the saved status of these controls.
>
> If the correct values are saved there and still the problem exists,
> someone else must have changed the mixer status.  For example, KDE
> (kmix) seems to set up the mixer status by itself, and does not always
> correctly.  That was my suspect.  I don't know GNOME does something
> like that, too.
>
>
> Takashi
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
