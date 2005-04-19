From: =?iso-8859-1?Q?R=FCdiger_Dabelow?= <ruediger@dabelow.de>
Subject: AW: maestro3 hardware volume control
Date: Tue, 19 Apr 2005 12:55:00 +0200
Message-ID: <000501c544ce$3d437530$6502a8c0@SCA600>
References: <s5h3btnccza.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h3btnccza.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> Von: Takashi Iwai
> Gesendet: Dienstag, 19. April 2005 11:50
> Betreff: Re: [Alsa-devel] maestro3 hardware volume control
> 
> At Mon, 18 Apr 2005 15:22:58 +0200,
> rwd wrote:
> > 
> > Hi,
> > 
> > the maestro3 runs fine on my compaq evo n400c (ES1988). 
> Just one thing
> > remains unsolved - the 2 nice volume control buttons that 
> seem to be wired
> > directly to the ES1988 won't work until now. 
> > 
> > I'm relatively new to linux and not a driver programmer, 
> but scrolling
> > through the documentation of the chip & the driver source 
> quickly revealed
> > that the volume can be controlled directly by two buttons, 
> but the driver
> > doesn't seem make use of that. 
> > 
> > Can anybody give me a hint how to use/enable the hardware 
> volume control on
> > that chip? Is a major rewrite of the driver required? Maybe 
> some other
> > driver could do that? The es1968 seems to support hw vol, 
> might that driver
> > run also on the ES1988?
> 
> The problem is -- we don't know.  We have no proper datasheet for this
> chip...
> 
> 
> Takashi

Hi,
Sorry, don't understand:

the driver es1968.c enables and uses 

#define HWV_CONFB		0x0080
w |= HWV_CONFB;		/* HWV on */
pci_write_config_word(pci, ESM_CONFIG_B, w);

and handles the irq. The es1968.c driver handles the Maestro-2, does it?
http://www.alsa-project.org/alsa/ftp/manuals/ess/DSMaestro2.pdf

Same registers as described in the datasheet for the
ES1988/Allegro/Maestro-3
http://www.alsa-project.org/alsa/ftp/manuals/ess/ds1988.pdf

What info is missing? 

Ruediger




-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
