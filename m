From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [PATCH] echoaudio, fw_writer
Date: Wed, 19 Jul 2006 00:56:38 +0100
Message-ID: <44BD7536.5000107@superbug.co.uk>
References: <20060718231935.63c255ea.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20060718231935.63c255ea.pochini@shiny.it>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Giuliano Pochini <pochini@shiny.it>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Giuliano Pochini wrote:
> After a talk with Richard Stallman, who said it is not correct to link a
> binary image into a GPL program even if is just dumped onto disk, here you
> are this patch that makes fw_writer to load and parse the C sources
> containing the images instead of including them at compile time. It supports
> both the "sources" that are already part of alsa-firmware and the original
> files downloadable from the Echoaudio web site.
> 

What is the problem exactly?
All the files DSP/LoaderDSP.c etc. have a GPL license on them. I don't
see what the problem is, unless you have wrongly attached the GPL
license to them?

James

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
