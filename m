From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Maintaining sound card at a specific frequency
Date: Wed, 19 Jan 2005 10:07:18 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0501191004500.7621-100000@studcom.urz.uni-halle.de>
References: <5bdc1c8b050116130511757cbf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <5bdc1c8b050116130511757cbf@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Mark Knecht wrote:
> However if I open Mozilla and browse around the Pro Tools side starts
> telling me that the ADAT clock is invalid. My suspicion is that the
> web page I went to in Mozilla has some sort of audio content on it and
> it's not encoded at the frequency I'm running at so Mozilla tries to
> change the frequency of the card to adjust.

If you don't care about sound in Mozilla(/Flash), you could load the
snd-dummy driver and redirect the /dev/dsp symlink to that 'card'
("ln -sf /dev/dsp1 /dev/dsp", assuming the card number is 1).


HTH
Clemens



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
