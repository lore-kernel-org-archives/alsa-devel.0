From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Problems with snd-intel8x0
Date: Tue, 13 Apr 2004 18:13:04 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0404131811180.10741-100000@studcom.urz.uni-halle.de>
References: <94de2d94ee62.94ee6294de2d@southeast.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <94de2d94ee62.94ee6294de2d@southeast.rr.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: dlbarron@nc.rr.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

dlbarron@nc.rr.com wrote:
> I have a home-bilt computer using an MSI 865PE Neo 2 motherboard.
> I've booted with xnoppix and it detects the sound card as
> intel8x0, so that's what I'm trying to get going using alsa.
>
> So lately I've been trying to use alsa and I'm stuck.  I do not
> get any errors at all, in fact it looks like sound is working
> fine, but I never get a peep out of my speakers.

Probably you didn't unmute and raise the volume of all appropriate
controls in alsamixer.

What codec do you have (second line at top alsamixer screen)?
What are the contents of /etc/asound.state after running
"alsactl store"?


Regards,
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
