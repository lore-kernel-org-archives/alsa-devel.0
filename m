From: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Subject: Re: MIDI port names
Date: Thu, 20 Feb 2003 20:55:59 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200302202055.59510.plcl@telefonica.net>
References: <Pine.LNX.4.44.0302201514060.1266-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0302201514060.1266-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Thursday 20 February 2003 15:14, Jaroslav Kysela wrote:
> On Thu, 20 Feb 2003, Takashi Iwai wrote:
> > At Thu, 20 Feb 2003 09:55:18 +0100 (CET),
> >
> > Jaroslav wrote:
> > > On Thu, 20 Feb 2003, Pedro Lopez-Cabanillas wrote:
> > > > On Wednesday 19 February 2003 14:51, Takashi Iwai wrote:
> > > > > there is the name field for each rawmidi substream, and the
> > > > > sequencer looks up this string.
> > > > >
> > > > > this reminds me the former patch by Clemens, and i've forgotten to
> > > > > check this issue until now.  sorry.
> > > > >
> > > > > i modified the sequencer part (and mpu401_uart) on the cvs so that
> > > > > the sequencer retrieves the rawmidi name string if the substream
> > > > > name is not defined.
> > > >
> > > > But Clemens' patch (attached is a slightly modified version) was not
> > > > for port names but for client names, from "External MIDI x" to the
> > > > more meaningful rawmidi name. I think that this is what some people
> > > > is requesting, and makes things easier for large studio setups when
> > > > some applications, like kaconnect, show client names but not port
> > > > names. Please, apply.
> > >
> > > I don't agree with this patch. kaconnect or other applications might
> > > simply parse the string and if matches - get the real name over the
> > > control interface. Otherwise, it is not clear, that the port is equal
> > > to a rawmidi device.
> >
> > it's of course a bit dangerous to change such behavior.
> >
> > but basically, the application shouldn't rely on the client name
> > string to get its information.  and, AFAIK, there are no applications
> > to do that, so far.  hence, i don't think it would cause much
> > problems.
> >
> > if it looks ok for you, i'll commit more changes in this regard,
> > including:
> >
> > - set the sequencer client name from rawmidi name (like above)
> > - reset the sequencer client name for the rawmidi device 0
> >   in the case that other device was registered formerly.
> > - set the name of mpu401_uart from card's shortname if already
> >   defined.
> >
> > the last one requires the definition of the shortname field before
> > calling snd_mpu401_uart_new().  if not defined, "MPU401 (UART)" is
> > used like the older version.
>
> If there is a way to determine the connection between sequencer port and
> rawmidi device, I'm ok with any solution. Otherwise, please, solve this
> problem.
>
> 						Jaroslav
>
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SuSE Labs

Hi Jaroslav,

I understand your complaints, so let me to propose another solution. Or almost 
contribute to the brainstorming session :-) 

What about card->id instead of card->number ? I mean, something like "External 
MIDI ENS1371" for client names. Or perhaps only the card->id field alone. 
This allows you to reach the relevant information from ctl interface, with 
only a little more work compared with having card->number inside the client's 
name. 

The card->id field can be used also to compose a path name with  
("/proc/asound/" + card->id) giving the name of a symlink to the 
/proc/asound/cardX directory, allowing an easy way to get some information, 
inclusively for scripts.

The card->id field allows also a customization level, via the "id" module  
params available to every ALSA driver, so the user  can change, for example, 
"ENS1371" to something like "SB 128 PCI", or any other meaningful, user  
friendly name.

Finally, with this solution we don't need to add another field to 
snd_seq_client_info_t or any other data structure. Hmmm. Sounds too much good 
to be true, so I think I missed again some point :-) 

Regards,
Pedro

-- 
ALSA Library Bindings for Pascal
http://alsapas.alturl.com



-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
