From: Jeff Ballard <jeffballard@pianodisc.com>
Subject: Pitchbend issues
Date: Tue, 01 Nov 2005 13:57:41 -0800
Message-ID: <4367E4D5.1070504@pianodisc.com>
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

Hello,

I am writing a small application to playback standard midi files.  At 
this point, my program seems just about complete.  The only issue I am 
having is that pitchbends are not being played.  I have confirmed that 
the event has the correct channel and parameter value and is using an 
algorithm nearly identical to other implementations I have run across.  
The only evidence I have found is that if I artifically increase the 
bend ammount (10 times the calculated value), I can hear studdering in 
playback on that channel when the pitchbends should take place.  It 
sounds almost like the bend is occuring, but ending so quickly that it 
is difficult to hear.  Does anyone have any idea what might be happening?

Thanks
-Jeff


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
