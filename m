From: Bill Unruh <unruh@physics.ubc.ca>
Subject: Re: cs46xx (Turtle Beach Santa Cruz), kernel 2.6 recording
 silence
Date: Sat, 14 Feb 2004 11:08:28 -0800 (PST)
Sender: alsa-user-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.50.0402141105550.16731-100000@string.physics.ubc.ca>
References: <402E6430.9050001@ics.uci.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <402E6430.9050001@ics.uci.edu>
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Joachim Feise <jfeise+alsa@ics.uci.edu>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 14 Feb 2004, Joachim Feise wrote:

> I wanted to replace my aging sbawe (which works fine with Alsa)
> with a Turtle Beach Santa Cruz card.
> I can play sound, but recording from Line-In does not work.
> I just get silence.
> The recording sw (RealProducer 8.5) uses the OSS emulation.
> It finds /dev/dsp just fine, but there just seems to be no
> data delivered on the device (btw, with devfs, /dev/dsp
> is a symlink to /dev/sound/dsp.)

a) Line in is muted
b) Line in has its amplitude all the way down.

Often it is the igain slider, not the line-in slider which controls what
the amplitude of the recorded sound is. On many(?) mixers, the line-in
slider just determines how much of the input gets delivered to the
output.

> 
> I tried using the latest drivers (1.0.2c), and the cvs version,
> but no change.
> 


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
