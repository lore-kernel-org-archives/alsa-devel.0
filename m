From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Multiple reports of hard lockups with alsa MPU in
Date: Sat, 13 May 2006 18:00:11 -0400
Message-ID: <1147557612.6535.322.camel@mindpipe>
References: <1147554990.6535.317.camel@mindpipe>
	 <1147556731.25313.10.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1147556731.25313.10.camel@johannes.berg>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 2006-05-13 at 23:45 +0200, Johannes Berg wrote:
> On Sat, 2006-05-13 at 17:16 -0400, Lee Revell wrote:
> 
> > Two independent reports in a month - there definitely seems to be
> > something weird going on.  What can these users do to debug it?
> 
> From experience with softmac lockups I'd say enable serial console
> logging or at least switch to a real vc before doing whatever locks up
> the machine.
> 

Switching to a real VC was tried and the problem persisted.

> This usually means some weird hardware problem or a kernel fault in an
> interrupt handler or something similar.
> 

I don't think it could be a hardware problem - two independent reports
in the space of a week or two is just too much of a coincidence.

> johannes



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
