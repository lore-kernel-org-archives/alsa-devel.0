From: Christian Schumann <schumann@physik.uni-kl.de>
Subject: [Alsa-user] Mindprint DI-MOD USB
Date: Mon, 15 Jan 2007 14:22:44 +0100
Message-ID: <20070115132244.GA13878@diller-5.physik.uni-kl.de>
References: <20070108083335.GA9576@diller-5.physik.uni-kl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20070108083335.GA9576@diller-5.physik.uni-kl.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 08, 2007 at 09:33:35AM +0100, Christian Schumann wrote:
> this weekend I bought a Mindprint EnVoice MkII Digital Edition with the
> DI-MOD USB installed. I can get it to work using the regual usb-audio
> driver, but there are still some issues that are quite unconvenient and
> perhaps you can help me in sorting them out:
> 
> Whenever I connect the USB interface to my computer, the sampling rate
> is switched to 96 kHz, which also influences the sampling rate of the
> SPDIF output. The rest of my setup is working at 48 kHz, so I'd like the
> driver to initialize the device directly with 48 kHZ, and not haveing to
> switch the sampling rate manually.
> 
> Further, the Windows driver has a switch to enable/disable the SPDIF
> output, which I am using. So I had to take the device to a Windows
> machine in order to enable SPDIF in the first place. Perhaps this can
> also be switched under Linux.
Ok, so that nobody replied to my mail to alsa-user, I did some research
myself. I contacted Mindprint, and they told me to get into contact with
usb-audio.com. I asked them for specifications, so the default USB-audio
driver could be extended, or perhaps a special driver for the DI-MOD USB
could be written. I'm still waiting for them to reply.
I have never written a driver myself, and my programming knowledge only
suffices to do some minor modifications to existing drivers. So ist
there any developer who would be willing to look at the situation?

Regards,
Christian Schumann

-- 
------------------------------------------------------------------------
Dipl.-Phys. Christian Schumann   |Technische Universitaet Kaiserslautern
Mail: schumann@physik.uni-kl.de  |           Fachbereich Physik
Tel.: 0631/205-4842 (Office)     |     http://www.physik.uni-kl.de 
Tel.: 0631/205-4843 (Lab)        |
Fax.: 0631/205-3902              |    
Post: Erwin-Schroedinger-Strasse, D-67663 Kaiserslautern
-------------------------------------------------------------------------


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
