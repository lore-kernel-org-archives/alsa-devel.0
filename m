From: Frank van de Pol <fvdpol@home.nl>
Subject: Re: Max number of queues?
Date: Mon, 4 Mar 2002 21:06:33 +0100
Message-ID: <20020304210633.A12127@idefix.fvdpol.home.nl>
References: <3C81677C.BDE47BFD@ufh.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C81677C.BDE47BFD@ufh.se>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Peter Enderborg <pme@ufh.se>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


have a look in include/seq_kernel.h, where you find:

...
 /* maximum number of queues */
#define SNDRV_SEQ_MAX_QUEUES            8
...

changing this should make it work for you.

regards,
Frank.


On Sun, Mar 03, 2002 at 12:59:56AM +0100, Peter Enderborg wrote:
> I get in to allocation error when I try to start a alloc the 8'  queue.
> Is there any parametes to
> tune for this ? Im need 17...
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

-- 
+---- --- -- -  -   -    - 
| Frank van de Pol                  -o)    A-L-S-A
| FvdPol@home.nl                    /\\  Sounds good!
| http://www.alsa-project.org      _\_v
| Linux - Why use Windows if we have doors available?

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
