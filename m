From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Suggestion: Multichannel enharnacements to alsa-lib.
Date: Wed, 02 Oct 2002 17:44:59 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D9AA3FB.5000104@superbug.demon.co.uk>
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
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello
It would be nice if there was a feature in alsa that would let the user 
tell alsa which speakers are plugged into which sound card sockets.
E.g. On sound card 0, I have: -
Left speaker in Stereo Jack 1-Left
Right speaker in Stereo Jack 1-Right
Rear Left in Stereo Jack 2 - Left
Rear Right in Stereo Jack 2 - Right
Center in Stereo Jack 3 - Right
LFE in Stereo Jack 3 - Left.


This would tell alsa-lib that if it was sent 5.1 channel audio, it would 
not change it.
If it was send 2-channel PCM, it would up-mix it using the dolby 2->4 
channel sound method and also generate the Center and LFE channels.

If the user did not have 6 speakers, they could tell alsa :-
Left speaker in Stereo Jack 1-Left
Right speaker in Stereo Jack 1-Right
LFE in Stereo Jack 2 - Left.

alsa-lib would then accept 6 channels from the user's application and 
automatically downmix it for the 3 speakers the user had.
The user could also have 2 sound cards, with Front speakers on one sound 
card, and rear speakers on another sound card.

Another feature for alsa-lib could be adding volume and delay controls in.
For example, the user might want to adjust the volume of the LFE without 
changing the volume of the other channels.
Also, depending on where the speakers are in the room, the user might 
want to add certain delays to certain channels so that the sound is in 
sync when it gets to the user's ears.

The reason I think that this would be good to have in alsa-lib is so it 
would only have to be implemented once, and then all audio applications 
could use the features.

I am currently helping to write a media application in linux that plays 
DVDs that have 5.1(e.g 6 channels) audio tracks. It would be nice if my 
audio application did not have to care about what speakers the user has, 
and just output 6 channels every time and let alsa-lib adjust. Also, if 
I used another audio application that could play CD-Digital Audio, 
alsa-lib could automatically upmix it to 5.1 using dolby surround 2->4 
upmix, and alsa-lib could then fill in the center and lfe channels. This 
way, all the current linux applications that use ALSA would not have to 
be changed, but the user would get much better sound output as alsa-lib 
would convert the sound to make full use of the users speaker layout.

Supported speaker formats needed are: -
1) Center (Mono)
2) Front Right, Front Left. (Stereo)
3) Front Right, Front Left, Center (3 Channel front.)
4) Front Right, Front Left, LFE (3 channel front/LFE)
5) Front Right, Front Left, Rear Right, Rear Left (4 channel front/rear)
6) Front Right, Front Left, Center, Rear Right, Rear Left (5 Channel 
front/rear/center)
7) Front Right, Front Left, Rear Right, Rear Left, LFE (5 Channel 
front/rear/LFE)
8) Front Right, Front Left, Center, Rear Right, Rear Left, LFE (6 
channel "5.1")
9) Future setups with maybe 7,8 or 9 speakers  for home real cinema 
setups. DTS 6.1 etc.

Cheers
James




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
