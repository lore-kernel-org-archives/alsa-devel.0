From: Michal Seta <mis@creazone.com>
Subject: Re: MIDI+USB - one way?
Date: Fri, 2 Aug 2002 08:35:48 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020802083548.5ff93902.mis@creazone.com>
References: <20020802001554.48f2f13a.mis@creazone.com>
	<3D4A67B8.730CE3F@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3D4A67B8.730CE3F@ladisch.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 02 Aug 2002 13:06:32 +0200
Clemens Ladisch <clemens@ladisch.de> wrote:
> 
> I tested the snd-usb-midi driver with the ALSA rawmidi test programs
> (rawmidi and midiloop in alsa-lib/test), and it worked.

It didn't work for me.

when called with -i option it is silent (and I am unable to ctrl-c it to exit - I have to kill the proces).  With the -o option it sends note on/note off properly.  And yes, I used the -v option as well.

> 
> I've already heard rumors that the OSS-compatible rawmidi input doesn't
> work. Try to use /dev/snd/midiC?D? instead.

I used that, too.  And at all times I get MIDI output working fine but no input.  The funny thing is that it _did_ work and then it stopped working just like that...


Thanks anyways...

-- 
./MiS

Michal Seta		http://creazone.eworldmusic.com/doc/mis




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
