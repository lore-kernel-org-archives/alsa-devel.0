From: Gregoire Favre <greg@ulima.unil.ch>
Subject: Re: How to put 16bit none audio PCM data stream into a 32bit none audio S/P-DIF transport stream?
Date: Wed, 9 Apr 2003 13:43:12 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030409114312.GE14489@ulima.unil.ch>
References: <20030408140230.GA1987@ulima.unil.ch> <E192u0x-0007pF-00@sc8-sf-list1.sourceforge.net> <s5hn0j1q97r.wl@alsa2.suse.de> <3E934193.6090605@cucumelo.org> <20030408205515.GB6940@ulima.unil.ch> <3E933EF6.5030601@superbug.demon.co.uk> <3E93C4CA.4080604@cucumelo.org> <20030409082815.GA14489@ulima.unil.ch> <s5h65poq65j.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h65poq65j.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Benny Sjostrand <gorm@cucumelo.org>, James Courtier-Dutton <James@superbug.demon.co.uk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 09, 2003 at 01:09:12PM +0200, Takashi Iwai wrote:

> i can hear ac3 5.1 output over spdif with a terratec xfire 1024
> without problems.  i guess it's not the choice of receiver but the
> card itself.  there are differences between the cards even with the
> same cs46xx chip depending on the hardware implementation.

Well, I can't speak about ALSA, but for DVB card, it only works with
receivers that detect the encapsulated stream (a lots of DVB users have
tested different receivers).
So I ask if it's really not a problem with some receivers here too...
When I plug my 5.1 to my standalone DVD player, I have two choice:

       	* SPDIF/RAW
       	* SPDIF/PCM

And if I choose SPDIF/PCM it don't work, but SPDIF/RAW works perfectly.

> yes it should be a driver bug.
> but note that without the real (problematic) hardware, it's difficult
> to check (especially if the system of developers do really work :) ...

So I only have the choice to change either the card, or my receier...

	Gr=E9goire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
