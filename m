From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: S/PDIF support for Intel HDA Realtek ALC880?
Date: Wed, 15 Nov 2006 09:42:02 +1030 (CST)
Message-ID: <200611142312.kAENC291016546@turbo.physics.adelaide.edu.au>
References: <D0623A7E119D564AA1966968BC37AE29C324FA@srvsegbg19.space.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <D0623A7E119D564AA1966968BC37AE29C324FA@srvsegbg19.space.se> from
	"Peter Carlsson" at Nov 14, 2006 09:18:20 AM
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
Cc: Peter Carlsson <peter.carlsson@space.se>, Takashi Iwai <tiwai@suse.de>, Kailang Yang <kailang@realtek.com.tw>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, PeiSen Hou <pshou@realtek.com.tw>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Peter

> I am running Debian (testing) on a Gigabyte GA-K8N51PVMT-9
> motherboard with integrated Intel HDA Realtek ALC880 sound.

I don't have ALC880 hardware - all my work has been done with the ALC260.
My ability to answer your question is therefore somewhat diminished.

> On the motherboard is also a connector for S/PDIF where I
> have attached a back plate. I am using ALSA 1.0.13.
> Could you please tell me if S/PDIF is supported for this
> configuration and if so, how can I enable it?

I really don't know.  I know there's been a lot of work done on the ALC880
support code in recent months but whether that includes SPDIF functionality
isn't something I can answer with any certainty.  I'll try to give some
broad comments though.

> htpc:~# aplay -l
> **** List of PLAYBACK Hardware Devices ****
> card 0: NVidia [HDA NVidia], device 0: ALC880 Analog [ALC880 Analog]
>    Subdevices: 1/1
>    Subdevice #0: subdevice #0

This suggests there is only one playback device, and that would be the
analog interface.  Therefore by default at least it doesn't appear the
SPDIF interface is made available.

Are you using any options when loading the ALSA modules or do you just
go with the defaults?

I'll forward your email onto the ALSA developers mailing list for wider
viewing.  That way you may get some thoughts from the developers actually
working on ALC880 code.

Regards
  jonathan

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
