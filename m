From: Petr Gladkikh <batyi@mail.ru>
Subject: alsa-lib: Volume control emulation plugin
Date: Sat, 18 Dec 2004 23:10:50 +0600
Message-ID: <41C4649A.9090608@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hello.

I have on-board sound card which has been mentioned for example in bug
"[ALSA - driver 0000725]: Intel8x0, chip CMI9761A - no volume control, 
sound mixer broken"
AFAIK this sound card indeed has no hardware PCM volume control and its 
"Master" volume control affects only sound which comes from analog 
inputs. IMHO following solutions which were offered elsewhere look not 
very elegant (at leas for me ;)
1. "I suggest that forget the mixer and tune the speaker volume."
2. "To reduce the volume, decrease the output level in the application." 
(I just unable to rewrite every application I need)
3. "use Intel8x0 driver and an extra sound demon (e.g. KDE's artsd)"
4. "use CMedia's OSS driver (avail. at 
http://www.cmedia.com.tw/download/e_UDA9738_linux_01.htm)"
5. "curse CMedia for building such a crappy chip; curse them again for 
not releasing an ALSA driver; curse NVidia for using such a crappy chip 
(older nforce boards had a better chip on-board..); in the end, buy an 
extra sound card and be happy :)"

It seems then that the right solution is to write an ALSA lib plug-in which
1. Accepts input in some format and puts it out being multiplied by some 
coefficient 0.0..1.0
2. Provides software emulated volume control which can change the 
coefficient (so ALSA applications can use it)

"route" plug-in is almost there but it allows to set volume in 
configuration file not dynamically, and I do not know how to emulate 
volume control in ALSA lib with it.

So here is the question: does anyone have written/going to write such 
plug-in? If so how can I help to make it happen (testing, write some 
code)? (I do not have experience with ALSA to write it completely by 
myself).

BTW I was unable to read bug track database even for read-only due to 
denied access. Is there any anonymous access?

/ Petr Gladkikh





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
