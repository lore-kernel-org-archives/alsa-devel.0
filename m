From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: How do I make -D hw:0,1 default?
Date: Tue, 3 Jun 2003 20:28:51 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306032028280.1174-100000@pnote.perex-int.cz>
References: <NDBBLGIKBJENLAMOLFHGEEAJCGAB.mknecht@controlnet.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <NDBBLGIKBJENLAMOLFHGEEAJCGAB.mknecht@controlnet.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <mknecht@controlnet.com>
Cc: Alsa-Devel <Alsa-Devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 3 Jun 2003, Mark Knecht wrote:

> Hi,
>    Yesterday evening I found that I could use aplay -D hw:0,1 and get sound
> out of Alsa. This was cool, but I don't normally do anything with aplay.
> Other apps that use sound are still locking up hard.
> 
>    I thought the .asoundrc file was supposed to make this happen
> automatically, but apparently the one on the sound card page at the Alsa
> site does not do this for me. Can someone tell me how to make this the
> default?
> 
> .asoundrc from Alsa site:
> 
>         pcm.via82xx {
>            type hw
>            card 0
>         }
> 
>         ctl.via82xx {
>            type hw
>            card 0
>         }
> 
> Maybe I need to include the ',1' interface somehow? How would I do that?

Add 'device 1' to {} section.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
