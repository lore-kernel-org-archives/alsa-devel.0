From: "Thibault Le Meur" <Thibault.LeMeur@supelec.fr>
Subject: RE :  [PATCH 1/2] M-Audio USB
Date: Fri, 15 Dec 2006 10:25:08 +0100
Message-ID: <031101c7202a$ecc35cd0$161ce4a0@supelec.fr>
References: <4582120B.7050500@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <4582120B.7050500@rogers.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: 'Pavel Polischouk' <pavelp@rogers.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


 
> Here's a new proposal.
> Retire the "device_setup=MODE", where MODE is a bitmap of available 
> sample rates and/or resolutions. Every device uses DIFFERENT 
> altsettings 
> for different combinations, it would be too burdensome to 
> keep track of 
> all the devices that require this hack and specifically add 
> support for 
> each one of them (and they will NOT work without this!)

Disagree on the last sentence (should read "will NOT *completely* work"),
but this is a detail ;-) (see my last post)
 
> Instead, add parameter "force_altsetting=NUMBER", which will apply to 
> ANY device if specified. It will skip all altsettings instead of the 
> selected one. It will be a matter of documentation for each M-Audio 
> device to describe what each of these altsettings does. It would be 
> possible to make any other M-Audio device work without patching the 
> driver even further, just an exercise for the user to call the driver 
> with each altsetting separately, figure out what it does and 
> update the 
> documentation. Also, the patch would be rather smaller.

Agree, after re-reading the audiophile usb modes and AltSettings, this
should work for this device and will, as you said, be easier to implement
and maintain.

We would, however, need Clemens Ladisch or Takashi's point of view on this,
since we'll add a param that will potentially affect any usb device.

Thibault



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
