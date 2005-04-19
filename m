From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Same PCI ID, different cards - rfc
Date: Tue, 19 Apr 2005 20:37:05 +0200
Message-ID: <20050419203705.71ad2efa.pochini@shiny.it>
References: <20050417172529.7dea3b59.pochini@shiny.it>
	<s5hbr8a2ab3.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbr8a2ab3.wl@alsa2.suse.de>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 19 Apr 2005 14:57:52 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Sun, 17 Apr 2005 17:25:29 +0200,
> Giuliano Pochini wrote:
> > 
> > I did some work in order to solve the problem about the Gina3G and the
> > Layla3G which share the same PCI card so it's impossible to say what card is
> > installed before probing.
> > 
> > The main difference between the two cards is the number of channels. I added
> > those data in chip_t and I replaced the related macros with inline functions
> > (defined in echoaudio.h). Those functions return a constant for all non-3G
> > cards, so no overhead is added. The patch has been tested on my Gina24 and
> > Gina3G only. It's quite big because it touches a lot of code and it replaces
> > a few files but the relevant changes are only in echoaudio.h, echo3g.c and
> > echo3g_dsp.c .
> > 
> > http://xoomer.virgilio.it/g_pochini/e3g.patch
> 
> The patch looks fine.
> Could you give me the summary and signed-off-by as usual?



Ok, This is a slightly modified patch. There is a small bugfix, it removes
some no more used #define's and it doesn't contain the "return err" fix that
has already been merged.



- This patch unifies the Gina3G and the Layla3G drivers. The new driver is
called snd-echo3g.


Signed-off-by: Giuliano Pochini <pochini@shiny.it>

http://xoomer.virgilio.it/g_pochini/echo3g.patch




--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
