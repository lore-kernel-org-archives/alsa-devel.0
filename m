From: Cournapeau David <cournape@atr.jp>
Subject: [alsa-dev]Question regarding period/buffer and error handling
Date: Fri, 28 May 2004 10:34:07 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40B6970F.90507@atr.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: ALSA LIST <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi there,

    For my research, I need to use audio with matlab under linux, and 
sound support of matlab is kind of... well, crappy (basically, it is 
opening the /dev/audio file and write to it; on my computer, it doesn't 
seem to work). That's why I am thinking about using a wrapper to alsa.
    Thanks to some tutorials (by the way, thanks for your tutorial, 
Paul), I managed to play sound with matlab and alsa, but I would like my 
wrapper to be full proof against errors. Basically, here is my method :

    - parse the input arguments, convert from matlab representation to 
'normal C' representation (that is, vectors of double for samples).
    - To see if any soundcard is present, I am using 
snd_card_next(card), with card value to -1.
    - I allocate memory for a snd_pcm_hw_params_t structure, open a pcm 
device in NON_BLOCK_MODE, set the mode to blocking mode, set the format 
(16 bits LE), sampling rate, interleaved format and number of channels
    - I write to the pcm device using writei.

    My first problem is with writei: I cut my audio input in blocks of a 
small size before sending them to writei( blocks are 1024 frames long, 
for example), and depending of the sampling rate, writei doesn't write 
the whole block. For example, at 44100 Hz, if the block is 1024 frames 
long, only the 940 first frames are written. I think this problem is 
related to period size and so on, but I don't really understand the 
differences between period and buffer. Where can I find some 
informations about that ?
    My second problem is related to snd_card_next: If the card value 
returned by snd_card_next is different from -1, does that always mean 
than a alsa audio device is present on the system ? Is it the best 
method to probe a soundcard with alsa support?
    My third problem is related to the error handling: right now, with 
some hack, my wrapper works. But if I stop the wrapper with ctl+C, the 
pcm device is not closed properly, which means I cannot use the pcm 
device again (except by closing matlab and launching it again....). Is 
there a way to close the pcm device before opening it ? ( I first 
thought about catching the ctrl+C 'signal' from matlab in my wrapper, to 
exit cleanly, but for now, I didn't find any way to do it).

    Thank you,

    David


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
