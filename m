From: Russell Neches <russell@ccs.neu.edu>
Subject: Re: snd-nm256 crash
Date: 13 Aug 2002 13:43:04 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <87sn1ivemv.fsf@zento.c-dart.com>
References: <87bs88bzgq.fsf@zento.c-dart.com> <s5h7kiwo114.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from amber.ccs.neu.edu (postfix@amber.ccs.neu.edu [129.10.116.51])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id TAA25772
	for <alsa-devel@alsa-project.org>; Tue, 13 Aug 2002 19:43:22 +0200
In-Reply-To: <s5h7kiwo114.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


I'd be glad to help, but until I get more familiar with the code base,
I'll need some guidance. How can I help?

Russell


Takashi Iwai <tiwai@suse.de> writes:

> At 11 Aug 2002 22:08:53 -0400,
> Russell Neches wrote:
> > 
> > I'm trying to get my laptop working with ALSA, but, sadly, my laptop
> > contains the lamentable NeoMagic 256AV chip. With ALSA 0.9.0beta12,
> > loading snd-nm256 causes the machine to lock up so tight that the soft
> > power switch stops working. 
>  
> nm256 driver is fairly unstable.
> i've checked the code and found that ac97 initialization causes
> the problem.  the reason is mysterious and the fix is difficult, since
> we have no information about this chipset at all.
> 
> anyway, the current cvs version is more stable (but not perfect).
> it would be appreciated if you can help debugging, too.
> 
> 
> Takashi



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
