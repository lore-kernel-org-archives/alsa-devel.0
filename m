From: AthlonRob <athlonrob@data.4t3.com>
Subject: More nForce stuff
Date: 14 Oct 2002 11:22:04 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1034619724.1330.4.camel@duron>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I still really think my nForce chip does support hardware mixing... 

I see in alsamixer, three things at the end that I wonder may be a sign
the chip supports hardware mixing?

I have Mix, Mix Mono, and External.  Those are the names of the things.

The 'Item' field lists External as being 'External Emplifier Power Down'
... that item can be muted.  None of the three items can have the volume
set on them (they're all blank) but the last one can be muted.

The 'Chip' listed for my 'Card' (NVidia NForce) is  Chip: Analog Devices
AD1885 if that makes any difference for the whole thing.

Does this imply that the card does have hardware mixing capabilities...
or does it still mean I'm SOL as far as playing multiple audio streams
at once?

To further test it, would it be a complicated thing to enable hardware
mixing in the drivers just to see if it works?  I really doubt it is and
would rather suspect such things need to be set up for the specific
card/chip in question rather than being some generic 'put these 10 lines
of code in there' thing.

Help would be appreciated greatly...  I really need to play multiple
audio streams!  :-)

Rob



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
