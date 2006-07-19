From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: [PATCH] echoaudio, fw_writer
Date: Wed, 19 Jul 2006 10:31:26 +0200 (CEST)
Message-ID: <XFMail.20060719103126.pochini@shiny.it>
References: <44BD7536.5000107@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <44BD7536.5000107@superbug.co.uk>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


On 18-Jul-2006 James Courtier-Dutton wrote:
> Giuliano Pochini wrote:
>> After a talk with Richard Stallman, who said it is not correct to link a
>> binary image into a GPL program even if is just dumped onto disk, here you
>> are this patch that makes fw_writer to load and parse the C sources
>> containing the images instead of including them at compile time. It supports
>> both the "sources" that are already part of alsa-firmware and the original
>> files downloadable from the Echoaudio web site.
>>
>
> What is the problem exactly?
> All the files DSP/LoaderDSP.c etc. have a GPL license on them. I don't
> see what the problem is, unless you have wrongly attached the GPL
> license to them?

fw_loader.c #include's those files. The licence says the author
permits the inclusion of the firmwares in a GPL project. But
rms says it is misleading because the GPL requires the firmwares
to be in source form.
I do not completely agree with that, but this patch solves the
issue (and fw_loader.c is 200 bytes shorter 8D).



--
Giuliano.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
