From: Lance Blisters <geoff@hurl.ugcs.caltech.edu>
Subject: 16-channel recording w/ LAYLA, ALSA, JACK, ARDOUR
Date: Wed, 12 Apr 2006 13:09:57 -0700
Message-ID: <20060412200957.GA4090@hurl.ugcs.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
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

I bought a Layla24 and Cardbus adaptor.  Works beatifully with ALSA/JACK/ARDOUR up to 8 channels.  However, the soundcard presents the 8 analog channels as device 0 and 8 digital channels as device 1.  JACK will only open one device at a time.  So in order to record 16 channels with Ardour, I apparently need to create a virtual ALSA device combining the two LAYLA subdevices.

Has anyone solved this problem for this device?  I know ".asoundrc" and 
"multi" and company, but that is far from a complete answer - what
I really need is an actual functional .asoundrc.

Please CC me, as I had to drop off the list about five years ago due to
bandwidth limitations.

Thanks,

  -geoff


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
