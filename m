From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: trigger commands
Date: Mon, 24 Mar 2003 17:10:40 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20030324171040.pochini@shiny.it>
References: <s5hu1dtowqj.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hu1dtowqj.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


On 24-Mar-2003 Takashi Iwai wrote:
>> Ok, PAUSE_PUSH-->stop() and TRIGGER_STOP-->stop()-and-reset dma
>> pointer. In my case RELEASE and START are the same thing.
>
> note that resetting the dma pointer wouldn't be necessary in STOP
> trigger (although it may be safer), since the dma pointer will be
> reprogrammed anyway by the succeeding call or prepare callback from
> the ALSA middle layer.

I didn't know that prepare callback had to reset the dma pointer. That
could explain why sometimes the sound "jerks" when I change track with
xmms and stop/start/prepare are called 2-3 times in a very short time.


Bye.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
