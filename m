From: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Subject: Re: MIDI+USB - one way?
Date: Fri, 2 Aug 2002 18:17:07 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200208021817.08060.plcl@telefonica.net>
References: <20020802001554.48f2f13a.mis@creazone.com> <3D4A67B8.730CE3F@ladisch.de> <20020802083548.5ff93902.mis@creazone.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020802083548.5ff93902.mis@creazone.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Michal Seta <mis@creazone.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

El Vie 02 Ago 2002 15:35, Michal Seta escribió:
> On Fri, 02 Aug 2002 13:06:32 +0200
> Clemens Ladisch <clemens@ladisch.de> wrote:
> > I tested the snd-usb-midi driver with the ALSA rawmidi test programs
> > (rawmidi and midiloop in alsa-lib/test), and it worked.
>
> It didn't work for me.
>
> when called with -i option it is silent (and I am unable to ctrl-c it to
> exit - I have to kill the proces).  With the -o option it sends note
> on/note off properly.  And yes, I used the -v option as well.

I have a Midiman Midisport 2x2 too, and is working with snd-usb-midi and Lars 
Doelle's ezusbmidi firmware. I have tested it just now, with current cvs's  
alsa-lib/test/rawmidi program and it works for me.

And yes, ctrl-c does not work well with this program. It only works after some 
events received from the MIDI device. If there is no MIDI input for some 
reason (cable disconnected, wrong parameters) you have to kill it.

$ ./rawmidi -v -i hw:2,0
Using:
Input: device hw:2,0
Output: NONE
Read midi in
Press ctrl-c to stop
read fe
read fe
read fe
read fe
read fe
read fe
read fe
Closing

>
> > I've already heard rumors that the OSS-compatible rawmidi input doesn't
> > work. Try to use /dev/snd/midiC?D? instead.

It also works for me with OSS emulation:

$ ./rawmidi -v -I /dev/midi02
Using:
Input: /dev/midi02
Output: NONE
Read midi in
Press ctrl-c to stop
read fe
read fe
read fe
read fe
read fe
read fe
read fe
Closing

But something as simple as:
$ cat /dev/midi02 | od -x
Doesn't work. Nothing received. ?!

>
> I used that, too.  And at all times I get MIDI output working fine but no
> input.  The funny thing is that it _did_ work and then it stopped working
> just like that...

A broken MIDI cable, perhaps? Also, keep watch over hotplug and the usb-oss 
modules/usb-audio modules. Sorry, I can't think of any more suggestions.

Regards,
Pedro



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
