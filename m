From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Mixer functions
Date: Sat, 04 Oct 2003 15:39:52 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F7EDBB8.30900@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

With 5.1 channel sound being used quite a lot now, I was wondering what
to do about volume controls.
For example, I have: -
Front speakers controlled by PCM and Master slider.
Rear speakers controlled by Surround slider
Center controlled by Center Slider
LFE controlled by LFE slider.

I would assume that a "Master" slider would control all 6 channels at
the same time.
So, in this setup, the Master slider is not actually acting as a Master,
but instead, only a Front speaker control.

I suggest that in these cases, "Master" gets renamed to something else,
and then alsa-lib takes over providing a "Master"
alsa-lib could then also use config files, to define the mixer elements.
We could then provide mixer elements that do proper "Master",
"Front/Rear Fader" etc.

I know you said earlier that you are in the process of developing a
better mixer, possibly having 0db points etc.
Could you add these suggestions, so that they are possible as well.

Another problem I have come across, is that some sound cards have a
headphone amplifier on the front speaker output, and some sound cards
have a headphone amplifier on the rear/surround outputs.
E.g. ALC650 has headphone on front output.
AD1985 has headphone on surround (but is switchable to front).
Does anyone know if the AC97 standard is headphones on front, or
headphones on rear/surround ?
I was talking to a user who has sound coming out of a speaker output,
but not the headphone or center/lfe outputs, also the slider name
controlling the speaker output was "surround".
It would be nice to find out from yourselves what the AC97 standard says
it should be, and I will then post a PATCH to get the AD1985 to act in
the same way as all other sound cards.

Cheers
James





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
xine-devel mailing list
xine-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/xine-devel





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
