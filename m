From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: midi application subcription lose data.
Date: Thu, 10 Apr 2003 12:40:03 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0304101238340.1192-100000@pnote.perex-int.cz>
References: <3E954790.7FD6E730@ufh.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3E954790.7FD6E730@ufh.se>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Enderborg <pme@ufh.se>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 10 Apr 2003, Peter Enderborg wrote:

> I have two midi applications sending midi to each other with alsa. But
> every now and then it stop working,
> but can be up and running with re install the midi binding with
> aconnect. The connection is still there
> so it first need to be removed. But after than everything works fine for
> a day or so. This is on 0.9.2 in 2.4.20 kernel.
> (The current snapshot dont compile so I can not see if it in cvsexport
> also) This bug have been there for a long time
> now. Any ideas ?

Strange. What's the connection status when the communication stops?
Could you reproduce the bug with some small programs which generates 
random events (and sends them in random chunks between)? It will help us 
alot. Thanks.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
