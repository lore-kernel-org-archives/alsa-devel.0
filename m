From: Michal Seta <mis@creazone.com>
Subject: Re: MIDI+USB - back on track
Date: Wed, 7 Aug 2002 08:38:31 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020807083831.37514598.mis@creazone.com>
References: <Pine.LNX.4.33.0208042048550.951-100000@pnote.perex-int.cz>
	<3D4E3AB0.563AB976@ladisch.de>
	<s5hn0s1ehzp.wl@alsa2.suse.de>
	<20020805092258.41ae0bfd.mis@creazone.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020805092258.41ae0bfd.mis@creazone.com>
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

Hi all,

Sorry to annoy you with replies to myself but I thought I'd leave a record of my troubles and a fix.

On Mon, 5 Aug 2002 09:22:58 -0500
Michal Seta <mis@creazone.com> wrote:

> I was away for the weekend so I turned off the computer.  This morning, when I booted up, loaded the firmaware, loaded the snd-usb-midi stuff it still didn't work. Then, I noticed, my synth (Roland GR-50) was displaying an error message (MIDI buffer overflow) but I haven't seen any lights on the interface.  I disconnected the MIDI cables, turned the synth off, reconnected MIDI cables, turned the unit on and voilà.  Everything works.  Now, I'm not sure if I really want to try to reproduce it.

The adventurous part of me said: 'Yeah! go for it!'
so I did.

It is consistently behaving like this.  If I upload the firmware to the mididsport while my synth is on it will not work properly.  If the synth is off (and turn it on after the upload) then everything works as expected.

I have only a Roland GR-50 unit so it could be _only_ this model behaving like that.  Maybe it's just me.  Thanks everyone.

-- 
./MiS

Michal Seta		http://creazone.eworldmusic.com/doc/mis



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
