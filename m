From: Jeremy Hall <jhall@maoz.com>
Subject: Re: rme9652 in kernel
Date: Sat, 12 Apr 2003 18:11:55 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200304122211.h3CMBtlf030342@sith.maoz.com>
References: <200304122108.h3CL8iT4030236@sith.maoz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200304122108.h3CL8iT4030236@sith.maoz.com> from Jeremy Hall at
 "Apr 12, 2003 05:08:44 pm"
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jeremy Hall <jhall@maoz.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

well, it's simple, adjust the makefile so that hammerfall-mem.o comes 
before rme9652.o

_J

In the new year, Jeremy Hall wrote:
> Hi,
> 
> I built rme9652 in my kernel so that I could debug with kgdb.  
> Unfortunately it runs rme9652 before hammerfall_mem, so it refuses to 
> insert hammerfalls because of no memory, then it makes the memory but 
> doesn't bother to go back and check for the hammerfalls.  Where is the 
> code that sets this order?
> 
> _J
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
> for complex code. Debugging C/C++ programs can leave you feeling lost and 
> disoriented. TotalView can help you find your way. Available on major UNIX 
> and Linux platforms. Try it free. www.etnus.com
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
