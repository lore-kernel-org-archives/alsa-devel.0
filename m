From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: ring buffer pointer accuracy.
Date: Fri, 11 Jul 2003 17:28:08 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030711172808.694df05b.pochini@shiny.it>
References: <3F0D86D0.6040905@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F0D86D0.6040905@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 10 Jul 2003 16:31:28 +0100
James Courtier-Dutton <James@superbug.demon.co.uk> wrote:

> Hi,
>
> When an application reads the "avail" or "delay" pcm values: -
> 1) how accurate are they?
> 2) does the accuracy depend on the sound card driver being used.

Worst case accuracy is about one period AFAIK. It depends on the sound chip
because the low level driver reads the DMA pointer (or something) from some
hardware register or it can know the DMA pointer when it receives an interrupt
at the end of a period.

> This means that the "avail" and "delay" pointers are only accurate to 
> the nearest 3 ms.
> Do any other alsa drivers suffer from this, or are they all sample 
> accurate and updated as each sample is sent to the speakers.

No, for example the DMA pointer of Echoaudio cards has a precision of 32
frames. But from userspace it can be a lot worse than that. You have to
take into account process scheduling, disk i/o, network i/o...

Bye.


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
