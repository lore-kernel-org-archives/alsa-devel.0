From: Mark Knecht <markknecht@comcast.net>
Subject: Re: rc2 - snd-via82xx - really sounds bad -
	distorted, resampled, phasey
Date: Sun, 07 Dec 2003 20:55:01 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1070859301.10628.0.camel@Wizard.knechthome.com>
References: <1070820195.3841.42.camel@Wizard.knechthome.com>
	 <3FD3716A.9010009@boosthardware.com>
	 <1070833482.2913.82.camel@Wizard.knechthome.com>
	 <20031208045305.GA11419@dogsolitude.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20031208045305.GA11419@dogsolitude.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: drclaw@dogsolitude.org
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 2003-12-07 at 20:53, drclaw@dogsolitude.org wrote:
> Hi, I have that exact same problem with a via8235 chip, and the only way
> I have found to fix it was to change 48000 to 44100 on Line 83 in
> alsa-kernel/pci/via82xx.c:
> static int ac97_clock[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 48000};
> I actuially wrote a mail earlier today on the same subject (called
> viasomehting8235 clock problems or something).  It seems to work fine
> after I make this change, btw.  
> 
> 784 - Michael C. Piantedosi - drclaw@dogsolitude.org

Interesting info. Thanks.

- Mark



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
