From: "P. Christeas" <p_christ@hol.gr>
Subject: Re: Reproducible deadlock w. alsa/maestro3 when sleeping (ACPI,) 2.6.0-test1
Date: Wed, 16 Jul 2003 17:18:50 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200307161718.50464.p_christ@hol.gr>
References: <200307141917.22813.p_christ@hol.gr> <s5h7k6i1yoa.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7k6i1yoa.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Mon, 14 Jul 2003 19:17:22 +0300,
>
> P. Christeas <p_christ@hol.gr> wrote:
> > I have been experiencing some fully reproducible deadlock when waking
> > from sleep, using artsd over ALSA.
> > The scenario is:
> > I use ALSA, with the maestro3 device and everything else compiled as
> > modules. From userspace, I launch artsd, which uses its native ALSA
> > support to connect to /dev/pcmXXXXX .
> > I only have a custom script, which sleeps the machine by a 'echo 1>
> > /proc/acpi/sleep' . It does NOT stop alsa .
>
> could you check whether m3_suspend() and m3_resume() in
> sound/pci/maestro3.c are really called?
>
>
> Takashi

OK, I did that.  I put two messages in both functions of the maestro3 driver. 
I suspended/resumed the machine. Both functions had been called.

This time, I did NOT have 'artsd' (i.e. the client) loaded. What happened was 
that the module was properly restored and I could load (and use) artsd even 
after the resume.
That brings me to the first assumption/question I have made: is there 
something wrong if we suspend two parts (one module and a userspace process), 
while they inter-communicate through the /dev/* interface?



static void m3_suspend(m3_t *chip)
{
	snd_card_t *card = chip->card;
	int i, index;

	snd_printk("m3 suspend");
	if (chip->suspend_mem == NULL)
		return;
	if (card->power_state == SNDRV_CTL_POWER_D3hot)
		return;
	...

static void m3_resume(m3_t *chip)
{
	snd_card_t *card = chip->card;
	int i, index;

	snd_printk("m3 resume");

	if (chip->suspend_mem == NULL)
		return;
	...


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
