From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: Re: Patch:  Add support for Medion laptops.
Date: Fri, 13 Oct 2006 20:18:49 +0200
Message-ID: <m2y7rkoz92.fsf@vador.mandriva.com>
References: <1160681269.5520.7.camel@razman> <s5hr6xdgw80.wl%tiwai@suse.de>
	<1160683498.5520.14.camel@razman> <s5h7iz44i41.wl%tiwai@suse.de>
	<20061013145159.GA29937@trinnov.com> <1160759522.5520.29.camel@razman>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1160759522.5520.29.camel@razman> (Tobin Davis's message of "Fri,
	13 Oct 2006 10:12:02 -0700")
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Tobin Davis <tdavis@dsl-only.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Tobin Davis <tdavis@dsl-only.net> writes:

> Double check to see if you have any "model=" lines in your modprobe
> file.  Also, compile with "--with-debug=detect", load the driver,
> and post the output from "dmesg" & "cat /proc/asound/card0/codec#*".

btw, if model is overriden by a parameter, the driver should just
print that info (eg: "model overriden by user: XXX") so that this
could be guessed from dmesg output and help some lost end users.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
