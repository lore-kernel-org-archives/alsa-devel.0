From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Mixer control elements.
Date: Fri, 11 Oct 2002 12:45:11 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DA63B37.5020109@superbug.demon.co.uk>
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
I was wondering how easy it would be to add a classification to each 
control element. (switches, volume, capture on/off etc.)
The classification would be as follows: -
1) Used during capture. I.E. Switches and volume controls for anything 
one can record.
2) Used during playback. I.E. Switches and volume controls for anything 
one can play.
3) General control. I.E. Hardware config. E.g. The SB Live 
Digital/Analogue switch for Digital SPDIF out/Analogue Center and LFE 
audio out.

Then have alsamixer be able to filter the display using these 3 categories.
User presses a key, and alsamixer displays only the controls used to 
effect sound playback.
User presses another key, and alsamixer displays only the controls used 
to effect sound recording.
User presses another key, and alsamixer displays only the controls used 
to do other stuff.

This sort of functionallity could help users understand what each 
control does better.
In my view the SB Live has so many controls, it is very difficult to 
sort out which ones to use.

Currently, alsamixer seems to link playback and record volumes, that 
should be separate.

Cheers
James





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
