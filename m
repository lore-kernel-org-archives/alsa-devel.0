From: Guenther Sohler <guenther.sohler@newlogic.com>
Subject: Re: silent midi in audixy
Date: Fri, 22 Feb 2002 12:42:04 +0100 (MET)
Message-ID: <XFMail.20020222124204.guenther.sohler@newlogic.com>
Reply-To: Guenther Sohler <guenther.sohler@newlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
In-Reply-To: <s5hpu2x7q67.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hallo Jaroslaw,

I think just by now I understand things better.
I thought the emu10k1 was used on the sb live card and on the audixy card.
But in fact the audixy chip is the next generation of the emu10k1.
emu10k1 is used in sblive whereas the audixy chip is used in the creative audixy
Is this right ?
> 
> yes, but the midi engine is identical.  if this makes so big
> difference, then there must be a (secret) difference between emu10k1
> and audigy chips.
I would be very much interested, if pcm music(playing mp3) as approximately the
same volume as playing weavetable(play midi) on a sb live.
Just play them simultaniously although it does not sound nice. could you please
test this for me on your sblive ?


> i wonder, too :)  i wrote the driver just based on the code/info from
> OSS driver.  anyway i'll get an audigy soon, so debugging will
> be much easier.
ok, fine :)


> which soundfont, and how devices are connected.
i use a soundfont called gm35revc.sf2 which came with my old awe64
i also tried the new soundfount ct4 ..... ??? (name not exactly known) which
was on the current audixy cd. its quite similar in volume!
i have looked into the samples of gm35revc and they span from -32768 to 32767.
so all dynamics is used optimally.

> i tried xgmc you attached ago and it seems working fine.
fine. So I assume its so userfriendly, that others can at least start it
*lough*

I am look forward to having it to completely working.

rds guenther


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
