From: "Carlos R. Mafra" <crmafra2@gmail.com>
Subject: Re: General protection fault when unloading
	snd_hda_intel on	2.6.30-rc1+ (bisected)
Date: Sun, 12 Apr 2009 03:58:11 +0200
Message-ID: <20090412015811.GA3907__29019.0438194715$1239518226$gmane$org@Pilar.aei.mpg.de>
References: <20090411193630.GA16968@Pilar.aei.mpg.de>
	<20090411132033.003c581c@infradead.org>
	<20090411210336.GA15272@Pilar.aei.mpg.de>
	<20090411143950.3429ebc0@infradead.org>
	<20090412003320.GA17346@ellpspace.math.ualberta.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20090412003320.GA17346@ellpspace.math.ualberta.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: alsa-devel@vger.kernel.org, Michal Jaegermann <michal@ellpspace.math.ualberta.ca>, linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
List-Id: alsa-devel@alsa-project.org

On Sat 11.Apr'09 at 18:33:20 -0600, Michal Jaegermann wrote:
> On Sat, Apr 11, 2009 at 02:39:50PM -0700, Arjan van de Ven wrote:
> > 
> > so... "dev" is pointing evbit at... 697665646632785 which looks like grabage.
> 
> FWIW 697665646632785c decodes in ASCII as "\x2fdevi".

So I painfully (exchanged 'good' for 'bad' in the middle and had
to restart all over) bisected this down to

commit 3be141494a080a9189b51fa78154c975ad8d9806
Author: Takashi Iwai <tiwai@suse.de>
Date:   Fri Feb 20 14:11:16 2009 +0100

    ALSA: hda - Add generic pincfg initialization

    Added the generic pincfg cache and save/restore functions.
    Also introduced the pin-overriding via hwdep sysfs.


It doesn't revert cleanly from the latest kernel, so I could not double 
check it.

OBS: All tests were done with the headphone plugged in.
