From: knuarv@nith.no
Subject: Re: Need help with RME Hammerfall Lite (DIGI 9636) and Alsa 0.9.2
Date: Sun,  6 Apr 2003 11:23:10 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1049620990.3e8ff1fe89555@webmail.nith.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

> not sure what to say. i routinely use aplay in this to play stereo wav
> files through a 9652, an HDSP and an HDSP-9652.
This is not only happening in aplay, it also happens with the pcm test program 
(written by yourself I think?). When I change to 2 channels, no sound. Perhaps 
there's something I've done wrong, but I can't see what it should be.
 
> they are just parts of the buffers you deliver to the driver. which
> parts depends on whether you are using interleaved or non-interleaved
> access.
Ok.
I'll have another look at Jack, although I'd like to simply make Alsa work.


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
