From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Segfault after 2 seconds
Date: Mon, 14 Jul 2003 10:00:18 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0307140959400.1101-100000@pnote.perex-int.cz>
References: <200307131119.08324.gkajmowi@tbaytel.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200307131119.08324.gkajmowi@tbaytel.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Garrett Kajmowicz <gkajmowi@tbaytel.net>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 13 Jul 2003, Garrett Kajmowicz wrote:

> I am working on an app which must change the configuration for sample rate on 
> the fly.  I have produced code which seems to work.  However, for some 
> reason, the app doing capturing runs only for about 2 seconds after capturing 
> begins, at which point the app crashes with a segfault.  This is due to the 
> sampling, and in fact changing of the hwparams because if I comment out the 
> code which does that, I am able to sample continuously, which does not 
> satisfy my needs.
> 
> The code attached executes flawlessly.  However, approximately two seconds 
> after executing it, I get teh segault with no explanation.
> 
> I am using the plughw device so as to allow a lot of this stuff to happen in 
> software for me.
> 
> I would appreciate any suggestions or refferences that you can point me to.

Send me a small compilable code to test the behaviour and specify your 
hardware which triggers the bug.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
