From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: MIDI+USB - one way?
Date: Fri, 02 Aug 2002 13:06:32 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D4A67B8.730CE3F@ladisch.de>
References: <20020802001554.48f2f13a.mis@creazone.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Michal Seta <mis@creazone.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Michal Seta wrote:
> I got a midisport2x2 interface.  I had it working with the usb-midi
> driver  but then I found out that alsa .rc3 had support for usb-midi.
> So I got the CVS version and all compiled fine.  I had it working,
> too.  Now, for some strange reason, no matter what I try I am only
> able to get MIDI -out but can't get MIDI-in.  I havn't really tested
> with alsa compatible software (aseqview only) I need access to ramidi
> devices (well, for now).

I tested the snd-usb-midi driver with the ALSA rawmidi test programs
(rawmidi and midiloop in alsa-lib/test), and it worked.

I've already heard rumors that the OSS-compatible rawmidi input doesn't
work. Try to use /dev/snd/midiC?D? instead.

It seems I'll have to do some further testing over the weekend ...


HTH
Clemens


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
