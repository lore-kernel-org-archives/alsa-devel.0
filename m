From: "Ron Cococcia" <ron.cococcia@request.com>
Subject: Disabling onboard codec
Date: Thu, 1 Apr 2004 15:28:38 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E1B98oP-0006rr-H4@sc8-sf-mx1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This might not be entirely alsa devel related, but it doesn't fit alsa user
either.  I figured I'd ask anyway...

In a setup I'm working with, I have a motherboard (815 w/82801BA-ICH2) that
has an onboard/primary (00) AC97 codec (AD1885).  We've been playing around
with adding a CNR card that would have a different/secondary (01) codec on
it (CS4299).  I had used the gnome-alsamixer to set the volumes, and I see
"AD1885/CS4299" in the mixer control.  I can play music out either of the
outputs if I wanted to, but unfortunately, it's not.

The onboard chip is generating (I think) a BIT_CLK signal, and (I think) the
CNR is as well (it's wired to an oscillator).  I'm worried that both chips
generating a BIT_CLK might cause jitter, and could cause audio quality
issues.  What I'm looking to do is somehow disable the main (AD1885) codec
programmatically if possible, so it isn't generating a BIT_CLK signal, and
it more or less disappears.

I appreciate any ideas you may have.  I understand that this isn't entirely
the focus of the group, but I know that some of you have worked with this
stuff for a while and may know how.

TIA,
Ron




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
