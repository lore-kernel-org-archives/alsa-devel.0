From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: alsa-driver CVS configure.in broken
Date: Fri, 05 Nov 2004 20:43:00 -0500
Message-ID: <1099705381.1461.5.camel@krustophenia.net>
References: <20041105225831.99055.qmail@web52909.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20041105225831.99055.qmail@web52909.mail.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chris Rankin <rankincj@yahoo.com>
Cc: alsa-devel@lists.sourceforge.net, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Fri, 2004-11-05 at 22:58 +0000, Chris Rankin wrote:
> Hi,
> 
> I have just tried to compile my ALSA kernel modules
> from CVS, and discovered that the CONFIG symbols from
> the kernel's autoconf.h are not being added to the
> autoconf.h in the alsa-driver/include/linux/
> directory.
> 
> I reverted a one-line change to the configure.in file
> and it was fine again.

Can you send a patch with the change?  I have been having problems
building from CVS also.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
