From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Midi name string in mpu401_uart not unique
Date: Thu, 30 Mar 2006 18:45:23 +0100
Message-ID: <200603301845.23074.gineera@aspect135.co.uk>
References: <200603292313.21160.gineera@aspect135.co.uk> <s5hwtecjiqs.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hwtecjiqs.wl%tiwai@suse.de>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thursday 30 March 2006 12:04, you wrote:
> At Wed, 29 Mar 2006 23:20:54 +0100,
>
> Alan Horstmann wrote:
> > I have patched one solution, adding a parameter to mpu401_uart_new.  Then
> > ice1712 (in my case) generates this string either explicitly from
> > snd_ice1712_card_info or from model string, adding card & device numbers.
> > Diff is attached.
> >
> > What do you think?  There must be other ways to achieve this also.  This
> > diff is just a starting point;  I've included the 'NULL' parameter just
> > in au88x0 as it is my other card.
>
> Instead of adding a new argument to snd_mpu401_uart_new, the caller
> can overwrite the string after creating the instace.
>
> 	snd_mpu401_uart_new(card, device, type, ..., &rmidi);
> 	snprintf(rmidi->name, sizeof(rmidi->name),
> 		"MIDI Name As I Like %d", card->number);
>
> Then the change would be less intrusive.
>
> Or am I missing something else?

Sounds a lot simpler -just involving the driver only; I will try this later.  
In the mpu-names.diff midi names were added to snd_ice1712_card_info to be 
used in the name string.  Is that still a reasonable thing to do, or is there 
a better place, given that the different sub-vendors might have different 
requirements?

Bearing in mind Clemens' comments, is there any value in improving the name 
given by mpu401_uart_new when using ->shortname, as in the diff, by adding 
card and device numbers?

Alan



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
