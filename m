From: tapas <tapas@affenbande.org>
Subject: Re: [Alsa-devel] Re: irq handler top half timestamps
Date: Thu, 16 Dec 2004 17:33:53 +0100
Message-ID: <20041216173353.4348dd15@mango.fruits.de>
References: <200412102051.iBAKphFL012668@localhost.localdomain>
	<1102712509.29919.46.camel@krustophenia.net>
	<20041211015610.1798af34@mango.fruits.de>
	<20041211032214.5121a003@mango.fruits.de>
	<20041216003255.6e65360b@mango.fruits.de>
	<20041216091812.GE11047@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <jackit-devel-admin@lists.sourceforge.net>
In-Reply-To: <20041216091812.GE11047@elte.hu>
Sender: jackit-devel-admin@lists.sourceforge.net
Errors-To: jackit-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:jackit-devel@lists.sourceforge.net>
List-Help: <mailto:jackit-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=jackit-devel>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>, Lee Revell <rlrevell@joe-job.com>, Paul Davis <paul@linuxaudiosystems.com>, Jaroslav Kysela <perex@suse.cz>, jackit-devel@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 16 Dec 2004 10:18:12 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> > is
> > 
> > snd_pcm_get_trigger_tstamp()
> > 
> > the api call to get the timestamp of the irq handler?
> > 
> > flo
> 
> in case you want to add it to ALSA within the -RT patchset, -RT now has
> a generic function:
> 
>  extern cycles_t irq_timestamp(unsigned int irq);
> 
> the timestamps do get generated for every irq.
> 
> (but ... the usual disclaimer: this is just a playground thing, so
> there's no guarantee of upstream merging.)

understood.

But the question of using a different timestamp source is still open in
case of the TSC's frequency not being constant. But i suppose this
question can wait until i figured out how to actually get the timestamp
from ALSA.

It looks like snd_pcm_get_trigger_tstamp() is the right call. And its
implementation would have to be adopted to use RP's
irq_timestamp(unsigned int irq)..

Fons Adriaenssen wrote to me that he tried snd_pcm_get_trigger_tstamp(),
but he always got the same value back. Since the docs are rather sparse
i want to ask the alsa-devs about exactly how to use the
snd_pcm_get_trigger_tstamp() call.

Any takers?

Flo


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
