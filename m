From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: MIDI getting killed by Jack?
Date: Thu, 11 Sep 2003 09:13:51 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGEEAFDDAB.mknecht@controlnet.com>
References: <Pine.HPX.4.33n.0309111623030.20181-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0309111623030.20181-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Alsa-Devel <Alsa-Devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


>
> AFAIK tasklets have higher priority than any user thread.
>
> From the error description I diagnose that either MIDI interrupts or
> the MIDI tasklet are suppressed while jack is running. It shouldn't be
> possible to prevent a tasklet from running unless the CPU usage is
> 100%, so I think it's somehow related to interrupts.
>
> Maybe the hardware doesn't set (or clears) the MIDI bit when too many
> PCM interrupts occur, but I'm just guessing here.
>
>
> Regards,
> Clemens

Hi,
   I wanted to remind people that the version of Alsa that I am using is
0.9.6, but the hdsp 9652 driver is not the one in CVS. It's the one Thomas
developed remotely at his place and has been tested on my machine and
possibly a few others. I think a patch was supplied to asla-devel but I'm
not sure about that. To the best of my knowledge Thomas didn't do any
editing on the MIDI side of things, but we didn't talk about that level of
detail much.

   I just didn't want anyone to be surprised later if it turns out it has
something to do with the audio side of the hdsp 9652 driver.

- Mark




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
