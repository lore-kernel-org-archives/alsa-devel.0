From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Bug in sis7012 driver - or probably I'm doing
 something wrong ?
Date: Tue, 06 Apr 2004 09:44:03 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0404060939050.17488-100000@studcom.urz.uni-halle.de>
References: <007001c41a7e$b0125750$6500a8c0@Lapitopi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <007001c41a7e$b0125750$6500a8c0@Lapitopi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Robert Rozman <rozman@fri.uni-lj.si>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Robert Rozman wrote:
> I've got advice how to use this 6 channel device as 3 stereo channels but
> there seems something not to be right (it could be my mistake).
>
> I have /etc/asound.conf :
>
> pcm.a {
> type plug
> slave.pcm ch12
> }
>
> pcm.b {
> type plug
> slave.pcm ch34
> }
>
> Now I do:
>
> - alsaplayer with mp3 file on device plug:a

"a" is already defined as a plug plugin on top of "ch12", it's exactly
the same as "plug:ch12".  Adding another plug layer ("plug:plug:ch12")
wouldn't make much sense.

> - aplay -D plug:ch12 (funny is that plug:a doesn't work)
> - everything is ok and mixed properly
>
> - but if I start another alsaplayer on plug:b (probably also plug:c would be
> the same), then aplay produces sound that is "interleaved" in short chunks
> and also sound from alsaplayer on plug:b is also heard in addition to
> original mp3 and aplay sound.

Please try the a,b,c pcm devices without the "plug:" prefix.

Does it work if you run aplay on devices a and b?


Regards,
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
