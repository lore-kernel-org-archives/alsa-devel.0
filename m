From: Andreas Mohr <andim2@users.sourceforge.net>
Subject: Re: [PATCH 1/3] azt3328.c: add suspend/resume support (resent)
Date: Wed, 17 May 2006 11:34:32 +0200
Message-ID: <20060517093431.GA31496@rhlx01.fht-esslingen.de>
References: <20060516181954.GA11587@rhlx01.fht-esslingen.de> <s5h64k52eti.wl%tiwai@suse.de>
Reply-To: andi@lisas.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h64k52eti.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: andi@lisas.de, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

On Wed, May 17, 2006 at 11:14:33AM +0200, Takashi Iwai wrote:
> At Tue, 16 May 2006 20:19:54 +0200,
> Andreas Mohr wrote:
> > 
> > [resent with SNDRV_PCM_TRIGGER_SUSPEND addition that actually
> > makes suspend work correctly, against old base version since
> > SF CVS is currently offline - as always]
> 
> SF CVS is already dead and outdated.  Please use HG tree to pick up
> the latest source.

Somehow I already suspected something like that - thanks for the confirmation!

> I committed all three patches now since they could be applied cleanly
> on the latest code, too.

Thanks!

A fully patched azt3328 driver (those 3 reworked diffs) has been re-verified
to still work fine yesterday evening after-the-fact (oops, I'm so sorry! ;).

Now going to fix improperly working suspend/resume with VIA 823x driver...

Andreas Mohr


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
