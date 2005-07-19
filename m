From: indigo@bitglue.com (Phil Frost)
Subject: Re: need help getting echo indigo io to work
Date: Tue, 19 Jul 2005 19:14:44 -0400
Message-ID: <20050719231444.GA12052@bitglue.com>
References: <20050718154008.GA30165@unununium.org> <20050719192814.5cecf532.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-user-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20050719192814.5cecf532.pochini@shiny.it>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: alsa-user@lists.sourceforge.net
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 19, 2005 at 07:28:14PM +0200, Giuliano Pochini wrote:
> On Mon, 18 Jul 2005 11:40:08 -0400
> Phil Frost <indigo@bitglue.com> wrote:
> 
> > I recently purchaced an echo indigo io, a pcmcia sound device. I'm
> > trying to get it to work.
> > [...]
> > ALSA /.../echoaudio.c:38: firmware requested: indigo_io_dsp.fw
> > ALSA /.../echoaudio.c:41: get_firmware(): Firmware not available (-2)
> > [...]
> > I don't know much about how firmware loading should work
> 
> A script is called with the firmware name in an envronment variable and it
> searches the file with the fw and then it does cat "file > fw_sink".
> 
> > but I did
> > manage to find that /etc/hotplug/firmware.agent seems to be responsible
> > for finding the firmware. By putting some echos in there I traced what
> > it was doing, and it generates this output:
> >
> > looking for ea/indigo_io_dsp.fw-2.6.10-5-386
> > looking in /lib/hotplug/firmware
> > looking in /usr/local/lib/hotplug/firmware
> > looking in /usr/lib/hotplug/firmware
> > loading /usr/lib/hotplug/firmware/ea/indigo_io_dsp.fw
> > loaded /usr/lib/hotplug/firmware/ea/indigo_io_dsp.fw > /sys//class/firmware/0000:03:00.0/data
> >
> > So aparently, it does find the firmware and sends it off somewhere to be
> > loaded. I don't know what should happen next, or where or why it could
> > be failing. Ideas, anyone?
> 
> Hm. The part that loads the firmware is very simple: it calls
> request_firmware() and it fail if it returns an error.
> 
> Error -2 is -ENOENT (No such file or directory). request_firmware() returns
> that error code if the file has zero size of if the script aborted the
> operation. Please check if /usr/lib/hotplug/firmware/ea/indigo_io_dsp.fw is
> empty.

It's 17 kb away from empty. Also, firmware.agent seems to complete
successfuly from what I can tell. Lee Revell suggested on alsa-devel
that I should try with 2.6.12 since there have been changes in the
driver model since 2.6.10 (what i'm using). Indeed that seems to have
been the cause of the problem. With 2.6.12 I was able to play audio
nicely.

However, with 2.6.12 both support for my video hardware (radeon mobility
m6 ly on a sharp mm20 laptop) and my wireless network (prism) is broken.
I guess I have the choice between being blind or deaf. :(


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
