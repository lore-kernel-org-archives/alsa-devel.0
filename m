From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: Question on ALSA versions
Date: Fri, 05 Nov 2004 09:53:18 +0500
Message-ID: <cmf0td$rqv$1@sea.gmane.org>
References: <cmciu9$hsn$1@sea.gmane.org> <1099596730.1617.61.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:

> On Thu, 2004-11-04 at 11:42 +0500, Alexander E. Patrakov wrote:
>> Hello,
>> 
>> I have the following question. Is it OK to have mismatched versions of
>> ALSA drivers (e.g. 1.0.4, from linux-2.6.8.1) and libs (1.0.6)? This
>> _seems_ to work, and I see the code to support various versions of the
>> kernel PCM protocol in the library, but I want to see official words from
>> developers.
> 
> This is not guaranteed to work, and could lead to all kinds of weird
> problems.  Alsa-lib is the mechanism by which changes in the kernel side
> ALSA are hidden from userspace.  They expect to be the same version.

But the code says, e.g.:

        if (ioctl(fd, SNDRV_PCM_IOCTL_PVERSION, &ver) < 0) {
                ret = -errno;
                SYSERR("SNDRV_PCM_IOCTL_PVERSION failed");
                close(fd);
                return ret;
        }
        if (SNDRV_PROTOCOL_INCOMPATIBLE(ver, SNDRV_PCM_VERSION_MAX))
                return -SND_ERROR_INCOMPATIBLE_VERSION;

        if (SNDRV_PROTOCOL_VERSION(2, 0, 5) <= ver) {
  /* old stuff */
 }

So, contrary to your words, the code checks not for exactly the same version
but for some match defined by SNDRV_PROTOCOL_INCOMPATIBLE macro:

#define SNDRV_PROTOCOL_INCOMPATIBLE(kversion, uversion) \
    (SNDRV_PROTOCOL_MAJOR(kversion) != SNDRV_PROTOCOL_MAJOR(uversion) || \
    (SNDRV_PROTOCOL_MAJOR(kversion) == SNDRV_PROTOCOL_MAJOR(uversion) && \
    SNDRV_PROTOCOL_MINOR(kversion) != SNDRV_PROTOCOL_MINOR(uversion)))

So the protocols are considered compatible in the code if they have the same
major and minor versions, but differences in micro versions are allowed.

> In practice it usually works but there have been some specific incidents
> where this caused problems.  For example when a major change is made to
> a driver the hardware specific parts of alsa-lib will be updated to
> reflect the change.

Isn't it what minor and major versions are for? Or are they just an old
artifact that should not be relied upon? Or there is just lack of testing?

In short: is it a bug when it doesn't work with only micro versions being
different?

-- 
Alexander E. Patrakov



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
