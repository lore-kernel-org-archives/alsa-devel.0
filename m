From: Remy Bruno <remy.bruno@trinnov.com>
Subject: Re: Issue with Intel HDA Sound card 82801G (laptop
	Medion)
Date: Tue, 10 Oct 2006 20:09:44 +0200
Message-ID: <20061010180944.GA32060@trinnov.com>
References: <1160502498.452bdce24d797@imp4-g19.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1160502498.452bdce24d797@imp4-g19.free.fr>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: albox@free.fr
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tuesday 10 October at 19:48, albox@free.fr wrote:
> I have just tried and it works...I guess the only thing to do now is to figure
> it out what's the difference between this patched version and the alsa driver
> 1.0.13.

Yes, that's exactly the point! But not a small one. There are big difference
between the two. I think Tobin is working on this.

> 
> And as I said, don't forget to "modprobe -r" the driver before suspending to
> disk, or the kernel will crash.
> => What type of message did you get ? Do you know how we can avoid this problem
> (a  shell script to remove the module before suspending ?).

I get an oops... Indeed, it is possible to make a script, but you need to kill
all the processes that use alsa before modprobing -r...

Regards,
Remy

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
