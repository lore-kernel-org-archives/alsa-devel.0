From: "danu" <danu@rediffmail.com>
Subject: Re: Re: LoopBack Mode for cirrus codec cs4205 - Help needed
Date: 20 Aug 2002 11:20:21 -0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020820112021.21830.qmail@webmail24.rediffmail.com>
Reply-To: "danu" <danu@rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 20 Aug 2002 Takashi Iwai wrote :
>At 20 Aug 2002 05:17:30 -0000,
>danu wrote:
> >
> > Hello people,
> >
> > I am new to this group.
> >
> > 1) Does ALSA provide driver support for CS4205 codec ?
>
>yes.

Danu> Could you please let me know in which version of ALSA the 
driver for CS4205 is available ?
I downloaded "alsa-driver-0.4.0" from alsa site but didn't find 
cs4205 related file.

>
> > 2) I am doing diagnostics for CS4205 codec. I set the codec 
>in
> > Loopback mode(ADC o/p is fed to DAC i/p without involving
> > AC-Link), Feed data to LINE_IN Pin using external Function
> > generator and try to analyse the output at LINE_OUT.
> > But i don't get any o/p at the LINE_OUT pin. I set the codec 
>in
> > Digital Centeric mode and all other register setting seems to 
>be
> > fine.
> >
> > Anyone encountered such problems with Loop Back mode with 
>cirrus
> > codecs ?
>
>did you set the module option "enable_loopback" for 
>snd-ac97-codec?
>without it, no ADC/DAC loopback control will appear.

Danu> I have enabled Loop Back in the Genral Purpose 
Register(Index 20h) in the codec.
FYI, I am not using any of ALSA code as yet.

Thanx for the help.

Best Regards
Danu

__________________________________________________________
Give your Company an email address like
ravi @ ravi-exports.com.  Sign up for Rediffmail Pro today!
Know more. http://www.rediffmailpro.com/signup/



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
