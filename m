From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Hercules PC DJ Console (Windows Edition) information
Date: Thu, 12 Jan 2006 09:47:52 +0100
Message-ID: <1137055672.43c617b8297f6@webmail.uni-halle.de>
References: <2c746f620510180211hf803801mdda93f93aeae84c2@mail.gmail.com>
 <Pine.HPX.4.33n.0510181124030.2094-100000@studcom.urz.uni-halle.de>
 <2c746f620510182301j3419d000o857c2c72ef29880a@mail.gmail.com>
 <2c746f620510182303k782e04f2xa18b60cea49030a@mail.gmail.com>
 <1129746748.5203.1.camel@mindpipe>
 <2c746f620510191410v5032b3ebp673545e5958192ac@mail.gmail.com>
 <2c746f620601102330s337d7744r7b98dad75dbbf374@mail.gmail.com>
 <1136964861.27255.17.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1136964861.27255.17.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Eric Shattow <lucent@gmail.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> On Wed, 2006-01-11 at 01:30 -0600, Eric Shattow wrote:
> > arecord: xrun:1077: read/write error, state = PREPARED

There may be a message in the system log.

> Assuming this worked with previous versions, the problem may be that USB
> audio has been broken since kernel 2.6.14 (ALSA 1.0.10rcsomething).
>
> Try the patch attached to this bug report.
>
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1585

Now fixed in CVS.

I've added another patch to the above bug report, or wait for the next ALSA
release.


HTH
Clemens


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
