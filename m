From: Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [Alsa-devel] Re: irq handler top half timestamps
Date: Thu, 16 Dec 2004 00:32:55 +0100
Message-ID: <20041216003255.6e65360b@mango.fruits.de>
References: <200412102051.iBAKphFL012668@localhost.localdomain>
	<1102712509.29919.46.camel@krustophenia.net>
	<20041211015610.1798af34@mango.fruits.de>
	<20041211032214.5121a003@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <jackit-devel-admin@lists.sourceforge.net>
In-Reply-To: <20041211032214.5121a003@mango.fruits.de>
Sender: jackit-devel-admin@lists.sourceforge.net
Errors-To: jackit-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:jackit-devel@lists.sourceforge.net>
List-Help: <mailto:jackit-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=jackit-devel>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Lee Revell <rlrevell@joe-job.com>, Paul Davis <paul@linuxaudiosystems.com>, Jaroslav Kysela <perex@suse.cz>, Ingo Molnar <mingo@elte.hu>, jackit-devel@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 11 Dec 2004 03:22:14 +0100
Florian Schmidt <mista.tapas@gmx.net> wrote:

> Oh, i almost forgot: Ingo has already posted a patch adding this to the
> threaded irq handlers in recent RP kernels. ALSA could access it. But
> making ALSA depend on a kernel feature of an experimental kernel might
> be unwise (uneducated guess). 
> 
> Also this leaves the question of using a different timer source for the
> timestamps in the case that TSC is unreliable open.
> 
> Is it sensible to require users of jackd to not use cpu freq scaling
> during operation? If so, we could just settle on using the TSC.
> 
> Flo
> 

is

snd_pcm_get_trigger_tstamp()

the api call to get the timestamp of the irq handler?

flo

-- 
Palimm Palimm!
http://affenbande.org/~tapas/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
