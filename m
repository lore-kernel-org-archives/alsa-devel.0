From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: HDSP Line Out Volume Control?
Date: 21 Nov 2002 14:34:44 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1037885686.7938.33.camel@satellite.undata.org>
References: <20021120151934.GA4999@dogsolitude.org>
	<3DDBFAA0.7CB10A5C@telia.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DDBFAA0.7CB10A5C@telia.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Marcus Andersson <054185595@telia.com>
Cc: drclaw@dogsolitude.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2002-11-20 at 22:12, Marcus Andersson wrote:
> Hi,
> 
> you must use the matrix mixer for this. There are no simple controls
> defined for the line out. The matrix mixer can mix any combination of
> input and playback streams to any of the outputs. This means there are
> 52x28 = 1456 control values to set.
> 
> I have not tested the matrix mixer myself, and right now I don't have my
> soundcard at home. I can do some more tests tomorrow. My guess is that
> the inputs are numbered 0-25, the playbacks 26-51. The line out signals
> have number 26 and 27. If you want to send 50% of the first and second
> playback channels to line out, you will have to set the matrix mixer
> with something like:
> 
> 26, 26, 32768
> 27, 27, 32768
> 
> It would be interesting to hear if it works. I have been thinking of
> writing a GUI to cotrol the matrix mixer. Maybe someone else has the
> same idea.
> 
> Marcus

I asked Paul once about the matrix mixer.
His answer was :

<quote>
first value: input source
second value: output source
third value: gain

input source: 0-25  (physical channels), 26-51 (audio output streams)
output source: 0-27 (physical channels)

output channels 26 and 27 are the two line outs on the I/O box.
</quote>

As Michael is stating, full volume (100% in alsamixer, or full 65536
value in the matrix mixer) causes distortion. 50%, or 32786, seems to be
the highest distortion-free value. I already mentioned this on the list
but got no answer.

I succesfully tested the matrix mixer, using both amixer and the alsa
mixer api. Here's an amixer example with the values you picked above :
amixer cset numid=5 26,26,32786
amixer cset numid=5 27,27,32786

I wanted to write a gui to the matrix mixer, but I haven't started yet
(still wondering what toolkit to use, if any, as hacking alsamixer may
be the easiest way). So far I only quickly hacked seqdemo, by Matthias
Nagorni, to control the LineOut output of the physical inputs of the
multiface with my Peavey PC 1600x fader box.
One thing that bothers me is the fact one can't get the state of the
matrix mixer, it's just possible to set it (am I wrong, Paul ?). One
other is the way to handle channels when the adat channels are used at
96Khz, dividing their number by two. One more is that matrix mixer
operation should be integrated in jack too, to handle hardware
monitoring, and that it should operate smoothly with the future matrix
gui.

Thomas




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
