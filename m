From: Frank Barknecht <fbar@footils.org>
Subject: Re: [PATCH] Edirol UA-20 PCM support
Date: Mon, 24 Feb 2003 15:39:02 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030224143902.GA8502@fliwatut.scifi>
References: <20030224122354.GA9568@fliwatut.scifi> <Pine.HPX.4.33n.0302241409180.20472-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0302241409180.20472-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hallo,

before I go on, I must say: I decided to send the UA-20 back to my
dealer and probably buy a Quattro instead. This seems to be the more
flexible device with the only drawback, that it's not USB-powered and
more expensive. I'm getting a bit tired from being Edirol's laboratory
animal. Why didn't they implement the standard they wrote? But what's
more important, I discovered, that I might need 4-channel output soon.
4-channel and 4-channel and midi seems to be supported best on the
Quattro. 

And what's the most important thing to me: Pd doesn't seem to like the
24-bit-depth or so either, and it doesn't support the plugin layer of
ALSA yet. So I cannot use Pd, which is the audio software that is
running here 12/7.

Clemens Ladisch hat gesagt: // Clemens Ladisch wrote:

> So PCM works.  :-)

Yep. 

> > OSS-emulation doesn't work.
> 
> OSS doesn't support 24-bit sample formats.

I suspected that. Might be one more reason to get a Quattro. 

> > I cannot use or see the midi devices (anymore).
> 
> Are there any messages in /var/log/messages? Is interface #3 in use by the
> snd-usb-audio driver (see /proc/bus/usb/devices)?

It says: "Sub=03 Prot=00 Driver=(None)" at the Edirol, whereas the
other interfaces are claimed by snd-usb-audio. I have a kernel without
any OSS sound modules besides soundcore. 

ciao
-- 
 Frank Barknecht                               _ ______footils.org__


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
