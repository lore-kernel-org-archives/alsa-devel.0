From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: [Jackit-devel] irq handler top half timestamps
Date: Mon, 20 Dec 2004 20:49:01 -0500
Message-ID: <1103593741.8297.18.camel@krustophenia.net>
References: <200412102051.iBAKphFL012668@localhost.localdomain>
	 <1102712509.29919.46.camel@krustophenia.net>
	 <20041211015610.1798af34@mango.fruits.de>
	 <20041211032214.5121a003@mango.fruits.de>
	 <20041216003255.6e65360b@mango.fruits.de> <20041216091812.GE11047@elte.hu>
	 <20041216173353.4348dd15@mango.fruits.de>
	 <1103222119.23735.2.camel@krustophenia.net>
	 <20041220004511.579be209@mango.fruits.de>
	 <1103499499.32415.35.camel@krustophenia.net>
	 <20041220160855.699a1014@mango.fruits.de>
	 <20041221023043.513bc7fb@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20041221023043.513bc7fb@mango.fruits.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: tapas <tapas@affenbande.org>, Ingo Molnar <mingo@elte.hu>, Paul Davis <paul@linuxaudiosystems.com>, Jaroslav Kysela <perex@suse.cz>, jackit-devel@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2004-12-21 at 02:30 +0100, Florian Schmidt wrote:
> On Mon, 20 Dec 2004 16:08:55 +0100
> Florian Schmidt <mista.tapas@gmx.net> wrote:
> 
> > I see. And all these calls have constant execution time?
> 
> Oops, i should read more carefully. sorry.
> 

Well, it would be interesting to measure the variance due to the trigger
callback in the driver.  Usually this just does a single inl() to read
the pointer from the hardware, then a bit of arithmetic (bytes_to_frames
or whatever).  I think the variance will be a function of PCI bus
contention.  It would be great to have some numbers, though.

Also for testing purposes it would be trivial to add another timestamp
mode to ALSA, where the timestamp is taken as soon as possible in the
interrupt handler, instead of doing it after getting the pointer from
the hw.

Lee 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
