From: Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: via82xx: problem with distorted sound
Date: Mon, 19 Jan 2004 21:50:51 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040119215051.56869926.mista.tapas@gmx.net>
References: <400AE538.4050306@t-online.de>
	<20040119.9110400.4016306759@linux.local>
	<400C408B.1040807@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <400C408B.1040807@t-online.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Detlef Grittner <detlef.grittner@t-online.de>
Cc: alsa-devel@lists.sourceforge.net, gustavo@compunauta.com
List-Id: alsa-devel@alsa-project.org

On Mon, 19 Jan 2004 21:39:39 +0100
detlef.grittner@t-online.de (Detlef Grittner) wrote:

> BUT:
> The problem that the sound stops when minimizing and maximizing
> windows prevails.

Interestig that you mention that. I have found that with mplayer, the
behaviour is different for sound files and video playback. I use xfce4
but i experienced this behaviour with different wm's.

soundfiles: moving, resizing windows, etc, has no effect on mplayer. the
updating of the time in the term stops, but sound playback just moves
on. same with xmms, display doesn't get updated while moving resizing
windows, but sound playback is fine.

videos: when playing back a video file with mplayer and i move/resize a
window, playback of video and sound stops until resize/move operation of
any window is finished..

I don't know what the reason for this is. Maybe the wm sends X some
message about stopping all video updates during size/move operations..
very funny..

Flo


-- 
http://www.soundclick.com/bands/9/florianschmidt.htm
http://www.arted.biz/mista.tapas


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
