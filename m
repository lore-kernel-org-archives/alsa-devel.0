From: Maggio <voloterreno@tin.it>
Subject: Re: DXS broken with some cards in 1.0.X in module snd-via82xx?
Date: Mon, 01 Mar 2004 16:28:54 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <404356B6.6010407@tin.it>
References: <40434209.6020903@tin.it> <s5hoerghcyr.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hoerghcyr.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Takashi Iwai wrote:

| At Mon, 01 Mar 2004 15:00:41 +0100, Maggio wrote:
|
|> Hi ,
|>
|> I was just wondering if the DXS support in 1.0.X has broken the
|> DXS_SUPPORT=1 with some cards .
|>
|> I have an Abit KV7 Motherboard , and I use snd-via82xx for sound
|> .
|>
|> I use this module from the version "0.9.8" , and I've never had
|> any problems in enabling "dxs_support=1" with the 0.9.X series of
|> the drivers , yesterday , by trying 1.0.2c and today the 1.0.3
|> versions of the kernel modules , I've noticed that ALSA doesn't
|> work anymore with DXS_SUPPORT=1 , because the sound is garbled  ,
|> and I can only use DXS with DXS_SUPPORT=4 .
|>
|> What's up?
|
|
| i don't know - there are no big changes regarding this area. if
| dxs_support=4 works for you, please send me the patch for dxs white
|  list.
|
|
| Takashi
|
|
| ------------------------------------------------------- SF.Net is
| sponsored by: Speed Start Your Linux Apps Now. Build and deploy
| apps & Web services for Linux with a free DVD software kit from
| IBM. Click Now!
| http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
| _______________________________________________ Alsa-devel mailing
| list Alsa-devel@lists.sourceforge.net
| https://lists.sourceforge.net/lists/listinfo/alsa-devel
|

Ok , I've made the patch , but I continue to ask me why this
regression (on my board) from 0.9.8 to 1.0.2c/1.0.3.

Maybe some changes in snd-ac97-codec module? Or what? I've compared
the two diffs between 0.9.8 and 1.0.2/1.0.3 and there aren't very much
differences in snd-via82xx (primarly them don't seem related to the
problem) .

The patch is attached.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAQ1a2c/np+8AbwbcRAibsAJ4tcFGPJW0yjCoaNpdUNSZyA4gajgCdEwnq
oOldyoycxXiU9q4nGR8GHGA=
=fGY0
-----END PGP SIGNATURE-----



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
