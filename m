From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: how to cross compile the alsa util?
Date: Mon, 31 May 2004 08:53:22 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0405310850260.1799@pnote.perex-int.cz>
References: <20040531022839.56401.qmail@web15201.mail.bjs.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040531022839.56401.qmail@web15201.mail.bjs.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?gb2312?q?Roc=20Wu?= <cooloney@yahoo.com.cn>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 31 May 2004, Roc Wu wrote:

> Hello alls:
> 
> Sorry for post the mail again. I posted it several
> days ago, but no response. Anybody can give me some
> hints?
> 
> I cross compiled the alsa-lib-1.04 to arm platform.
> The 2.6.6 kernel including alsa driver is ok on our
> ARM board, so I want to test the driver. how to do it?
> 
> I think maybe the first step is to crosscompile the
> alsa utils to play a wave audio file.
> 
> CC=arm-linux-gcc ./configure --host=i686-linux
> --target=arm-linux

./configure --help

--- cut ---
  --with-alsa-prefix=PFX  Prefix where Alsa library is installed (optional)
  --with-alsa-inc-prefix=PFX  Prefix where include libraries are (optional)
--- cut ---

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
