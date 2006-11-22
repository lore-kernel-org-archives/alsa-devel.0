From: "Thibault Le Meur" <Thibault.LeMeur@supelec.fr>
Subject: RE :  snd-usb-audio and M-Audio Quattro problems.
Date: Wed, 22 Nov 2006 10:29:11 +0100
Message-ID: <00d401c70e18$ae2c20c0$161ce4a0@supelec.fr>
References: <20061121224949.p1tiihvts08k4k0c@webmail.supelec.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20061121224949.p1tiihvts08k4k0c@webmail.supelec.fr>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: 'Thibault Le Meur' <Thibault.LeMeur@supelec.fr>, 'Pavel Polischouk' <pavelvp@inbox.ru>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


> >
> > After seeing no activity on the bug for some time I decided to 
> > investigate the problem further. First I tried to extend the 
> > Audiophile hack to Quattro (that disables all altsettings on driver 
> > init except the one desired). Surprisingly it worked - 
> almost. It only 


Your patch changes the AUDIOPHILE_* constant to MAUDIO_* constants.
This is ok, but the Fast Track Pro patch submitted by "Peter Oehry" would
need a trival rework to be applied.

> > works the first time after Quattro has been powered up, after that, 
> > re-loading the driver doesn't help - the device sticks to the old 
> > state.
> 
> Another 'M-audio usb' user recently wrote a patch for the Fast track  
> pro (however I'm not sure it has been included in the hg repository  
> yet). I wonder if he had managed to handle such setup switching for  
> his device.

See the "snd-usb-audio - Driver for M-Audio Fast Track Pro" thread (August
2006) from Peter Oehry.

HTH,
Thibault



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
