From: Chris Horler <chris.horler@clara.co.uk>
Subject: Audigy extin extout module parameters
Date: Fri, 20 Feb 2004 23:03:37 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200402202303.37439.chris.horler@clara.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

I did a little browsing of the Audigy driver today.

I'm experiencing some difficulties with getting my digital output to work on 
my Audigy card.

Anyway one thing I noticed which I'm not too clear on is what happens to the 
Audigy extin, extout values.

I understand that extin and extout are a bitmask, the shifts required for each 
bit in emu10k1.h, what I'm not clear on is what happens to these bits in the 
case of the Audigy.

I think because the Audigy has more control registers (not sure that is the 
correct terminology) some of them are set by the driver automatically to 
reduce the number of options to the user.

Do I use the shifts with A_EXTIN/A_EXTOUT prefixes in emu10k1.h to calculate 
my bitmask?  

The reason I want to calculate my own bitmask is because I'm not interested in 
most of the controls on the mixer.

I have digital speakers so I thought these values would be adequate.
extin=0x0c03
extout=0x0ccf

The other thing I noticed is that the descriptions next to the values in 
emu10k1.h don't match up precisely with what appears in the mixer.  This I 
can fix if it's wrong, what I'm not clear on just to re-iterate is should I 
use A_EXTIN or just EXTIN?

Thanks,

Chris


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
