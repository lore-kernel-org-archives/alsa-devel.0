From: Marek Peca <marek@tynska.cuni.cz>
Subject: Re: [Alsa-user] Re: Audigy 2 ZS Notebook -- can not hear nor record
 analog in
Date: Thu, 9 Mar 2006 21:56:17 +0000 (   )
Message-ID: <Pine.LNX.4.10.10603092151060.12936-100000@tynska.cuni.cz>
References: <Pine.LNX.4.10.10603092043480.12936-100000@tynska.cuni.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.10.10603092043480.12936-100000@tynska.cuni.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

as I see in diff for /alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c
between version 1.80 and 1.81, you added

----------------------------------------------------------
/* Enable GPIOs
 * GPIO0: Unknown
 * GPIO1: Speakers-enabled.
 * GPIO2: Unknown
 * GPIO3: Unknown
 * GPIO4: IEC958 Output on.
 * GPIO5: Unknown
 * GPIO6: Unknown
 * GPIO7: Unknown
 */
outl(0x76, emu->port + A_IOCFG); /* Windows uses 0x3f76 */
----------------------------------------------------------

does it mean, that you have reverse-engineered, that Windows drivers
outputs value 0x3f76 on this port? Do you think, that other values
can switch analog line-input (mic,...) on?

Thank you very much.
Marek P.



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
