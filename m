From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: rates and frame-based formats
Date: Wed, 23 Oct 2002 19:29:43 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210231920300.5772-100000@pnote.perex-int.cz>
References: <20021023155747.15165.qmail@web11502.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20021023155747.15165.qmail@web11502.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Guilhem Tardy <guilhem_tardy@yahoo.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 23 Oct 2002, Guilhem Tardy wrote:

> Hi,
> 
> There are some frame-based formats defined in asound.h and pcm.h. For full-rate
> GSM, frames are 260 bits every 20 ms. So my question is:
> In such a case, should an application use (and the driver define) a rate of
> 50Hz, or the standard 8000Hz?

This is very good question. We should make a decision. If we use 50Hz, we 
can easily calculate frames per second, otherwise we have to translate 
sampling rate to physical rate.. But it's the only good point which I see.

Also, the situation is very easy for GSM where the sampling rate is fixed, 
but what about some variable rate compressions with different sampling 
rate / physical rate ratio?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
