From: Pieter Palmers <pieter.palmers@student.kuleuven.ac.be>
Subject: Re: An offer to help from a Linux Device Driver engineer
Date: Tue, 13 May 2003 21:55:27 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EC14DAF.7070904@student.kuleuven.ac.be>
References: <286558.1052850103221.JavaMail.nobody@daisy.psp.pas.earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: John Hubbard <hubbardjohn@earthlink.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

You are always welcome to help building a driver for the Guillemot 
Maxisound ISIS. I could use some help. Although the card isn't built 
anymore, quite some people in the 'enthousiast' field use them. I can 
assure you that you'll have plenty of expertise when finishing this 
one... the card uses such a variety of techniques that a lot of ALSA 
interfaces should be implemented:

  PCI controller (ESS Maestro 2E) & AC97 codec (mixer + streaming wave), 
for standard audio I/O  (=> PCI DMA transfer)
  Streaming wave support through callbacks for the SAM9707 daughter chip 
for 8 out / 4 in @16bit 48kHz multichannel IO   (=> no DMA, 
callback/interrupt based transfer)
 
  Mixer for the SAM's channels
 
  MPU401 on the SAM and the ESS chips
 
  Static wave buffer on the SAM (a part of ALSA not commonly used I think)
 
  Joystick on the ESS

  SPDIF on the ESS (and maybe on the SAM)

The card aimed to be both a game card and a musicians card. Weither it 
succeeds in being that is of no importance ;) but this surely resulted 
in a quite complex architecture.
To make things even worse, the SAM support should be written with 
extension in mind. This way we can support the SAM9407 based cards too 
(Terratec EWS64/Maxisound Homestudio/Hoontech Soundtrack) with minor effort.

should you be interested, take a look at http://isisalsa.sourceforge.net.

Should you be interested in buying one, I saw that 
http://axemusic.com/index_menu.htm sells them for 99 canadian $ ... and 
there should be a lot of them floating around on the second hand market, 
because of the fact that Guillemot doesn't support them anymore and that 
there are no drivers available for WinXP.

Pieter

John Hubbard wrote:

>Hello,
>    May I help the ALSA project, by building device drivers for anything that is not yet supported?  I am a device driver engineer looking to gain experience with Linux Audio, and to advance my knowledge in this area.  I definitely have an ulterior motive (to enhance my resume) but I also happen to love composing on my SY-85 synthesizer in my spare time, so this is not as unnatural as it sounds...
>
>    My first idea was to find an unsupported sound card, purchase one, and provide ALSA support for it.  However, after lurking on this mailing list for a few days, I see that you all  have been busy, and it may actually be difficult to find an unsupported card.
>
>   Can anyone advise me as to kernel/driver work that needs to be done here?
>
>thanks,
>john h
>-------------------------
>John F. Hubbard
>hubbardjohn@earthlink.net
>
>
>
>
>
>-------------------------------------------------------
>Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
>The only event dedicated to issues related to Linux enterprise solutions
>www.enterpriselinuxforum.com
>
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/alsa-devel
>
>  
>





-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
