From: Brix <brix82@libero.it>
Subject: Re: RawMIDI interface programming
Date: Thu, 11 Sep 2003 18:04:26 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030911180426.7c35cdb8.brix82@libero.it>
References: <20030908143637.4f69b07f.brix82@libero.it>
	<Pine.HPX.4.33n.0309111250210.8134-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0309111250210.8134-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 11 Sep 2003 14:12:08 +0200 (METDST)
Clemens Ladisch <clemens@ladisch.de> wrote:

> What do you mean with "the MIDI synth device"? There could be more
> than one, or none. Usually, you let the user choose the device.
> 
> As default name, you could use "default", which is "hw:0,0" by
> default, but can be changed in the user's .asoundrc.

I didn't explained myself very well :)
I'm working on an ear trainer using the rawmidi interface. I couldn't find any documentation about (it's an incredible lack, i think), so i cutted some code from the web.
I open the device with:

	error =	snd_rawmidi_open( NULL, &handle_out, device_out, 0 );

and I write data with:

	snd_rawmidi_write(handle_out, &data, 1);

Because i would let this application used by newbies, i need a method to obtain (from files in /proc/asound, i think) the name of a working MIDI Synth device. For example on my system i use the SBLive Emu10k1 synth via "hw:0,1" and "hw:0,2", but i tried randomly!

How can i do this? And also, where can i found any documentation? I'm doing things by trying, and i think my program won't wotk on another linux installation!

-- 

	Hardware is never old.
	People just choose the wrong OS.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
