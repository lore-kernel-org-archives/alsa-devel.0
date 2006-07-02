From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: OSS driver removal, 2nd round
Date: Sun, 02 Jul 2006 17:16:18 -0400
Message-ID: <1151874979.25802.31.camel@mindpipe>
References: <20060629192128.GE19712@stusta.de>
	<44A54D8E.3000002@superbug.co.uk>
	<20060630163114.GA12874@dspnet.fr.eu.org>
	<1151702966.32444.57.camel@mindpipe>
	<20060701073133.GA99126@dspnet.fr.eu.org>
	<44A6279C.3000100@superbug.co.uk> <44A76DDF.4020307@superbug.co.uk>
	<Pine.LNX.4.61.0607021153220.5276@yvahk01.tjqt.qr>
	<1151854092.12026.39.camel@mindpipe>
	<Pine.LNX.4.61.0607022304230.5218@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 8DDFA1A7
	for <alsa-devel@alsa-project.org>;
	Sun,  2 Jul 2006 23:16:03 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.61.0607022304230.5218@yvahk01.tjqt.qr>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: alsa-devel@alsa-project.org, Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Olaf Hering <olh@suse.de>, James Courtier-Dutton <James@superbug.co.uk>, Adrian Bunk <bunk@stusta.de>, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Sun, 2006-07-02 at 23:08 +0200, Jan Engelhardt wrote:
> >> Well you could patch the affected plugin's .dynstr table so that it should at
> >> best try to call a function that has not yet been defined somewhere else (like
> >> open); IOW, you change the .dynstr entry from 'open' to say 'my_open', and
> >> regularly include libmy.so through e.g. LD_PRELOAD.
> >> 
> >> Of course the MD5 won't match afterwards, but I think the plugin should execute
> >> as usual afterwards, since .dynstr is something no app should rely on.
> >
> >Is this likely to work with an app like Skype that takes extensive steps
> >to thwart reverse engineers?
> 
> We do not reverse engineer the .text section, but change the .dynstr 
> section that is specific to the ELF format. I doubt any app out there md5s 
> itself.
> 

It's possible.  They certainly try very hard to thwart reverse
engineers.

http://www.secdev.org/conf/skype_BHEU06.handout.pdf

Lee



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
