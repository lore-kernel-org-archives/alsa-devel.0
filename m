From: Dan Hollis <goemon@anime.net>
Subject: Re: rtcw,quake3 hang on exit
Date: Wed, 20 Mar 2002 13:51:44 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0203201350450.8765-100000@sasami.anime.net>
References: <200203202147.QAA02262@renoir.op.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <200203202147.QAA02262@renoir.op.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@Op.Net>
Cc: Michael Jochum <e9725005@stud3.tuwien.ac.at>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 20 Mar 2002, Paul Davis wrote:
> >so what kind of bug is this? rtcw? alsa? kernel?
> you haven't really described the bug very much. something to do with
> processes left around, etc.
> does the program(s) in question use threads? if so, using _exit() will
> fail to terminate all threads in the process. this is a linux issue.

But OSS doesn't have the problem. Only ALSA with OSS emulation does.

Quite strongly points to an ALSA-specific problem.

-Dan
-- 
[-] Omae no subete no kichi wa ore no mono da. [-]


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
