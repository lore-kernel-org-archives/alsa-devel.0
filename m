From: James C Georgas <jgeorgas@rogers.com>
Subject: Re: disabling full duplex in oss emulation
Date: Wed, 16 Aug 2006 16:18:19 -0400
Message-ID: <1155759499.6173.10.camel@Rainsong>
References: <1155504459.8241.4.camel@Rainsong> <s5hveotx8zk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from smtp100.rog.mail.re2.yahoo.com (smtp100.rog.mail.re2.yahoo.com
	[206.190.36.78])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id E3DE127F
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Aug 2006 22:17:37 +0200 (MEST)
In-Reply-To: <s5hveotx8zk.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-16-08 at 12:36 +0200, Takashi Iwai wrote:
> At Sun, 13 Aug 2006 17:27:39 -0400,
> James C Georgas wrote:
> > 
> > Is there a way to disable full duplex mode at runtime for OSS emulation?
> > Perhaps a writable /proc entry or an environment variable? I have a
> > SBLive, which uses the emu10k1 driver.
> 
> Yes, see ALSA-Configuration.txt and Procfile.txt.
> 
Thanks for the tip.

Seems that I don't have the /proc/asound/card0/pcm#[cp]/oss entries. I'm
running 1.0.11 (gentoo packages). Any thoughts?

james@Rainsong /proc/asound/card0 $ ls
codec97#0/    fx8010_code       fx8010_tram_data  midi1      voices
emu10k1       fx8010_gpr        id                midi2      wavetableD1
fx8010_acode  fx8010_tram_addr  midi0             oss_mixer
james@Rainsong /proc/asound/card0 $

> 
> Takashi
> 
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
