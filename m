From: Manuel Jander <mjander@embedded.cl>
Subject: Recording
Date: Sun, 23 Mar 2003 02:08:51 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E7D4F73.4040603@embedded.cl>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

I'm having serious trouble implementing record support into the Aureal 
Vortex driver.
I get total lockups...

The obvious answer would be: the cards overwrites your kernel :) ... but 
i double checked
that. If that would be the case, playback wouldnt work either (i would 
hear noise, or at least a crack).
I'm using the same operator functions (callbacks) for recording and 
playback with some very few
branch code to decide between record and playback.

Is there something like a typical pitfal list ? Any important difference 
when recording
instead of playback ? Can i use runtime->dma_addr just as when doing 
playback for
the DMA address programmed into the SoundCard ?

If anyone has something to say about recording, please tell me

Best Regards

Manuel Jander



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
