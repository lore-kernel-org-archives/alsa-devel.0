From: "Andrew L. Neporada" <nepal@asplinux.ru>
Subject: Re: Connexant HDA codec support
Date: Wed, 23 Aug 2006 18:17:43 +0400
Message-ID: <1156342663.25148.26.camel@leeloo.asplinux.ru>
References: <1155721544.3871.43.camel@leeloo.asplinux.ru>
	<s5hac64ygw0.wl%tiwai@suse.de> <s5h3bbwyez3.wl%tiwai@suse.de>
	<1155812567.25618.9.camel@leeloo.asplinux.ru>
	<s5hk657zjb4.wl%tiwai@suse.de>
	<1155815287.25618.13.camel@leeloo.asplinux.ru>
	<s5h3bbvza3v.wl%tiwai@suse.de>
	<1155885471.27393.13.camel@leeloo.asplinux.ru>
	<s5hk656z7ly.wl%tiwai@suse.de>
	<1156336144.25148.14.camel@leeloo.asplinux.ru>
	<s5hfyfnzkbh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hfyfnzkbh.wl%tiwai@suse.de>
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

Takashi Iwai wrote:
> At Wed, 23 Aug 2006 16:29:04 +0400,
> Andrew L. Neporada wrote:
> > 
> > Hi!
> > 
> > It seems that I've fixed mic problem by adjusting VRef setting on
> > Pin Complex node #0x14.
> 
> Good catch.
> Could you try the patch below instead?
> 

It works also.

But I am a bit unsure about 

 	case AC_JACK_MIC_IN:
+		*pinctl |= AC_PINCTL_VREF_80;

Shouldn't this be conditional and based on node->pin_caps VREF caps?
Maybe we need patch_connexant.c ?


> 
> Takashi

Andrew.



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
