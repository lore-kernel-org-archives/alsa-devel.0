From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Echoaudio driver, hint request
Date: Tue, 16 Nov 2004 19:25:04 +0100
Message-ID: <20041116192504.5d766678.pochini@shiny.it>
References: <20041108224637.1fd8b6cd.pochini@shiny.it>
	<s5h8y97fjv2.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8y97fjv2.wl@alsa2.suse.de>
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

On Fri, 12 Nov 2004 11:21:37 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> > My driver currently registers two pcm devices: pmc#0 for analog channels and
> > pcm#1 for digital channels. Though the DSP interface does not make that
> > distinction: for example the Gina24 has 2 analog and 8 digital input
> > channels and they are numbered 16..25. It's also possible to use a substream
> > made of all 10 channels at the same time.
> >
> > The question is: what's better, the current approach of keeping analog and
> > digital channels on different pcm devices (quite messy at driver level), or
> > should I put them toghether and write a proper .alsarc file, so the user can
> > choose digital channels by name instead of by index ?
>
> It's diffituly to tell which is definitely better.
>
> When someone wants to use OSS emulation for digital, it'd be nicer to
> have a distinct device, so that it may work with the kernel OSS
> emulation route.  OTOH, from the ALSA perspective, it's no problem to
> have one stream with all channels.
>
> So, the question is the difficulty of coding.  If the code wouldn't be
> too complicated, the separate devices are easier and more
> understandable for users.  If the code matters, choose the one stream
> type like ice1712.

No, it's not difficult. The driver uses separated devices since the first
release. It's a bit ugly, though. There are two couples of almost identical
pcm_open() functions and a couple of nested ifdef's. Btw, I'll keep the
current solution because it appears cleaner at user level.


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
