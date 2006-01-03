From: Giuliano Pochini <pochini@denise.shiny.it>
Subject: Re: [PATCH 2/2] Echoaudio - new firmware
Date: Tue, 3 Jan 2006 21:09:28 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0601032104550.11712@denise.shiny.it>
References: <20060101115205.4519cfe0.pochini@shiny.it> <s5hd5ja1y7o.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd5ja1y7o.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org



On Mon, 2 Jan 2006, Takashi Iwai wrote:

> > This patch removes the DSP firmware for the Gina3G and replaces the Layla3G
> > DSP firmware with the new version which works with both cards.
> >
> > This one is too big for the list, I put it here:
> >
> >
> > Signed-off-by: Giuliano Pochini <pochini@shiny.it>
> >
> > http://www.webalice.it/g_pochini/echo_newfw2.patch		[388KiB]
> > or
> > http://www.webalice.it/g_pochini/echo_newfw2.patch.bz2
>
> Thanks, both driver and firmware patches are applied to CVS.

Tnx.  All files were patched correctly, except
alsa-firmware/echoaudio/DSP/Gina3gDSP.c which has not been deleted.


--
Giuliano.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
