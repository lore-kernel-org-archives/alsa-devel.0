From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: [Jackit-devel] irq handler top half timestamps
Date: Thu, 16 Dec 2004 13:35:18 -0500
Message-ID: <1103222119.23735.2.camel@krustophenia.net>
References: <200412102051.iBAKphFL012668@localhost.localdomain>
	 <1102712509.29919.46.camel@krustophenia.net>
	 <20041211015610.1798af34@mango.fruits.de>
	 <20041211032214.5121a003@mango.fruits.de>
	 <20041216003255.6e65360b@mango.fruits.de> <20041216091812.GE11047@elte.hu>
	 <20041216173353.4348dd15@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20041216173353.4348dd15@mango.fruits.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tapas <tapas@affenbande.org>
Cc: Ingo Molnar <mingo@elte.hu>, Florian Schmidt <mista.tapas@gmx.net>, Paul Davis <paul@linuxaudiosystems.com>, Jaroslav Kysela <perex@suse.cz>, jackit-devel@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2004-12-16 at 17:33 +0100, tapas wrote:
> Fons Adriaenssen wrote to me that he tried snd_pcm_get_trigger_tstamp(),
> but he always got the same value back. Since the docs are rather sparse
> i want to ask the alsa-devs about exactly how to use the
> snd_pcm_get_trigger_tstamp() call.

Because trigger_tstamp only gets updated in the trigger callback, when
the PCM is stopped, started, or paused.  I will have to check the code
to see what you use for the irq timestamp.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
