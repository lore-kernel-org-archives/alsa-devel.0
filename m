From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: multiple devices/ possible bug in aplay or somewhere
 else?
Date: Tue, 15 Oct 2002 18:14:31 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210151813080.719-100000@pnote.perex-int.cz>
References: <20021015154911.6849.qmail@web11501.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20021015154911.6849.qmail@web11501.mail.yahoo.com>
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

On Tue, 15 Oct 2002, Guilhem Tardy wrote:

> Hi all,
> 
> I have tried playing audio on device 1 of a "pci2103" card through aplay, which
> correctly displayed 2 devices and 1 subdevice each (aplay -l). The result was
> that audio was still played on device 0, regardless of the -d parameter.

-d is duration, use -D 'hw:0,1' or 'plughw:0,1'

> I would like to see the inclusion of the "pci2103" driver in the ALSA
> distribution in the near future and before 1.0 at any rate. Advice on the
> procedure for this to happen is welcome.

Send pointer to this list. We'll include the code, and / or comment what 
should be improved.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
