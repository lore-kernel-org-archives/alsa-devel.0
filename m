From: Eric Klein <eklein@ait.nrl.navy.mil>
Subject: Accessing all 8 channels on a Audigy 2 card
Date: Fri, 18 Jun 2004 16:35:25 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40D3520D.4040602@ait.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hello,

I've been trying for the last few days to use ALSA to access all 8 
channels independently on an Audigy 2 card (7.1). I can certainly use 
aplay to play a stereo file, and sound will come out of all 8 channels, 
but if I want to independently address those 8 channels (such as with 
the speaker_test app), I can't find a way to do it.

I've of course found the surround51 stuff for working with 5.1 data, and 
therefore getting access to at least 6 of the available channels. What 
I'm not certain about is how to gain access to to the side channels in a 
7.1 config. I can see that the surround51 config (within the 
Audigy(2).conf file) uses the front, rear and center_lfe pcm configs, 
and combines them into a single config. It seems like it might be 
possible to do something similar with creating a config for the side 
channel, but I'm not sure.

Anyway, I've been looking everywhere that I can think of, but I haven't 
yet found a way to do this. If anyone has done this, or has any 
suggestions on how to do it, please let me know.

Regards,

Eric Klein
eklein@ait.nrl.navy.mil



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
