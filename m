From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: ca0106 with MIDI
Date: Sun, 16 Oct 2005 11:53:15 +0100
Message-ID: <4352311B.1050607@superbug.co.uk>
References: <43521DF8.2040401@tk-sls.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-35.mail.demon.net (anchor-post-35.mail.demon.net [194.217.242.85])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E8E13197
	for <alsa-devel@alsa-project.org>; Sun, 16 Oct 2005 11:47:27 +0200 (MEST)
In-Reply-To: <43521DF8.2040401@tk-sls.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Tilman Kranz <tilman.kranz@tk-sls.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Tilman Kranz wrote:
> Hello.
> 
> with regards to the "ca0106" driver for the Creative Audigy LS I would 
> like to ask if there are activities to make the "Creative External MIDI" 
> (MS W* nomenclatura) resp. the "Creative Labs SB Audigy LS MIDI/Game 
> port" (Linux PCI name Db. nomenclatura) available.
> 
> I have a MIDI In/Out connection attached. I currently am performing a 
> variety of tests  using win+sequencer software.
> Specifically:
> 
> I run with Linux Kernel 2.6.12.3. I also have access to CVS alsa-kernel.
> 
> I appear to have the "SB0312" model of the Audigy LS. Thus, the rest of 
> this mail is the output of lspci, first -v without -n to document the 
> model name I have, afterwards with -vn as requested on the blacklist.
> 
> Greetings,
> Tilman.
> 

MIDI is not currently supported on the ca0106.
I have no way to test it, so I did not try to add MIDI support.
The implementation should be fairly easy, as I think it uses the same or 
similar driver code as the snd-emu10k1x driver uses.


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
