From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Using driver service from another driver
Date: Wed, 08 Nov 2006 18:52:53 -0500
Message-ID: <1163029974.2823.67.camel@mindpipe>
References: <4550BFBA.6050400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <4550BFBA.6050400@gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Himanshu Chauhan <hs.chauhan@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-11-07 at 22:47 +0530, Himanshu Chauhan wrote:
> Dear all,
> 
> I am writing a virtual audio driver (similar to dummy.c in alsa tree).
> But I need to
> access the driver services of the soundcard installed on the system. How
> can this
> be done? Can I directly call the functions or I need to specifically
> open the
> device?
> 
> This is for the first time I am doing ALSA drivers so I seek your help.

EXPORT_SYMBOL() the driver functions you wish to call from the other
driver.  "grep -r EXPORT_SYMBOL sound/drivers/" for examples.

Lee


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
