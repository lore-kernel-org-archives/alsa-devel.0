From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: alsa-lib CVS link error
Date: Mon, 17 Feb 2003 11:36:30 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302171135311.1054-100000@pnote.perex-int.cz>
References: <Pine.LNX.4.44.0302171121310.1054-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0302171121310.1054-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Maarten de Boer <mdeboer@iua.upf.es>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 17 Feb 2003, Jaroslav Kysela wrote:

> On Mon, 17 Feb 2003, Maarten de Boer wrote:
> 
> > ../src/.libs/libasound.so: undefined reference to `snd_interval_set_minmax'
> > 
> > which is indeed not defined anyware in alsa-lib...
> 
> Sorry, I forget to commit header files ;-( Done.

Note: It would be nice to figure out why the drop() function hangs the 
jack client (when #if 0 sequence is uncommented).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
