From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: How to debug ?
Date: 02 Apr 2003 00:17:49 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1049242674.26708.47.camel@Jay>
Mime-Version: 1.0
Content-Type: text/plain
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


> My driver do not work anymore with xmms (alsa-xmms plugin) and
> alsaplayer. [...]

I tried to force the alsaplayer plugin to set S16_LE format (data is BE
on powerpc) and it do not spit that errors anymore, but it do not play
anything and in the logs alsa prints:

ALSA ../alsa-kernel/core/pcm_lib.c:2219: BUG? (substream->ops->copy !=
((void *)0) || runtime->dma_area != ((void *)0)) (called from d2040794)
last message repeated 11886 times

I don't set .copy callback and ->dma_area should be 0 because the card
uses a sg-list. #:(

Bye.




-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
