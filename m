From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: EMU10K1X and MIDI
Date: Wed, 07 Jul 2004 09:14:36 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0407070905230.23857-100000@studcom.urz.uni-halle.de>
References: <40EB3852.907@nc.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <40EB3852.907@nc.rr.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Francisco Moraes <fmoraes@nc.rr.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Francisco Moraes wrote:

> Clemens Ladisch wrote:
>
> >Like opti92x-ad1848/opti92x-cs4231/opti93x, or ens1370/ens1371.
> ><nitpick>
> >But these drivers use a .c extension for this file.
> ></nitpick>
> >
> I usually don't think .c is a good extension if the file is not
> compilable by itself.

In these cases, one of the hardware models is the default if no other
has been selected with a #define.  So we would have three .c files,
each compilable by itself.

The reasons for this are purely historical; the modifications to the
'master' file were not made before the other models became known.
(But it's the same situtation with emumpu401.c :-).


Regards,
Clemens


> If someone else has an opinion, please share it before I spend
> time making the patch.




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
