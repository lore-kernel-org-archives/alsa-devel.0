From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: rme hammerfall dsp questions
Date: Wed, 27 Sep 2006 10:17:37 -0400
Message-ID: <1159366657.18323.7.camel@localhost.localdomain>
References: <451A32BA.8080202@chello.at>
Reply-To: paul@linuxaudiosystems.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-reply-to: <451A32BA.8080202@chello.at>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Karl Grill <kgrill@chello.at>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net, support@synthax.de
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-09-27 at 10:13 +0200, Karl Grill wrote:
> Hi all,
> I'm working on getting the hammerfall dsp rpm to work under alsa. 
> Unfortunately, I haven't experienced the proverbal supportiveness of RME 
> towards linux yet (my e-mails have gone unanswered for three weeks now),
> so I'm using a disassembly of the windows (2k) driver (to Paul: yes, maybe
> I'm insane). By now, I know the card detection routine, and it is a bit 
> different from the one that is used in the alsa driver (apart from the 
> fact that it has to deal with the additional case of the RPM), 
> apparently the definition of some of the bitfields in the control 
> register has changed. This, in turn, seems to be due to the new 
> firmware, and as there is no old firmware for the RPM (it is only 
> supported by the win2k driver, and the alsa driver seems to be modeled 
> after the w9 software), I'm afraid that adding RPM functionality means 
> that I will have to adapt the driver as a whole to the new firmware. But 
> maybe it's not so bad, so here's my question:
> Does anybody have any experience with using (or failing to use) any of 
> the dsp cards with the new firmware (or only with the new firmware for 
> the pci/cardbus interface of the multiface/digiface) under alsa? Or 
> would any of the digi/multiface users out there to be willing to try the 
> new firmware on their cards (I think there's little risk involved, 
> except that in the case of failure, you will most likely have to do a 
> cold boot or two).

as i mentioned before, there is absolutely no reason to believe that the
HDSP RPM is substantively different from the HDSP. we already have the
HDSP, HDSP MADI and HDSP AES32 cards supported using pretty much exactly
the same code base, except for revision numbers, control register
handling and a few other odds and ends. believing that the RPM is a
whole new beast seems misplaced to me. it will be just like getting the
HDSP MADI or AES32 cards to work - a few tweaks here and there, not a
new driver model.

--p





-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
