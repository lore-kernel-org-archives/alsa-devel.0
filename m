From: Allan Klinbail <allank@labyrinth.net.au>
Subject: Re: [Alsa-user] intel8x0 no midi -success
Date: 04 Feb 2003 23:20:36 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1044361243.21697.26.camel@littlewolf2.littlewolf>
References: <Pine.HPX.4.33n.0302040913280.8813-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0302040913280.8813-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

To Clemens, Takashi and David Gerard Matthews

This solution works 
mpu_port="0x330"

I can now see a MIDI port. 

Also to Jaroslav or whoever maintains the ALSA soundcard matrix, I can
confirm that the SiS 645DX chipset works using the intel8x0 module for
audio, in, out and MIDI (recognising it's presence at least but not
completely  tested, but if it works for other intel8x0 cards or
motherboards, I can't see why not. My studio will be setup again this
weekend to test). The chip is also capable of surround output but I
don't have the extension board. 

However, the documentation for this chipset should be altered to reflect
the above in options ... either mpu_port="0x330" or mpu_port="0x300" 

thanks again .. 

Allan Klinbail 


On Tue, 2003-02-04 at 19:15, Clemens Ladisch wrote:
> Allan Klinbail wrote:
> > I've had success getting audio to work using the intel8x0 modules.
> >
> > However I can't seem to get the midi port to work. It is enabled in BIOS
> > and here are my modules options from modules.conf
> >
> > # ALSA portion -SiS onboard sound card
> > alias char-major-116 snd
> > alias snd-card-0 snd-intel8x0
> > options snd-intel8x0 mpu_port="1" ac97_clock="0"
> 
> The mpu_port option specifies the port address of the MIDI port.
> This would be 0x300 or 0x330.
> 
> 
> HTH
> Clemens
> 




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
