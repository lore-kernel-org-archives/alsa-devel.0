From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Real-time per-note attenuation on single MIDI
 channel in emu10k1
Date: Wed, 8 Dec 2004 19:13:10 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0412081909590.21064-100000@studcom.urz.uni-halle.de>
References: <200412081127.LAA01444@orthoset.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200412081127.LAA01444@orthoset.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: William <walsac3@orthoset.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

William wrote:
> Does the emu10k1 driver have any way of doing real-time attenuation
> for notes that are already playing at particular pitches on one MIDI channel?

The MIDI Aftertouch command should do what you want.  See the
snd_emux_key_press function.


HTH
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
