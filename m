From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: MIDI+USB - one way?
Date: Fri, 02 Aug 2002 19:08:54 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D4ABCA6.9E126597@ladisch.de>
References: <20020802001554.48f2f13a.mis@creazone.com>
 <3D4A67B8.730CE3F@ladisch.de> <20020802083548.5ff93902.mis@creazone.com>
 <200208021817.08060.plcl@telefonica.net>
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
To: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Cc: Michal Seta <mis@creazone.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Pedro Lopez-Cabanillas wrote:
> It also works for me with OSS emulation:
> 
> $ ./rawmidi -v -I /dev/midi02
> Using:
> Input: /dev/midi02
> Output: NONE
> Read midi in
> Press ctrl-c to stop
> read fe
> read fe
> read fe
> read fe
> read fe
> read fe
> read fe
> Closing
> 
> But something as simple as:
> $ cat /dev/midi02 | od -x
> Doesn't work. Nothing received. ?!

rawmidi.c uses the ALSA library functions to access the rawmidi device.
Internally, alsa-lib should use the same read() call as cat, but there
seems to be a difference somewhere, maybe in the initialization.
I'm looking into it.


HTH
Clemens


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
