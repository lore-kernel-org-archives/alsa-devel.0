From: Miguel Duarte <mjrduarte@mail.telepac.pt>
Subject: Re: Re: Audigy 2 Platinum eX Remote (Some developer please read thi
Date: Wed, 24 Sep 2003 11:45:00 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030924104501.ORS9998.fep06-svc.mail.telepac.pt@[127.0.0.1]>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Then maybe it should be included in the documentation... :)

As for the echo... I thought of that... This morning (good idead allways come when I'm half asleep :p).


Miguel Duarte


> 
> De: Takashi Iwai <tiwai@suse.de>
> Data: 24/09/2003 11:02:12
> Para: Miguel Duarte <mjrduarte@mail.telepac.pt>
> CC: <alsa-devel@lists.sourceforge.net>
> Assunto: Re: [Alsa-devel] Audigy 2 Platinum eX Remote (Some developer please read this)
> 
> At Wed, 24 Sep 2003 10:36:45 +0100,
> Miguel Duarte wrote:
> > 
> > Hi,
> > 
> > Until now I wasn't able to make my remote work.
> > While posting in the EMU10K1 devel mailing list, someone said that it was necessary to "initialize" the MIDI device used by the remote. A SysEx sequence has to be send to '/dev/snd/midiC0D1'. The sequence is '0xf0, 0x00, 0x20,0x21, 0x61, 0x0, 0x00, 0x00, 0x7f, 0x0, 0xf7'.
>  
> oh, my...
> 
> > The source code bellow is of a program that does just that. After
> > modprobing the modules with the correct options (the options are the
> > same as the Platinum), just run this prog to "initialize" the midi
> > device. Voi-lá! The remote works! I think this is an ugly hack.
> 
> i don't think it's so bad.
> 
> >I'm sure that this can be implemented in the driver itself.
> 
> yes, but why bother to do this in the driver, although you can do it
> nicely on user-space? 
> (you can even use shell's echo command for this :)
> 
> 
> anyway, thanks for your info!
> 
> 
> Takashi
> 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
