From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Patch to fix Pax/Grsecurity Problems
Date: Mon, 26 Jan 2004 14:45:49 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0401261439360.24795-100000@studcom.urz.uni-halle.de>
References: <s5h4qumwmha.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <s5h4qumwmha.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: siti_veni@lycos.com, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Stephen Cook wrote:
> >
> > >> -	qsort(hctl->pelems, hctl->count, sizeof(*hctl->pelems), compar);
> > >> +
> > >> +	pthread_mutex_lock(&sync_lock);
> > >> +	compare_hctl = hctl;
> > >> +	qsort(hctl->pelems, hctl->count, sizeof(*hctl->pelems), hctl_compare);
> > >> +	pthread_mutex_unlock(&sync_lock);
> >
> > I hope I don't sound to persistent but I am just wondering when this
> > patch is going to be merged or if there is anything I can do to help
> > speed it up.  Such as any changes to the patch etc.
>
> well, i'm also waiting for the response from others.

Looks fine.

We're already dependent on pthreads, and qsort doesn't pass extra
parameters, so I don't see any better way to do this.
("Let's write our own sorting routine" is not better IMNSHO.)


Regards,
Clemens




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
