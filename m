From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Exiting from snd_pcm_wait or snd_pcm_write.
Date: Sun, 06 Apr 2003 21:25:06 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E908D22.5070603@superbug.demon.co.uk>
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

Hi all,

If I have an application running 2 or more threads.
Thread 1 is currently calling snd_pcm_wait() waiting for enough 
availiable space to appear in the sound buffer.
Thread 2 wants to stop thread 1 doing that( abort the snd_pcm_wait() 
call), and then wants thread 1 to restart with new data.

Can Thread 2 just call snd_pcm_drop() while thread 1 is calling 
snd_pcm_wait() ?
What about Thread 2 calling snd_pcm_reset() while thread 1 is calling 
snd_pcm_wait()?

We basically want the user seeking through an audio stream.
So, as the user seeks across the stream, a few audio frames/clippets of 
sound are played as one goes.
So, basically, the user is continually changing the source of samples 
being sent to the audio card.
In order for this changing to happen quickly, we need the some way to 
safely abort the snd_pcm_wait() and snd_pcm_write() calls.

Can we do this?

Cheers
James




-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
