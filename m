From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: Resent: [RFC] More power-saving for HD-audio	driver
Date: Fri, 22 Sep 2006 16:09:23 +0100
Message-ID: <1158937763.18071.62.camel@localhost.localdomain>
References: <s5h3bak9o48.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h3bak9o48.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 2006-09-22 at 12:44 +0200, Takashi Iwai wrote:
> 
> the patch below is an experimental patch to achieve more aggressive
> power-saving on HD-audio.  With the patch, the device is disabled
> after a certain timeout when no apps are using the PCM and no loopback
> channels are being used.  (According to Pavel Machek, sound chips
> consume significant powers.)
> 
> For some reasons, the patch is a bit intrusive and touches many
> places.  But the change is pretty straightforward: add power-up/down
> calls in appropriate place (e.g. mixer changes, PCM open/close).
> 
> For the power-up/down control, a damn simple way is chosen in this
> version.  The driver does basically a same job like suspend/resume.
> We can tune up this later if the perfomance matters.
> 
> The default timeout value is 30 seconds.  This is adjustable via
> power_save module option of snd-hda-intel driver.  You can change this
> value dynamically via writing to
> /sys/modules/snd_hda_intel/parameters/power_save.  The value changed
> isn't propagated immediately, and you have to do something (like
> change a mixer value or open/close PCM) to activate the new value,
> though.

I'd be interested to know if there are any pops or clicks associated
with the HD-audio power up/down events (I don't have an HD PC or laptop
to test). Pops and clicks are an unwanted side effect of audio power
management atm and occur when the audio subsystems analog circuits are
power switched. 

If the pops are bad then it may be more desirable to disable the digital
components in the audio subsystem (e.g. PLL's, DAI, digital filters,
core) and selectively (per machine/codec) disable certain analog
components.

Liam  


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
