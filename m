From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: weird xrun problem
Date: Tue, 25 May 2004 23:16:42 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040525231642.4ae3c3a1.pochini@shiny.it>
References: <20040522123855.12837e8d.pochini@shiny.it>
	<Pine.LNX.4.58.0405231116590.2139@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0405231116590.2139@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 23 May 2004 11:21:41 +0200 (CEST)
Jaroslav Kysela <perex@suse.cz> wrote:

> On Sat, 22 May 2004, Giuliano Pochini wrote:
>
> > Period 0 is 6624 frames and Period 1 is 6592 frames long (32 frames
> > shorter). I put some debug code and this is the output for a the playback
> > test above:
>
> ALSA does not know about this. All period sizes must be equal.

I thought about this again. Are you sure all periods must be aqual ?  When I
record or play something using unequal periods, sound is perfect. It means
ALSA reads and writes the last (sometimes a lot) smaller period as well.



--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
