From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: 2.6.19-rc1 boot failure--ops in mpu401_init?
Date: Fri, 6 Oct 2006 16:58:36 -0400
Message-ID: <20061006205836.GC18026@fieldses.org>
References: <20061006204358.GB18026@fieldses.org>
	<1160167993.17615.0.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from pickle.fieldses.org (mail.fieldses.org [66.93.2.214])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3C8B418D
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Oct 2006 22:58:38 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <1160167993.17615.0.camel@mindpipe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 06, 2006 at 04:53:13PM -0400, Lee Revell wrote:
> On Fri, 2006-10-06 at 16:43 -0400, J. Bruce Fields wrote:
> > I also probably won't have time to try a git-bisect in the next few
> > days, though I could try it eventually if it'd help. 
> 
> Thanks for the report.  Problem is known and fixed in later releases.
> See the LKML/alsa-devel thread "Driver core: Don't ignore error returns
> from probing".

OK, thanks.--b.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
