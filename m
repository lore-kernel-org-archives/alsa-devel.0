From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: Automounting my 1394 drives causes Alsa to not
	load...
Date: 01 Feb 2003 12:31:49 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1044131509.9480.23.camel@cmn37.Stanford.EDU>
References: <1044128364.4689.20.camel@Godzilla>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1044128364.4689.20.camel@Godzilla>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@attbi.com>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> 1) Old problem - if my MidiSport 2x2 is plugged in when I cold boot,
> then Alsa gets loaded when the MidiSport is found. When I get to the
> part of the boot process where Alsa is supposed to get started, I get a
> 'Failed' message, telling me Alsa is already running. Even this is OK,
> but then later when Linux attempt to load the HDSP 9652 drivers, they
> fail one out of two times saying they cannot allocate memory.

I think the solution to this one is to "blacklist" the alsa driver so
that hotplug does not load it while the system is starting up. To do
that just add a line with "snd-usb-audio" to the end of 
  /etc/hotplug/blacklist
You probably already have "audio" and "usb-midi" there (the oss kernel
modules that deal with usb audio and midi). 

-- Fernando




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
