From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: mixer: multi-channel volume controls.
Date: Sat, 13 Sep 2003 03:50:19 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F6285EB.1080907@superbug.demon.co.uk>
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

If one is outputing 5.1 audio, and one wishes the adjust the volume, one 
currently has to adjust 4 sliders. (Front stereo or Master/PCM, Surround 
stereo, Center, Lfe.).
I think that is would be really good if the Master volume control was 
abstracted. So, for example, mixer controls changed to: -
front (instead of master, to match the current PCM device name front)
rear (instead of surround, to match the current PCM device name rear)
center_lfe (to match the current PCM device name center_lfe)

And then in alsa.conf, be able to configure a "master" volume control, 
that would change front,rear,center_lfe together.
Moving the "master" volume control should not adjust the values of the 
front,read,center_lfe mixer levels visable to the user, but instead do 
calculations behind the scenes to set the hardware registers to output 
sound as the user would expect it to appear by viewing the sliders.

Without this abstraction, if the user changed the "master" to minimum 
position, and then adjusted back to max, the relative positions of 
front,read,center_lfe mixers would get forgotten.

Cheers
James




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
