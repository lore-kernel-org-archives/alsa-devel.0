From: "John F. Hubbard" <hubbardjohn@earthlink.net>
Subject: Guillemot Maxisound Support
Date: Thu, 15 May 2003 01:20:56 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <5.2.0.9.2.20030515004237.00a96970@mail.earthlink.net>
References: <286558.1052850103221.JavaMail.nobody@daisy.psp.pas.earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <3EC14DAF.7070904@student.kuleuven.ac.be>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pieter Palmers <pieter.palmers@student.kuleuven.ac.be>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Pieter,

     The Guillemot Maxisound looks like the perfect starter project for an 
ALSA newcomer such as myself: complex, well-documented, yet 
affordable.  (Thanks to everyone who recommended things to work on.  I have 
had a grand time browsing through some great audio hardware.)

     I would love to help with this thing.  I'll go get one, and begin 
working with it.  An initial look at the CVS repository seems to show that 
we do not yet have any SAM9707 code in there.  Please correct me if I have 
missed it.

thanks,
john h
---------------------------------------
John F. Hubbard
hubbardjohn@earthlink.net


At 09:55 PM 5/13/2003 +0200, Pieter Palmers wrote:
>Hi,
>
>You are always welcome to help building a driver for the Guillemot 
>Maxisound ISIS. I could use some help. Although the card isn't built 
>anymore, quite some people in the 'enthousiast' field use them. I can 
>assure you that you'll have plenty of expertise when finishing this one... 
>the card uses such a variety of techniques that a lot of ALSA interfaces 
>should be implemented:
>
>  PCI controller (ESS Maestro 2E) & AC97 codec (mixer + streaming wave), 
> for standard audio I/O  (=> PCI DMA transfer)
>  Streaming wave support through callbacks for the SAM9707 daughter chip 
> for 8 out / 4 in @16bit 48kHz multichannel IO   (=> no DMA, 
> callback/interrupt based transfer)
>  Mixer for the SAM's channels
>  MPU401 on the SAM and the ESS chips
>  Static wave buffer on the SAM (a part of ALSA not commonly used I think)
>  Joystick on the ESS
>
>  SPDIF on the ESS (and maybe on the SAM)
>
>The card aimed to be both a game card and a musicians card. Weither it 
>succeeds in being that is of no importance ;) but this surely resulted in 
>a quite complex architecture.
>To make things even worse, the SAM support should be written with 
>extension in mind. This way we can support the SAM9407 based cards too 
>(Terratec EWS64/Maxisound Homestudio/Hoontech Soundtrack) with minor effort.
>
>should you be interested, take a look at http://isisalsa.sourceforge.net.
>
>Should you be interested in buying one, I saw that 
>http://axemusic.com/index_menu.htm sells them for 99 canadian $ ... and 
>there should be a lot of them floating around on the second hand market, 
>because of the fact that Guillemot doesn't support them anymore and that 
>there are no drivers available for WinXP.



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
