From: Friedrich Ewaldt <friedrich.ewaldt@gmx.de>
Subject: Re: [ANN] ALSA 1.0 schedule
Date: Sat, 25 Oct 2003 22:22:27 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F9ADB83.20008@gmx.de>
References: <s5hpth558n8.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hpth558n8.wl@alsa2.suse.de>
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

Hi,

this is not a *very* important issue, but the problem should be solved 
quite easy:
For me, 4channel output (indep. front and rear output) works with the 
Terratec XFire (cs46xx), but for some not -- at least not without 
modifying the driver.

for the problem description see:
http://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg08393.html

the problem was solved as described here:
http://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg08500.html
Maybe the changes to alsa-kernel/pci/cs46xx/cs46xx_lib.c described there 
are already the correct solution.

fe

Takashi Iwai wrote:
> Hi,
> 
> as many of you might expect, we're reaching to the ALSA version 1.0.
> Now as the 2.6.0-test kernel is being frozen, we also decided to
> freeze the ALSA 1.0 feature.  The 1.0 release is scheduled at the end
> of October.
> 
> You can find some TODOs for 1.0 and 1.1 in the cvs repository
> (TODO-1.0, and TODO-1.1).
> 
> If you have *important* bugs not listed there, please let us know.
> We'll try to fix before 1.0 release.
> Also, if you have pending patches, please submit them ASAP.
> 



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
