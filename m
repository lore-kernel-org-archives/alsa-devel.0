From: Giuliano Pochini <pochini@shiny.it>
Subject: RE: Interrupt handler
Date: Mon, 17 Mar 2003 10:17:04 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20030317101704.pochini@shiny.it>
References: <200303170447.h2H4lJL1015212@34.mumb.atln.nrcrgais.dsl.att.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200303170447.h2H4lJL1015212@34.mumb.atln.nrcrgais.dsl.att.net>
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


> When an interrupt arrives and I call snd_pcm_period_elapsed(), what
> function gets from alsa middle layer the new block to play and sets up
> the hardware ?

Ok, nobody answered, perhaps my question was too stupid :))
I still haven't found in the docs how can I get from ALSA the
address of the blocks to play/record, or how to tell ALSA where
it the space I allocated so it knows where it has to write the
audio data to be played.
I can build a very generic scatter-gather list. It has three
instructions: addr/length, generate interrupt, jump. Per example
I can write an sg list like this to emulate the cyclic buffer of
many soundblaster cards:

start:
addr0/len0
Irq
addr1/len1
Irq
goto start



Bye.



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
