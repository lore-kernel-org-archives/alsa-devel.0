From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: 2.6.19-rc1 boot failure--ops in mpu401_init?
Date: Fri, 06 Oct 2006 16:53:13 -0400
Message-ID: <1160167993.17615.0.camel@mindpipe>
References: <20061006204358.GB18026@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 4EF47166
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Oct 2006 22:52:43 +0200 (MEST)
In-Reply-To: <20061006204358.GB18026@fieldses.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2006-10-06 at 16:43 -0400, J. Bruce Fields wrote:
> I also probably won't have time to try a git-bisect in the next few
> days, though I could try it eventually if it'd help. 

Thanks for the report.  Problem is known and fixed in later releases.
See the LKML/alsa-devel thread "Driver core: Don't ignore error returns
from probing".

Lee


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
