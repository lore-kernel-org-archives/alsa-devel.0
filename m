From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH]usx2y: prevent oops & dead keyboard on hot
 usb unplugging
Date: Fri, 15 Apr 2005 18:25:15 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0504151822220.5917-100000@studcom.urz.uni-halle.de>
References: <s5hmzs0ca43.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hmzs0ca43.wl@alsa2.suse.de>
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
Cc: karsten wiese <annabellesgarden@yahoo.de>, Devel Alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> karsten wiese wrote:
> > (-: You apply my patch now?
>
> No, not enough :)  This is exactly why snd_card_free_in_thread() was
> introduced.
>
> As I asked, please make sure that the files are all released before
> snd_card_free().  Otherwise the disconnect callback hangs at this
> point because of this check.

Most programs close the device file when an error occurs, so you have
to test it with something like this to keep the file open:

#include <stdio.h>
int main()
{
  fopen("/dev/snd/hwC1D0", "rb");
  getchar();
}


Regards,
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
