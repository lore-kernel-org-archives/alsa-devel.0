From: Niklas Werner <bergtroll@gmx.li>
Subject: Re: new alsa docs.
Date: Wed, 7 Aug 2002 19:11:57 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200208071711.TAA12328@papaschlumpf.wg>
References: <3D4E9F05.4080403@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3D4E9F05.4080403@boosthardware.com>
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

Am Montag, 5. August 2002 17:51 wurde geschrieben:
> I'm have soreted out all the final bugs I had with the new docs setup.
> Added the midi stuff and I feel that the site is ready for prime time.
>
> You can see it here:
>
> http://www.alsa-project.org/alsa-doc/
>
> I appreciate other people going through it but I will make some links
> to it from the main page tonight.

You might want to add Emagic's "EMI 2|6" to the matrix at least in green, 
though it works fully for me with the following:

-> using tapio laxströms firmware loader (yes, he signed a NDA...) from 
http://www.vtoy.fi/~tapio/emi26.html to load the firmware

-> Then using the usb-audio-driver

-> .asoundrc: 
==================
pcm.emi {
        type hw;
        card 0;
}
ctl.emi {
        type hw;
        card 0;
}
==================

-> modules.conf:
==================
alias char-major-116 snd
alias char-major-14 soundcore
# EMI 2|6
alias snd-card-0 snd-usb-audio
alias sound-slot-0 snd-card-0
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-12 snd-pcm-oss
options snd-usb-audio snd_id="emi"
==================

Unfortunately there are a few system-hangups I experienced on my 
intel-box, but I suspect my setup isn't very clean any more...
On my ppc it runs just fine ;-)

Have fun*

Niklas


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
