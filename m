From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: How to debug ?
Date: Thu, 03 Apr 2003 17:14:34 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20030403171434.pochini@shiny.it>
References: <s5hbrzosx4c.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbrzosx4c.wl@alsa2.suse.de>
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


On 02-Apr-2003 Takashi Iwai wrote:
>> Yes, otherwise snd_pcm_lib_malloc_pages() fails and hw_params
>> callback exits with an error.
>
> ok, then something overwrites the entry.
> how about to check runtime->dma_area at each callback?

Bug found. Alsaplayer calls hw_params two times with different
buffer setup (and same audio parameters). I wasn't aware it's
legal to do that and I didn't rebuild the sg buffer the second
time.  Now I clean up an redo everything every time.

Ok, now AP works, but xmms still hangs. It calls pcm_open callback
and dies. I'll work on it tonight...

Bye.



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
