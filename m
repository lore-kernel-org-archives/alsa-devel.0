From: Olaf Hering <olh@suse.de>
Subject: Re: 2.6.10, oops in snd_usb_audio after unplugging audio device
Date: Mon, 3 Jan 2005 15:20:46 +0100
Message-ID: <20050103142046.GA21556@suse.de>
References: <20041214211116.GA21561@suse.de> <s5hacsexon1.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hacsexon1.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-usb-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

 On Thu, Dec 16, Takashi Iwai wrote:

> At Tue, 14 Dec 2004 22:11:16 +0100,
> Olaf Hering wrote:
> > 
> > 
> > Got a soundblaster live 24bit today, it works ok with 2.6.10-rc3.
> > 
> > I got this crash while playing a wav file in a loop.
> > while true;do aplay /usr/share/sounds/alsa/test.wav;done
> > The volume tuner on the box does not work for some reason, it acts also
> > as mute button.
> 
> The device doesn't change the mixer volume internally.
> The mute with the button works while _unmute_ doesn't work.  It only
> mutes regardless how many times you pressed it.  The only way to
> unmute or adjust volume is to do in software.
> I'm wondering how to handle it, since lsusb doesn't show any HID or
> even vendor-specific stuff.

Did you try it with Windows? Any idea how to make it work? I guess we
need some USB snoop tool to see how the thing works.


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
