From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Question Regarding Simple ALSA Stereo Output
Date: Wed, 23 Jun 2004 18:10:03 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0406231743130.16948-100000@studcom.urz.uni-halle.de>
References: <Pine.GSO.4.58.0406231129100.6839@blue.cs.yorku.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <Pine.GSO.4.58.0406231129100.6839@blue.cs.yorku.ca>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Bill Kapralos <billk@cs.yorku.ca>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Bill Kapralos wrote:
>                 name 'Master Playback Switch'
>                 value true
>                 name 'Master Playback Volume'
>                 value.0 63
>                 value.1 63
>                 name 'Headphone Playback Switch'
>                 value true
>                 name 'Headphone Playback Volume'
>                 value.0 31
>                 value.1 31

Looks OK.

>                 name 'Master Mono Playback Switch'
>                 value true
>                 name 'Master Mono Playback Volume'
>                 value 31

Try muting this.

>  Chip: Analog Devices AD1881

This chip has some funky features to allow different sample rates for
left and right channels.  Please show the contents of
/proc/asound/card0/codec97#0/ac97#0-0+regs.


Regards,
Clemens




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
