From: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Subject: Re: Re: [PATCH] USB MIDI driver
Date: Wed, 3 Jul 2002 00:10:36 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200207030010.36320.plcl@telefonica.net>
References: <3D208C5C.36649172@ladisch.de> <s5hznxarxmz.wl@alsa2.suse.de> <200207022240.10455.plcl@telefonica.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200207022240.10455.plcl@telefonica.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Me wrote:
>
> I can't compile current CVS usb drivers:
>
Sorry, It had been fixed 4 hours ago. 
I have compiled it succesfully now. And  also works! (only preliminary tests).

$ cat /proc/asound/seq/clients
Client info
  cur  clients : 5
  peak clients : 6
  max  clients : 192

Client   0 : "System" [Kernel]
  Port   0 : "Timer" (Rwe-)
  Port   1 : "Announce" (R-e-)
    Connecting To: 63:0
Client  63 : "OSS sequencer" [Kernel]
  Port   0 : "Receiver" (-we-)
    Connected From: 0:1
Client  64 : "External MIDI 0" [Kernel]
  Port   0 : "MIDI 0-0" (RWeX)
Client  72 : "EDIROL UM-2" [Kernel]
  Port   0 : "UM-2 Port 0" (RWeX)
    Connecting To: 80:0
  Port   1 : "UM-2 Port 1" (RWeX)
Client  80 : "Midiman Midisport 2x2" [Kernel]
  Port   0 : "Midisport 2x2 Port 0" (RWeX)
    Connected From: 72:0
  Port   1 : "Midisport 2x2 Port 1" (RWeX)

Thanks,
Pedro



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
No, I will not fix your computer.
http://thinkgeek.com/sf
