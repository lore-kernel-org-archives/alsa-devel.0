From: Martin Langer <martin-langer@gmx.de>
Subject: Re: my first usb-midi experiment ends with segmentation fault
Date: Wed, 31 Jul 2002 23:02:59 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020731210259.GA733@tuba.home>
References: <20020728213924.GA522@tuba.home> <3D469011.855453A7@ladisch.de> <200207301708.07066.plcl@telefonica.net> <3D46C107.2E108CEB@ladisch.de> <20020730181834.GA494@tuba.home> <3D47BB59.1E7012C1@ladisch.de>
Reply-To: martin-langer@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3D47BB59.1E7012C1@ladisch.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 31, 2002 at 12:26:33PM +0200, Clemens Ladisch wrote:
> 
> IMHO the garbled device name is strange, too. ;-)  This is a (rather
> harmless) buffer overflow which has been fixed by the latest version of my
> other patch.
> 

Rather harmless buffer overflows results in segfaults - a tough ideology!
Don't show me any of your critical buffer overflows ;-) 

After having some fun with my working snd-usb-midi module I can say: it's
working, working and working (without problems).

So, the "Evolution MK-249C" can be add to the list of supported devices.

Finally there is only one point, which doesn't show perfect beauty. It's the
shortname of the proc entry, which looks incomplete, but that's really
"rather harmless", because everything works for me, there is no buffer
overflow(!) .... and other things are much more important.


Thanks again and sorry for the mess,
martin

---------------------------------

3 [card3          ]: USB MIDI - Evolution Electronics Ltd. MK-2
                     Evolution Electronics Ltd. MK-249C USB MIDI keyboard at
001/002 if 1





-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
