From: Daniel Tihelka <dtihelka@kky.zcu.cz>
Subject: Re: Build-in mixer
Date: Sat, 11 Oct 2003 17:33:28 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1065886408.3f8822c843535@webmail.zcu.cz>
References: <3F83C9B8.9050407@kky.zcu.cz> <200310081124.h98BOGqq018813@oud> <s5hsmm49bq5.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hsmm49bq5.wl@alsa2.suse.de>
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

Cituji z e-mailu od Takashi Iwai <tiwai@suse.de>:

> 
> it's becoming an FAQ... :)
> 
> pcm.!default {
> 	type plug
> 	slave.pcm "dmix"
> }
> 
> the point is '!' prefix, which means overriding the existing
> definition.
> 


As I wrote some day ago, it is possible to play two or more sounds 
simultenaously with mentioned setting. But only with 'aplay'

I tried to use xmms with ALSA 0.9 output plugin and Mplayer with ALSA-0.9.x 
support and it is impossible to play any two sound streams at the same time (i 
tried two xmms, xmms + mplayer, xmms + asound, mplayer + asound and two 
mplayers, but only the first played and the second was stopped until the first 
finished or breaked).

Where can be problem? Is it in the way, how ALSA device is opened? Must be 
device opened in a different way? Aad what about streams with different 
sampling frequencies? (I don't understand ALSA interface now, but I plan to 
learn it). 

Thank you very much,

Dan




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
