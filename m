From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: [Alsa-devel] Re: irq handler top half timestamps
Date: Mon, 20 Dec 2004 11:52:54 +0000
Message-ID: <ad2655cb041220035292dc971@mail.gmail.com>
References: <007001c4e682$c366aec0$161b14ac@boromir>
	 <Pine.HPX.4.33n.0412201205010.20003-100000@studcom.urz.uni-halle.de>
Reply-To: James Courtier-Dutton <james.dutton@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <jackit-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0412201205010.20003-100000@studcom.urz.uni-halle.de>
Sender: jackit-devel-admin@lists.sourceforge.net
Errors-To: jackit-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:jackit-devel@lists.sourceforge.net>
List-Help: <mailto:jackit-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=jackit-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Martijn Sipkema <martijn@entmoot.nl>, Lee Revell <rlrevell@joe-job.com>, Florian Schmidt <mista.tapas@gmx.net>, Paul Davis <paul@linuxaudiosystems.com>, Jaroslav Kysela <perex@suse.cz>, Ingo Molnar <mingo@elte.hu>, jackit-devel@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 20 Dec 2004 12:10:25 +0100 (MET), Clemens Ladisch
<clemens@ladisch.de> wrote:
> 
> The ALSA API assumes constant-sized periods.  (Jack's Tascam USB
> driver bypasses the ALSA API.)

Maybe we should add support for varying size periods. e.g. For when
resampling from 44100 to 48000.
I was thinking of maybe adding the "next_period_size" variable as one
of the returned variables from the copy_areas sections in the rate
plugin.

> HTH
> Clemens
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
