From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Interrupt handler
Date: Mon, 17 Mar 2003 15:22:45 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20030317152245.pochini@shiny.it>
References: <s5h1y16uphm.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h1y16uphm.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 17-Mar-2003 Takashi Iwai wrote:
> usually in the interrupt handler, you need to just send "ack" to the
> middle layer by calling snd_pcm_period_elapsed().  then, the
> middle-layer checks the current position by calling pointer callback,
> and copy/send/set-silence in the necessary area.

I didn't realize the role of .pointer callback. Tnx.

In hw_params callback I build the hardware sg list according
to sgbuf->table. Then I have to set the card to play the list
in a neverending loop and to issue an irq at the and of each
period. Is it right ?


Bye.



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
