From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Everything You Could Ever Need to Know About ALSA
	- ALSA docs
Date: Sun, 14 May 2006 14:00:07 -0400
Message-ID: <1147629608.27252.63.camel@mindpipe>
References: <e47c8v$gn0$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <e47c8v$gn0$2@sea.gmane.org>
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

On Sun, 2006-05-14 at 15:45 +0200, Patrick Strasser wrote:
> What is this thing about the device?
> 
> First the most important question:
> I know for now that in a standard configuration "hw:0,0" is quite
> fine. 
> For the second card "hw:1,0" is hopefully working. What exactly does 
> that mean?
> Sometimes I see "plughw:0,0". What's the difference to "hw:0,0"?
> How can I find out which device strings are valid (except for
> guessing?)
> 

Not quite, you should just use "default" (or "default:0" for the first
card, "default:1" for the second).  Only use hw:x if you know what you
are doing.

Really, you should not have to know this - the app should have a drop
down menu to select the device.

This page explains the varous devices:

http://www.alsa-project.org/alsa-doc/alsa-lib/pcm_plugins.html

> Next: How can I find out which device is the device my speakers are 
> connected to?
> 

You can't.  Speaker jacks don't normally support this.  You just have to
select the various devices in your app and see which one gives you
sound.  It's no different from any other OS.

Lee



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
