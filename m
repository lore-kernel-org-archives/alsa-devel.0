From: "Anandhi  Dhanabalan" <anandhid@rediffmail.com>
Subject: RE: AC'97 compliant codec - query
Date: 8 May 2002 05:27:53 -0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020508052753.9669.qmail@webmail16.rediffmail.com>
Reply-To: "Anandhi  Dhanabalan" <anandhid@rediffmail.com>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

Thanx for U'r response Solomon.
The CS4205 will be paired with a digital controller in x86 based 
geode processor.
I understand how the busmaster in the controller need to be set up 
for audio data transfer, But What i need to know is, how to 
write/read the codec registers ?

I am new to the list as well. Could U pls tell me where i can find 
the code samples U had mentioned

Thanx & Regards
Anandhi



>On Tue, May 07, 2002 at 01:30:10PM -0000, Anandhi  Dhanabalan 
>wrote:
> > I am a new to Audio driver development. I am currently 
>developing
> > a driver for Crystal Audio codec CS4205.
>
>You'll never use the CS4205 directly -- it is just an AC97 
>codec.
>You'll also need an AC97 controller, such as the one in the
>ICHx/southbridge chip in most modern chipsets.
>
>That controller handles all of the details of serializing data 
>and
>whatnot.  You need to set up the controller to pass data in the 
>right
>slots, and set up the codec's mixer and whatnot.
>
>The CS4205 is specifically supported by the ac97_codec driver 
>in
>alsa0.9.0rc1, and more generically supported by earlier versions.  
>You
>may want to look at the intel8x0 driver code as well, as that
>is little
>more than a thin hardware wrapper around the ac97 codec.
>
>  - Pizza

_________________________________________________________
Click below to visit monsterindia.com and review jobs in India or 
Abroad
http://monsterindia.rediff.com/jobs


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
