From: dunk fordyce <mailinglist@dunkfordyce.co.uk>
Subject: Re: seg fault
Date: Tue, 18 Jun 2002 19:46:32 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020618194632.3511f4fe.mailinglist@dunkfordyce.co.uk>
References: <20020618175932.0bc0ad84.mailinglist@dunkfordyce.co.uk>
	<20020618174425.GA1730@orbital.xs4all.nl>
Reply-To: him@dunkfordyce.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020618174425.GA1730@orbital.xs4all.nl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Andy Lo-A-Foe <andy@alsaplayer.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

yep u were right :)


On Tue, 18 Jun 2002 19:44:25 +0200
Andy Lo-A-Foe <andy@alsaplayer.org> wrote:

> On Tue, Jun 18, 2002 at 05:59:32PM +0200, dunk fordyce wrote:
> > anyone tell me why i get a seg fault?
> > ( excuse the c++ but im learning :)
> 
> gdb is your friend!
> 
> segfault usually means some pointer/memory problem. gdb will tell you
> at what line number your program crashes...
> 
> Looks like you are free()'ing a variable that was not malloc()'ed
> (str_buffer)
> 
> Regards,
> Andy

----------------------------------------------------------------------------
                   Bringing you mounds of caffeinated joy
                      >>>     http://thinkgeek.com/sf    <<<
