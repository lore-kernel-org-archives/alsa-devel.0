From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Question on ALSA versions
Date: Thu, 04 Nov 2004 14:32:09 -0500
Message-ID: <1099596730.1617.61.camel@krustophenia.net>
References: <cmciu9$hsn$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <cmciu9$hsn$1@sea.gmane.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2004-11-04 at 11:42 +0500, Alexander E. Patrakov wrote:
> Hello,
> 
> I have the following question. Is it OK to have mismatched versions of ALSA
> drivers (e.g. 1.0.4, from linux-2.6.8.1) and libs (1.0.6)? This _seems_ to
> work, and I see the code to support various versions of the kernel PCM
> protocol in the library, but I want to see official words from developers.

This is not guaranteed to work, and could lead to all kinds of weird
problems.  Alsa-lib is the mechanism by which changes in the kernel side
ALSA are hidden from userspace.  They expect to be the same version.

In practice it usually works but there have been some specific incidents
where this caused problems.  For example when a major change is made to
a driver the hardware specific parts of alsa-lib will be updated to
reflect the change.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
