From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: How to tell how many frames gone to PCM
Date: Tue, 26 Apr 2005 17:17:09 -0400
Message-ID: <1114550230.8431.45.camel@mindpipe>
References: <426EA20A.70403@pianodisc.com>
	 <1114546574.8431.13.camel@mindpipe>  <426EADA7.4090200@pianodisc.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <426EADA7.4090200@pianodisc.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Steve deRosier <derosier@pianodisc.com>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2005-04-26 at 14:07 -0700, Steve deRosier wrote:
> Any more ideas would be great.
> 

One possibility is that you are hitting an ALSA bug.  Some fixes have
been merged since ALSA 1.0.8 for bugs that could account for the strange
behavior.  The first thing to do is verify the problem does not appear
with a newer ALSA.

Another idea, by default the MIDI timing will be driven by the system
timer, while the PCM will be driven by the soundcard timer, even if your
MIDI port is on the same board as your audio.  Although I would expect
the drift to be very small.

As a last resort, you could hack the low level driver to keep track of
the frames written to the hardware.  Add a counter to the chip structure
and increment it in the interrupt handler.

Lee



-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
