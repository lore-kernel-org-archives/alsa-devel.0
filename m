From: William <walsac3@orthoset.com>
Subject: Re: Real-time per-note attenuation on single MIDI channel in emu10k1
Date: Fri, 10 Dec 2004 16:11:47 GMT
Message-ID: <200412101611.QAA12246@orthoset.com>
References: <Pine.HPX.4.33n.0412081909590.21064-100000@studcom.urz.uni-halle.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0412081909590.21064-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
>
> William wrote:
>> Does the emu10k1 driver have any way of doing real-time attenuation
>> for notes that are already playing at particular pitches on one MIDI channel?
> 
> The MIDI Aftertouch command should do what you want.
> See the snd_emux_key_press function.

That does exactly what I want (in kernel-space).  Thanks!

William


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
