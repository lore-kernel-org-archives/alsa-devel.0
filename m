From: Martin Langer <martin-langer@gmx.de>
Subject: Re: [Alsa-devel][Patch] usbmidi fixes
Date: Wed, 31 Jul 2002 12:45:05 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020731104505.GA498@tuba.home>
References: <20020728213924.GA522@tuba.home> <3D469011.855453A7@ladisch.de> <200207301708.07066.plcl@telefonica.net> <3D46C107.2E108CEB@ladisch.de> <20020730181834.GA494@tuba.home> <3D47B5A1.752946D6@ladisch.de>
Reply-To: martin-langer@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3D47B5A1.752946D6@ladisch.de>
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

On Wed, Jul 31, 2002 at 12:02:09PM +0200, Clemens Ladisch wrote:
> 
> 
> These changes are desirable even if (apparently) they don't fix
> Martin's problem.
> 

The buffer overflow is fixed .... It looks like totally fixed!
I do some more tests this evening. Maybe I find something else;-)

So far: Thank you very much, Clemens.

martin



---------------

tuba:~# modprobe snd-usb-midi
tuba:~# rmmod snd-usb-midi 
tuba:~# modprobe snd-usb-midi 
tuba:~# cat /proc/asound/seq/clients 
Client info
  cur  clients : 2
  peak clients : 2
  max  clients : 192
      
Client   0 : "System" [Kernel]
  Port   0 : "Timer" (Rwe-)
  Port   1 : "Announce" (R-e-)
Client  64 : "Evolution Electronics Ltd. MK-249C USB MIDI keyboard" [Kernel]
  Port   0 : "MK-249C USB MIDI keyboard Port 0" (R-e-)
  Port   1 : "MK-249C USB MIDI keyboard Port 1" (-We-)
tuba:~# 
    


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
