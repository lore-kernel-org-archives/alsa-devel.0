From: "Simon Dunn" <sdunn@mpc-data.co.uk>
Subject: Re: Alsa Driver on Coldfire
Date: Fri, 18 Apr 2008 16:47:40 +0100
Message-ID: <op.t9tctqwjhpbl6d@derby>
References: <op.t9swu605hpbl6d@derby> <s5hwsmvea38.wl%tiwai@suse.de>
	<20080418112340.GB19457@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from molson.mpc-data.co.uk (cvs.mpc-ogw.co.uk [81.2.99.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 1CE1924C03
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Apr 2008 17:47:45 +0200 (CEST)
In-Reply-To: <20080418112340.GB19457@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 18 Apr 2008 12:23:41 +0100, Mark Brown  
<broonie@opensource.wolfsonmicro.com> wrote:

>> I don't remember exact reason, too.  It was so when ALSA was merged,
>> IIRC.
>
> I think I'd formed the impression from somewhere or other (probably
> related to Debian m68k) that it was that there were no relevant drivers
> for m68k that had been ported to ALSA so there wasn't much point
> building it.  I could be misremembering, though.
>
> With regard to ColdFire I'm guessing that this is an embedded system?
> If so you might want to have a look at working with the ASoC framework
> (see sound/soc and Documentation/sound/alsa/soc).

Thanks for the info guys, I couldn't see any reason why alsa would be
excluded.  Oh and thanks for the tip re the system on chip, I'll have
a look into that though the kernel version we're working with is
2.6.10 and doesn't include it 'off the shelf'.

Can't imagine it would be too difficult to merge across unless anyone
knows different?

Cheers
Simon


-- 

Simon Dunn, Software Engineer
MPC Data Limited
e-mail: sdunn@mpc-data.co.uk
web: www.mpc-data.co.uk
tel: +44 (0) 1225 710600
fax: +44 (0) 1225 710601
ddi: +44 (0) 1225 710631

MPC Data Limited is a company registered in England and Wales with company  
number 05507446
Registered Address: County Gate, County Way, Trowbridge, Wiltshire, BA14  
7FJ
VAT no: 850625238

The information in this email and in the attached documents is  
confidential and may be legally privileged. Any unauthorized review,  
copying, disclosure or distribution is prohibited and may be unlawful. It  
is intended solely for the addressee. Access to this email by anyone else  
is unauthorized. If you are not the intended recipient, please contact the  
sender by reply email and destroy all copies of the original message. When  
addressed to our clients any opinions or advice contained in this email is  
subject to the terms and conditions expressed in the governing contract.
