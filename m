From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Small patch for alsa-lib
Date: Tue, 20 Jan 2004 13:45:58 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0401201345480.1972@pnote.perex-int.cz>
References: <400D1FDC.9040804@pg.gda.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <400D1FDC.9040804@pg.gda.pl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adam Tla/lka <atlka@pg.gda.pl>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 20 Jan 2004, Adam Tla/lka wrote:

> Welcome
> 
> I observe that while using xmms with ALSA output plugin
> and alsa-20040120 compiled lib we get shared memory usage growing.
> Any opening of new sound source (sound file etc.) adds a new shm segment 
> while old segments stay in memory until xmms exits.
> Sometimes they stay even after application closing and must be removed 
> manually.
> I am sending a small patch which should remove this behaviour.

Thanks for this patch. It's in CVS now.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
