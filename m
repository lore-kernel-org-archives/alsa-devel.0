From: "Ronny V. Vindenes" <s864@ii.uib.no>
Subject: Re: ALSA 1.0.0pre3 release
Date: Wed, 26 Nov 2003 01:11:07 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1069805467.3525.11.camel@localhost.localdomain>
References: <s5h7k1oz2v0.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7k1oz2v0.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2003-11-25 at 20:04, Takashi Iwai wrote:
> Hi,
> 
> right now the ALSA 1.0.0pre3 packages are released.
> 
> In this version, alsa-tools package was divided to two several ones,
> alsa-tools and alsa-firmware.  The latter contains only the firmware
> binary files required by loader programs in alsa-tools package.
> Please test them if you have a board requiring the loader (hdsp,
> mixart, vx, usx2y).
> 
> Especially, HDSP users, please test and report whether it works, since
> the hdsploader was modified to load the files dynamically.
> 
> 

mmap'ed sound with the cs46xx driver seems to be broken, every other
half second the sound is muted. Non-mmap'ed sound plays normally. This
is under 2.6.0-test9-mm5. The version included in test9-mm5 works as
expected (there was some patches in mm5 against ALSA, but applying those
to 1.0.0pre3 made no difference for this particular problem).

-- 
Ronny V. Vindenes <s864@ii.uib.no>



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
