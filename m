From: Ronny Standtke <Ronny.Standtke@gmx.net>
Subject: Re: How to debug?
Date: Tue, 6 Feb 2007 23:14:46 +0100
Message-ID: <200702062314.46673.Ronny.Standtke@gmx.net>
References: <200701302251.28880.Ronny.Standtke@gmx.net>
	<200702022144.47885.Ronny.Standtke@gmx.net>
	<s5h3b5khaot.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h3b5khaot.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Thank you again very much for your help. The last hint was crucial.

So all I actually had to do to solve my problem was to add the following two 
lines to /etc/modprobe.d/alsa-base:
--------------
options snd-intel8x0 index=0
options snd-usb-audio index=-2,-2
--------------

It just took me two months to find out... I still think that it is the job of 
the desktop environment to search the configured soundcard at startup instead 
of letting poor users change system configuration files as root to hardcode 
the soundcard order. Maybe one day Linux can do this as user-friendly as the 
competition already does for several years now.

Greetings and thank you again

Ronny

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
