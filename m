From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: How to compile ?
Date: Mon, 03 Mar 2003 09:21:24 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20030303092124.pochini@shiny.it>
References: <Pine.LNX.4.44.0303022021550.1253-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0303022021550.1253-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


On 02-Mar-2003 Jaroslav Kysela wrote:
> On 2 Mar 2003, Giuliano Pochini wrote:
> 
>> I wrote a very minimal driver that does nothing and I put it
>> in /pci directory. How do I compile it ?
> 
> alsa-driver or alsa-kernel ? I recommend using alsa-driver directory for 
> tests.

Driver. What is alsa-kernel ? :))

> 1) update Makefile (see ALSA extra code section)
> 2) add module dependency definition to alsa-driver/utils/Modules.dep
> 3) check alsa-driver/acore/Makefile to add missing dependencies

Tnx.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
