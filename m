From: "Thibault Le Meur" <Thibault.LeMeur@supelec.fr>
Subject: RE :  [PATCH 2/2] M-Audio USB Documentation
Date: Mon, 27 Nov 2006 12:47:22 +0100
Message-ID: <017e01c71219$d04a2170$161ce4a0@supelec.fr>
References: <s5h64d1b0l9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h64d1b0l9.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: 'Takashi Iwai' <tiwai@suse.de>, 'Pavel Polischouk' <pavelvp@inbox.ru>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


> At Fri, 24 Nov 2006 15:26:46 -0500,
> Pavel Polischouk wrote:
> > 
> > +3.2 - Patching alsa to use direct pcm device
> > +--------------------------------------------
> > +A patch for Jack by Andreas Steinmetz adds support for Big Endian 
> > +devices.
> > +However it has not been included in the CVS tree.
> 
> Is this true?  If so, you should submit the patch to upstream...

Oups, my mistake:
* It is "Patching Jackd to use direct pcm device" and NOT "Patching alsa to
use direct pcm device"
* Moreover, this patch has now been adapted and integrated into the Jackd
main code (I can't remember which version had this patch, but the latest one
has it for sure)

And sorry I hadn't time to test the new M-Audio USB patch. I'll try to do
this for next week.

Regards,
Thibault



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
