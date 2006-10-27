From: "Richard Fish" <bigfish@asmallpond.org>
Subject: Re: IRQ issue with the hda-intel module,
	2.6.19 and my mobo?
Date: Fri, 27 Oct 2006 11:55:50 -0700
Message-ID: <7573e9640610271155k1b1ee193i8d955151efb6475f@mail.gmail.com>
References: <34389.86.7.220.119.1161973265.squirrel@wmbeta.mxes.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <34389.86.7.220.119.1161973265.squirrel@wmbeta.mxes.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Andrew Nelless <andrew@nelless.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 10/27/06, Andrew Nelless <andrew@nelless.net> wrote:
> Is this the case? If so, where should I file a bug report? and if not, what else can I try to
> track this down?

Just one thing I can think of:

modprobe snd_hda_intel disable_msi=1

-Richard

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
