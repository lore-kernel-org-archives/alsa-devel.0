From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Everything You Could Ever Need to Know About ALSA
	- ALSA docs
Date: Sun, 14 May 2006 17:41:01 -0400
Message-ID: <1147642862.27252.110.camel@mindpipe>
References: <e47c8v$gn0$2@sea.gmane.org>
	 <1147629608.27252.63.camel@mindpipe>  <4467A249.8050804@tugraz.at>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4467A249.8050804@tugraz.at>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Strasser <patrick.strasser@tugraz.at>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 2006-05-14 at 23:34 +0200, Patrick Strasser wrote:
> >  Only use hw:x if you know what you
> > are doing.
> 
> I need something to select my CD sound to record from.
> 

You can't select to record from the CD with an ALSA PCM device.  You
have to record from default:x (where x is 0 for the first card, 1 for
the second, etc) and set the capture source to "CD" in alsamixer.

Lee



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
