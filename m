From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: smix plugin available?
Date: Thu, 28 Nov 2002 00:21:15 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DE4C6CB.8020407@superbug.demon.co.uk>
References: <Pine.LNX.4.21.0211271149000.2146-100000@mailserver.intern.bfad.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.21.0211271149000.2146-100000@mailserver.intern.bfad.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tomasz motylewski <T.Motylewski@bfad.de>
Cc: Jaroslav Kysela <perex@suse.cz>, Paul Davis <paul@linuxaudiosystems.com>, Florian Bomers <Florian.Bomers@sun.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

tomasz motylewski wrote:

>Please stop the complication of "available/delay" etc. Just the raw pointer.
>Each application knows where its application pointer is, so it can easily
>calculate delay/available and decide for itself whether there was an overrun or
>not.
>
>  
>
I use the delay() function.
I help write a multi media application that needs to sync audio to video.
So the question I ask alsa-lib is "If I write() now, how long will it be 
before those samples come out of the speakers?"
So, I very much need delay(), but I also use available so that I can 
program alsa when to exit the snd_pcm_wait() poll. I.E. Only exit the 
snd_pcm_wait when there are enough free space in the buffer for me to 
bother with a new write() call.

Cheers
James




-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
