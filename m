From: Raymond <rayau@netvigator.com>
Subject: Re: au88x0 modem
Date: Thu, 15 Sep 2005 23:34:03 +0800
Message-ID: <4329946B.9030407@netvigator.com>
References: <20050911124530.GA16795@titan.lahn.de> <4325AEA3.1090602@netvigator.com> <20050913000909.GB19713@tecr> <20050913085552.GA2655@titan.lahn.de> <20050913173529.GD31269@sashak.softier1.local> <20050913174930.GA5816@titan.lahn.de> <4327DA14.3040205@netvigator.com> <20050914205608.GD14657@sashak.softier1.local> <20050915091158.GA7314@titan.lahn.de> <20050915092155.GA7328@titan.lahn.de> <20050915143533.GB23218@sashak.softier1.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050915143533.GB23218@sashak.softier1.local>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Sasha Khapyorsky wrote:
>
> 
> Great, the secondary modem codec is there. The valid codec id bits are
> 24:25 (AC97 interface supports up to four codecs):
> 
> #define VORTEX_CODEC_ID_SHIFT 24
> 
> I will send cleaned codec access patch separately and will look what is
> next.


It would be more easy to debug/maintain the driver if using different
read/write routines for audio and modem codec.

Audio codec is always primary in sound card and audio/modem combo

The existing vortex_codec_read() and vortex_codec_write() can remain
unchanged.

Just add new routine vortex_modem_codec_read() vortex_modem_code_write()
to handle secondary/primary modem codec for audio/modem combo and PCI
modem card.

http://www.nix.ru/autocatalog/modems/AurVcomPCIV90RTL_5817.html

Make sure your patch is 32bits/64bits compatible

AMD64 user may use the  PCI audio/modem combo card and PCI modem card.

 > mainly I'm not about cleanups now. The goal is to hack modem. It looks
 > for me that right sequence is:
 >
 > 1. Find and initialize modem codec (secondary).
 > 2. Find and hack appropriate DMA channels, initialize modem PCM.
 > 3. Find valid way to access GPIO (for DAA controls like Hook-Off)
 > 4. Chipset detailed cleanups.
 >
 > Currently we are in (1).

I guess (1) and (3) already completed at least for Si3036 in L8400B








-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
