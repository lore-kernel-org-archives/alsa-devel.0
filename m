From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Re: [alsa-cvslog] CVS: alsa-lib/src/pcm
 pcm.c,1.271,1.272
Date: Tue, 02 Mar 2004 08:28:36 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0403020821310.27729-100000@studcom.urz.uni-halle.de>
References: <4043A86C.4000406@tin.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <4043A86C.4000406@tin.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Abramo Bagnara <abramo.bagnara@tin.it>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Abramo Bagnara wrote:
> Jaroslav Kysela ha scritto:
> > Log Message:
> > Fixed return comment for *near() functions
> >
> > + * \return 0 otherwise a negative error code if configuration space would become empty
>
> *near() functions semantic cannot return error by design.
>
> Taken for granted that configuration space on entry of function is not
> empty how it can become empty if I ask for *nearest* value?
>
> Obviously at least one configuration exists, then in the worst case such
> value is returned.

It may be possible that other errors than an empty configuration space
could occur.  For example, future ALSA versions might want to fail if
an hotplug device has been unpluggeed, or the configuration space
could have been reduced due to some outside influence.

I don't think we can guarantee that this function never ever fails.

Maybe we should simply drop the "if configuration space would become
empty".


Regards,
Clemens




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
