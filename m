From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [PATCH] Add support for another X-Fi Extreme Audio
 (really SB Live	24bit)
Date: Sun, 03 Jun 2007 10:15:52 +0100
Message-ID: <466286C8.8090806@superbug.co.uk>
References: <1180837566.8636.1.camel@Box.ncat.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-30.mail.demon.net (anchor-post-30.mail.demon.net
	[194.217.242.88])
	by alsa0.perex.cz (Postfix) with ESMTP id DE93A2439F
	for <alsa-devel@alsa-project.org>;
	Sun,  3 Jun 2007 11:15:53 +0200 (CEST)
In-Reply-To: <1180837566.8636.1.camel@Box.ncat.edu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: crimsun@ubuntu.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Daniel T. Chen wrote:
> Hi,
> 
> Attached please find an hg changeset against current alsa-kernel tip.
> 
> Thanks,
> Daniel Chen
> 

Thank you for the patch.

As your card has different PCI IDs from my card.
Mine:  0x10121102
Yours: 0x10131102

I obviously cannot test yours.

Can you please add comments like the ones I have in the code for
0x10121102 :
E.g.
         /* It is really just a normal SB Live 24bit. */
         /*
          * CTRL:CA0111-WTLF
          * ADC: WM8775SEDS
          * DAC: CS4382-KQZ
          */
         /* Tested:
          * Playback on front, rear, center/lfe speakers
          * Capture from Mic in.
          * Not-Tested:
          * Capture from Line in.
          * Playback to digital out.
          */


So, to summarise, I would like the numbers written on the chips, and
also what exactly you have tested.

Kind Regards

James
