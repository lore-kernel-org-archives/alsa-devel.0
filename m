From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Asus P5W DH Deluxe 's intel-hda unknown in codec
Date: Fri, 22 Dec 2006 20:35:57 -0800
Message-ID: <1166848557.10168.11.camel@localhost>
References: <1166846854.11797.49.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1166846854.11797.49.camel@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Nicolas Di Pietro <potens@swing.be>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 2006-12-23 at 05:07 +0100, Nicolas Di Pietro wrote:
> Hi,
> I'm experimenting some problems with the hda-intel module because my
> soundcard isn't recognized by the module (in fact, the module find that
> it's a hda-intel but it doesn't know the codec to use and try guessing
> by the bios). I've tried to use other codecs but it just ignore it ie:
> modprobe snd-hda-intel model=6stck-dig
> give me :
> hda_codec: Unknown model for ALC882, trying auto-probe from BIOS...

Did you try "model=6stack-dig"? (I noticed a typo in your modprobe
line).

If that doesn't work (check dmesg output), then you can add a single
line in alsa-driver-1.0.14rc1/alsa-kernel/pci/hda/patch_realtek.c to add
your system.  Look for "alc882_cfg_tbl", and add: 

SND_PCI_QUIRK(0x1043, 0x81d8, "Asus P5WD", ALC882_6ST_DIG),

Give that a try and see if it helps.


-- 
Tobin Davis <tdavis@dsl-only.net>


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
