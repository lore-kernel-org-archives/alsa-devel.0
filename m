From: "Thomas Charbonnel" <thomas@undata.org>
Subject: Re: [ANN] hdspmixer-1.1
Date: Fri, 1 Aug 2003 16:08:07 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <32930.80.11.13.118.1059746887.squirrel@www.undata.org>
References: <200307301143.h6UBhgCq019918@localhost.localdomain>
        <3F291F31.1060603@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F291F31.1060603@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: pshirkey@boosthardware.com
Cc: thomas@undata.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> Using a multiface with original firmware rev.
>
> I was using the app last night and it seemed to work well except that
> today we have only a very long blank track.
>

What do you mean ?

> Testing today with ardour reveals that the mute buttons have no effect
> on the recorded signal.
>

That's the way it's supposed to work. The app only controls routing. As
you may know there is no way to control the input level on the hdsp, no
way to lower thus to mute the input signal. So even if the input is muted,
there still is audio in the buffer which gets recorded, it's just not
routed to the outputs.

> How do the mute buttons work? I fond it difficult to distinguish between
>  on and off. Why is the default color red? Does that mean they are on by
>  default?
>

There are per tracks mute and solo, and global mute and solo buttons. To
mute a track, you need to enable muting (global button) and then mute the
particular track you want to mute. When a track gets muted (when muting is
effective somewhere) all the active mute buttons (per track and global)
light up.
The same applies to solo.

> IMO the default should be no color and when they are on they should be
> red.
>

I copied the original app behaviour for this. If you never used Totalmix
in the past I encourage you to read the Totalmix section in the Multiface
documentation available in pdf format from RME's website.
My plans for the future are to keep conforming to the original, and maybe
add non interfering linux specific extentions (e.g. ladcca support, remote
control via alsa-seq).

> I also missed a control for the headphone output.
>

In the last row (outputs), rightmost, you have the AN.L and AN.R tracks.
These are the line outs. To route signal to the line outs you have to
raise the level of the line outs (AN.L and AN.R, right mouse button on one
of them automatically ajusts the level of the other accordingly), and then
raise the volume of the track you want, checking that the track's
destination is 'Analog'.

> I also found that aplay could only work at 16 bit. I will update to
> current cvs soon to check that though.
>

This is strange. Let me know, or give me more details, please. Using the
hw alsa interface the hdsp can only be opened using all available
channels, in non interleaved mode, and with a depth of 24 bits (packed in
4 bytes). To play a 16 bits soundfile with aplay you should use the plughw
interface that will convert the signal on the fly to meet the card's
requirements.

Thomas






-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
