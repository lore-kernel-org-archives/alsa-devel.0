From: Ricardo Colon <rcolon@andrew.cmu.edu>
Subject: Re: Most simple use of sequencer in alsa
Date: Thu, 14 Feb 2002 01:50:40 -0500 (EST)
Message-ID: <Pine.GSO.4.43L-024.0202140148450.4335-100000@unix13.andrew.cmu.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <XFMail.020214073928.guenther.sohler@newlogic.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Guenther Sohler <guenther.sohler@newlogic.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Take a look at the seq.c file. It's in the directory of test programs that
come with ALSA. It's definitely the simplest example.

Otherwise, I can't really help you unless I see your code.

Thanks.

					-- R:

On Thu, 14 Feb 2002, Guenther Sohler wrote:

> Yesterday I was trying to use the sequencer to send a NOTEON EVENT to my
> wavetable device. I did
>
> *open the sequencer
> *allocated a port_info structure
> *filled in port and client to port_info
> *attached info to sequencer
> *allocated event
> *freed event
> * freed port structure
>
> I was not able to get further as My program now caused a segfault which i was
> not able to solve.
>
> Can anyone email me a simple program to put a NOTEON event to any client/port
> of the sequencer. I do not understand pmidi because it is too complex for me to
> understand. I'd wish to get/receive/see a simple program with approx 30 lines
>
> Can anybody help me ?
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
