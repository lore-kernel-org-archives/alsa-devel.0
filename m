From: Sasha Khapyorsky <sashak@smlink.com>
Subject: Re: au88x0 modem
Date: Fri, 16 Sep 2005 21:20:27 +0300
Message-ID: <20050916182027.GD17864@tecr>
References: <20050913085552.GA2655@titan.lahn.de> <20050913173529.GD31269@sashak.softier1.local> <20050913174930.GA5816@titan.lahn.de> <4327DA14.3040205@netvigator.com> <20050914205608.GD14657@sashak.softier1.local> <20050915091158.GA7314@titan.lahn.de> <20050915092155.GA7328@titan.lahn.de> <20050915143533.GB23218@sashak.softier1.local> <20050915204345.GC27700@sashak.softier1.local> <432A8081.7030603@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <432A8081.7030603@netvigator.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Raymond <rayau@netvigator.com>
Cc: alsa-devel@lists.sourceforge.net, pmhahn@titan.lahn.de
List-Id: alsa-devel@alsa-project.org

On 16:21 Fri 16 Sep     , Raymond wrote:
> 
> Although au8830 may support mulitple codecs and there is a unconnected
> 20-pins connectors on my au8830 (Subsystem 12eb:0088)
> 
> There is only one STAC9708 (4-channels) audio codec on my au8830
> 
> It look like a control register rather than a status register.
> 
> Vortex: init.... <6>CODEC_EN : 00000000
> CODEC_EN : 00000300
> CODEC_EN : 00003300
> CODEC_EN : 00003f00
> done.

Hmm, CODEC_EN is useless for secondary codec autodetection. Could you
try to investigate it, probably compare 8810/8830 registers values -
there should be some bits indicating secondary AC97 codec presents.

Sasha.


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
