From: Ryan Pavlik <rpav@nwlink.com>
Subject: ice1712 - [multiple PCM devices, signal levels?
Date: Sat, 8 Feb 2003 23:01:14 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030208230114.0cc100cf.rpav@nwlink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

It seems like the ice1712 driver is fairly robust and has gone through
quite some development.  However, I'm a bit confused as to why there is
only one PCM device.  I have an MAudio Delta 44 card, and there are 4
DACs and ADCs.  Why aren't there at least 2 PCM devices for output?
Actually, being able to give an option for 2 stereo or 4 mono PCM
devices would be neat...

Now, I see there's some .asoundrc configuration routing...stuff, but you
can only open the card once.  It should certainly be possible given the
hardware to have pcm0 and pcm1, right?  The windows driver presents it
as this, after all. ;-)  (It'd be neat to one-up the windows driver,
too, with finer-grain control.)  This follows the same with the inputs.

Speaking of the windows driver, envy24control appears to be modelled
after the windows driver controller... which is neat, although there are
some slightly different options.  The windows version (correctly) gives
L/R and "L/R gang" to combined channels (i.e. HW0/1 and HW2/3)... not
each one individually. Also, there's a "Variable Signal Level" control
to switch each input between +4dB, -4dB, and -10dB... is it possible to
access this?  (One of my sound sources is a -10dB source.)

Thanks for the insight.

-- 
Ryan Pavlik <rpav@users.sf.net>

"Don't judge! It's *cold* out here." - 8BT


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
