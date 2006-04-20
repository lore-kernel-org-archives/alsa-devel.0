From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: How to access vendor specific AC97 codec register
	?
Date: Thu, 20 Apr 2006 11:27:34 -0400
Message-ID: <1145546855.3008.0.camel@mindpipe>
References: <e28805$nlf$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <e28805$nlf$1@sea.gmane.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alasinski <alasinski@rogers.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-04-20 at 11:05 -0400, alasinski wrote:
> I need to do IO specific operation from UCB1400 on Snapper Arm board.
> This has to be done from C code as it is part of a larger project. All
> what I need is to be able to read and write content of the few vendor
> specific AC97 codec registers: 0x5A,0x5C. I'm not interested with any
> other ALSA functionality. 

Did you read the "Writing an ALSA driver" document?  It sounds like you
just want simple mixer controls (change the value of the codec register
when user toggles a mixer control)?  Look at any existing ALSA driver
for an example.

Lee



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
