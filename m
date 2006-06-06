From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: autoconf.h error cross compiling
Date: Tue, 06 Jun 2006 17:04:38 -0400
Message-ID: <1149627878.4072.69.camel@mindpipe>
References: <1149625209.4072.57.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1149625209.4072.57.camel@mindpipe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-06-06 at 16:20 -0400, Lee Revell wrote:
> Why is it looking for autoconf.h?  AFAICT that is a kernel header.  Do
> I merely have to copy it into the
> powerpc-440-linux-gnu/sys-include/linux/
> directory? 

Never mind I resolved this by creating a symlink.

Lee
