From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: RME HDSP
Date: Tue, 20 Jun 2006 12:16:14 -0400
Message-ID: <1150820174.2754.118.camel@mindpipe>
References: <20060620101804.GA617@trinnov.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20060620101804.GA617@trinnov.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Remy Bruno <remy.bruno@trinnov.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-06-20 at 12:18 +0200, Remy Bruno wrote:
> As I got no reply from my last message, I would just like to report
> again the
> bug I found in hdsp.c:
> there is a bug in the begining of function snd_hdsp_proc_read() of
> file
> alsa-kernel/pci/rme9652/hdsp.c: a pair of "{}" is missing after the
> first "if"
> 
> if (hdsp_check_for_iobox (hdsp))
>         {
>                 snd_iprintf(buffer, "No I/O box connected.\nPlease
> connect one and upload firmware.\n");
>                 return;
>         } 

Because you did not post it in the form of a patch.

Lee
