From: Justin Cormack <justin@street-vision.com>
Subject: Re: RME installation problems
Date: 13 Feb 2003 15:51:35 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1045151500.1545.33.camel@lotte>
References: <20030212183033.GD3093@finnendahl.de>
	<1045076338.1544.3.camel@lotte> <20030212191240.GA806@finnendahl.de>
	<1045078205.1545.29.camel@lotte> <20030212200740.GB806@finnendahl.de>
	<s5h8ywkmsrm.wl@alsa2.suse.de> <20030213104423.GB1331@finnendahl.de>
	<20030213110851.GA3246@tuba.home> <s5hu1f8l9g5.wl@alsa2.suse.de>
	<20030213131832.GB3246@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030213131832.GB3246@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: martin-langer@gmx.de
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net, finnendahl@folkwang-hochschule.de
List-Id: alsa-devel@alsa-project.org

On Thu, 2003-02-13 at 13:18, Martin Langer wrote:
> On Thu, Feb 13, 2003 at 12:13:46PM +0100, Takashi Iwai wrote:
> > At Thu, 13 Feb 2003 12:08:51 +0100,
> > Martin Langer wrote:
> > > On Thu, Feb 13, 2003 at 11:44:24AM +0100, Orm Finnendahl wrote:
> > > > Hi Takashi,
> > > > Am Donnerstag, den 13. Februar 2003 um 10:31:09 Uhr (+0100) schrieb
> > > > Takashi Iwai:
> > > > 
> > > > > > > ie add the 0xb revision.
> > > > >
> > > > Yes. In the old driver it just checks for 0xa and 0x64. Just add a
> > > > line to also check for 0xb.
> > 
> > but i don't see any 0x64 there...
> > 
> 
> There was a mail by Justin few weeks ago, talking about the rev. 0x64.
> http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg05383.html
> Looks like, that this solution doesn't find it's way into CVS. 
> 
> Justin, can you send us a patch of your work?
> 

it was just

Index: alsa-kernel/pci/rme9652/hdsp.c
===================================================================
RCS file: /suse/tiwai/cvs/alsa/alsa-kernel/pci/rme9652/hdsp.c,v
retrieving revision 1.20
diff -u -r1.20 hdsp.c
--- alsa-kernel/pci/rme9652/hdsp.c      7 Feb 2003 09:18:41 -0000      
1.20
+++ alsa-kernel/pci/rme9652/hdsp.c      13 Feb 2003 11:12:26 -0000
@@ -2981,6 +2981,7 @@
        
        switch (rev & 0xff) {
        case 0xa:
+       case 0x64:
                /* hdsp_initialize_firmware() will reset this */
                hdsp->card_name = "RME Hammerfall DSP";
                break;





-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
