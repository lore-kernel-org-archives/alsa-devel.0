From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: RME9652 HDSP and DSP status?
Date: 09 Apr 2003 10:00:06 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1049875206.1378.24.camel@satellite.undata.org>
References: <200304090905.50939.torger@ludd.luth.se>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200304090905.50939.torger@ludd.luth.se>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Anders Torger <torger@ludd.luth.se>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> I'm a bit uncertain which of RME's hammerfall cards that currently work 
> with ALSA (cvs or stable). Looking at RME's website, these are the RME 
> Hammerfall products:
> 
I'll answer when I can.

> RME Hammerfall DSP - Cardbus or PCI interface with breakout boxes
>    http://www.rme-audio.de/english/hdsp/cardpci.htm
>    http://www.rme-audio.de/english/hdsp/digifa.htm
>    http://www.rme-audio.de/english/hdsp/multifa.htm
> 

Support is in stable for older revisions (0xa card firmware).
Support is in cvs for newer cards, and updated card firmwares.
(Warning : "firmware" can be confusing - it can refer both to the pci or
cardbus card flashable firmware or to the FPGA firmware which needs to
be loaded in the card when powered on.)

> RME HDSP9652 - the new version of RME DIGI9652  
>    http://www.rme-audio.de/english/hdsp/hdsp9652.htm
> 
Support in cvs (with the patch I just sent).

> The only cards I know work with ALSA from own experience, is the RME 
> DIGI9652 and RME DIGI9636 (aka "RME Hammerfall" and "RME Hammerfall 
> Light").
> 
> The ALSA sound card matrix state support for Hammerfall DSP as well. 
> Does this include both the Cardbus and PCI interface, and both breakout 
> boxes (digiface and multiface)? Are there any limitations in 
> functionality?

In stable version there are (see above + you can't use rates > 48000 Hz)
Cvs should be really closer to the functionalities of the windows and
mac versions. The only missing things are : totalmix (coming soon) and
Adat Sync Timecode support.

> 
> Does the rme9652 driver work with the new Hammefall version, HDSP9652?
> 
No, the snd-hdsp driver should be used.

Thomas




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
