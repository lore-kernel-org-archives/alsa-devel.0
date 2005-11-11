From: "Kurt J. Bosch" <kjb-temp-2005@gmx.de>
Subject: Changed ens1370.c to enable Suspend ens1371
Date: Fri, 11 Nov 2005 18:58:20 +0100
Message-ID: <4374DBBC.9040100@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060703060903050702090907"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060703060903050702090907
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I changed driver ens1371 to enable suspend to disk
only using some other drivers as kind of templates.
(No special handling of any registers added.)

BTW - this is my second post. The first is holded back since Nov. 6th 
because it was too big. - I'm sorry about that, but i'm a newbe here :-)

I did some testing on Ubuntu Breezy
Linux version 2.6.12-9-686 (buildd@rothera) (gcc version 3.4.5 20050809
(prerelease) (Ubuntu 3.4.4-6ubuntu8)) #1 Mon Oct 10 13:25:32 BST 2005
alsa 1.0.9b
and it seems to work fine for me.

I am using swsusp not swsusp2
but with script hibernate 1.07
and removed snd-ens1371 from /etc/hibernate/blacklisted-modules
thus it is not longer unloaded.

To avoid problems with dmix I changed /etc/hibernate/hibernate.conf :
--8<--
### misclaunch
# OnSuspend 20 echo "Good night!"
# OnResume 20 echo "Good morning!"
#
# kjb - workaround for
# ALSA Bug  0001249: dmix doesn't survive suspend to RAM
# this restores the socket /tmp/alsa-dmix-... (!)
OnSuspend 20 sudo -H -u kurt /usr/bin/esdctl standby
OnResume 20 sudo -H -u kurt /usr/bin/esdctl resume
--8<--
(I use gnome, so esd is running all the time.)


patch for ens1370.c CVS revision 1.90

is appended

Any comments ?



--------------060703060903050702090907
Content-Type: text/x-patch;
 name="patch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.diff"

21a22,28
> /* Power-Management-Code ( CONFIG_PM )
>  * for ens1371 only ( FIXME )
>  * derived from cs4281.c, atiixp.c and via82xx.c
>  * using http://www.alsa-project.org/~iwai/writing-an-alsa-driver/c1540.htm
>  * by Kurt J. Bosch ( kjb )
>  */
> 
786a794
> 	case SNDRV_PCM_TRIGGER_RESUME:  // kjb
787a796
> 	case SNDRV_PCM_TRIGGER_SUSPEND: // kjb
806c815,817
< 		if (cmd == SNDRV_PCM_TRIGGER_START)
---
> 		if (cmd == SNDRV_PCM_TRIGGER_START
> 		 || cmd == SNDRV_PCM_TRIGGER_RESUME // kjb
> 		   )
1014c1025,1027
< 				 SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_SYNC_START),
---
> 				 SNDRV_PCM_INFO_PAUSE |
> 				 SNDRV_PCM_INFO_RESUME | // kjb
> 				 SNDRV_PCM_INFO_SYNC_START),
1040c1053,1055
< 				 SNDRV_PCM_INFO_MMAP_VALID | SNDRV_PCM_INFO_PAUSE | 
---
> 				 SNDRV_PCM_INFO_MMAP_VALID | 
> 				 SNDRV_PCM_INFO_PAUSE |
> 				 SNDRV_PCM_INFO_RESUME | // kjb
1060c1075,1077
< 				 SNDRV_PCM_INFO_MMAP_VALID | SNDRV_PCM_INFO_SYNC_START),
---
> 				 SNDRV_PCM_INFO_MMAP_VALID | 
>  				 SNDRV_PCM_INFO_RESUME | // kjb
> 				 SNDRV_PCM_INFO_SYNC_START),
1926a1944,2056
> /* initialize the chips */
> // kjb - this code was part of snd_ensoniq_create
> static void snd_ensoniq_chip_init(ensoniq_t * ensoniq)
> {
> #ifdef CHIP1371
> 	int idx;
> 	struct pci_dev *pci = ensoniq->pci;
> #endif
> #ifdef CHIP1370
> 	outl(ensoniq->ctrl, ES_REG(ensoniq, CONTROL));
> 	outl(ensoniq->sctrl, ES_REG(ensoniq, SERIAL));
> 	outl(ES_MEM_PAGEO(ES_PAGE_ADC), ES_REG(ensoniq, MEM_PAGE));
> 	outl(ensoniq->dma_bug.addr, ES_REG(ensoniq, PHANTOM_FRAME));
> 	outl(0, ES_REG(ensoniq, PHANTOM_COUNT));
> #else
> 	outl(ensoniq->ctrl, ES_REG(ensoniq, CONTROL));
> 	outl(ensoniq->sctrl, ES_REG(ensoniq, SERIAL));
> 	outl(0, ES_REG(ensoniq, 1371_LEGACY));
> 	for (idx = 0; es1371_ac97_reset_hack[idx].vid != (unsigned short)PCI_ANY_ID; idx++)
> 		if (pci->vendor == es1371_ac97_reset_hack[idx].vid &&
> 		    pci->device == es1371_ac97_reset_hack[idx].did &&
> 		    ensoniq->rev == es1371_ac97_reset_hack[idx].rev) {
> 			ensoniq->cssr |= ES_1371_ST_AC97_RST;
> 			outl(ensoniq->cssr, ES_REG(ensoniq, STATUS));
> 			/* need to delay around 20ms(bleech) to give
> 			some CODECs enough time to wakeup */
> 			msleep(20);
> 			break;
> 		}
> 	/* AC'97 warm reset to start the bitclk */
> 	outl(ensoniq->ctrl | ES_1371_SYNC_RES, ES_REG(ensoniq, CONTROL));
> 	inl(ES_REG(ensoniq, CONTROL));
> 	udelay(20);
> 	outl(ensoniq->ctrl, ES_REG(ensoniq, CONTROL));
> 	/* Init the sample rate converter */
> 	snd_es1371_wait_src_ready(ensoniq);	
> 	outl(ES_1371_SRC_DISABLE, ES_REG(ensoniq, 1371_SMPRATE));
> 	for (idx = 0; idx < 0x80; idx++)
> 		snd_es1371_src_write(ensoniq, idx, 0);
> 	snd_es1371_src_write(ensoniq, ES_SMPREG_DAC1 + ES_SMPREG_TRUNC_N, 16 << 4);
> 	snd_es1371_src_write(ensoniq, ES_SMPREG_DAC1 + ES_SMPREG_INT_REGS, 16 << 10);
> 	snd_es1371_src_write(ensoniq, ES_SMPREG_DAC2 + ES_SMPREG_TRUNC_N, 16 << 4);
> 	snd_es1371_src_write(ensoniq, ES_SMPREG_DAC2 + ES_SMPREG_INT_REGS, 16 << 10);
> 	snd_es1371_src_write(ensoniq, ES_SMPREG_VOL_ADC, 1 << 12);
> 	snd_es1371_src_write(ensoniq, ES_SMPREG_VOL_ADC + 1, 1 << 12);
> 	snd_es1371_src_write(ensoniq, ES_SMPREG_VOL_DAC1, 1 << 12);
> 	snd_es1371_src_write(ensoniq, ES_SMPREG_VOL_DAC1 + 1, 1 << 12);
> 	snd_es1371_src_write(ensoniq, ES_SMPREG_VOL_DAC2, 1 << 12);
> 	snd_es1371_src_write(ensoniq, ES_SMPREG_VOL_DAC2 + 1, 1 << 12);
> 	snd_es1371_adc_rate(ensoniq, 22050);
> 	snd_es1371_dac1_rate(ensoniq, 22050);
> 	snd_es1371_dac2_rate(ensoniq, 22050);
> 	/* WARNING:
> 	 * enabling the sample rate converter without properly programming
> 	 * its parameters causes the chip to lock up (the SRC busy bit will
> 	 * be stuck high, and I've found no way to rectify this other than
> 	 * power cycle) - Thomas Sailer
> 	 */
> 	snd_es1371_wait_src_ready(ensoniq);
> 	outl(0, ES_REG(ensoniq, 1371_SMPRATE));
> 	/* try reset codec directly */
> 	outl(ES_1371_CODEC_WRITE(0, 0), ES_REG(ensoniq, 1371_CODEC));
> #endif
> 	outb(ensoniq->uartc = 0x00, ES_REG(ensoniq, UART_CONTROL));
> 	outb(0x00, ES_REG(ensoniq, UART_RES));
> 	outl(ensoniq->cssr, ES_REG(ensoniq, STATUS));
> 	synchronize_irq(ensoniq->irq);
> }
> 
> #ifdef CONFIG_PM
> static int snd_ensoniq_suspend (snd_card_t * card,
>                                 pm_message_t state)
> {
> 	ensoniq_t *ensoniq = card->pm_private_data;
> 	
> 	snd_pcm_suspend_all(ensoniq->pcm1);
> 	snd_pcm_suspend_all(ensoniq->pcm2);
> 	
> #ifdef CHIP1371	
> 	if (ensoniq->u.es1371.ac97)
> 		snd_ac97_suspend(ensoniq->u.es1371.ac97);
> #else
> 	/* FIXME */
> #endif	
>         pci_set_power_state(ensoniq->pci, 3);
> 	pci_disable_device(ensoniq->pci);
>         // snd_power_change_state(card, SNDRV_CTL_POWER_D3hot); // only 2.6.10
> 	return 0;
> }
> 
> static int snd_ensoniq_resume (snd_card_t * card
>                               )
> {
> 	ensoniq_t *ensoniq = card->pm_private_data;
> 
> 	pci_enable_device(ensoniq->pci);
>         pci_set_power_state(ensoniq->pci, 0);	
> 	pci_set_master(ensoniq->pci);
> 
> 	snd_ensoniq_chip_init(ensoniq);
>     
> #ifdef CHIP1371	
> 	if (ensoniq->u.es1371.ac97)
> 		snd_ac97_resume(ensoniq->u.es1371.ac97);
> #else
> 	/* FIXME */
> #endif	
> 	// snd_power_change_state(card, SNDRV_CTL_POWER_D0); // only 2.6.10
> 	return 0;
> }
> #endif /* CONFIG_PM */
> 
> 
1989,1994d2118
< 	/* initialize the chips */
< 	outl(ensoniq->ctrl, ES_REG(ensoniq, CONTROL));
< 	outl(ensoniq->sctrl, ES_REG(ensoniq, SERIAL));
< 	outl(ES_MEM_PAGEO(ES_PAGE_ADC), ES_REG(ensoniq, MEM_PAGE));
< 	outl(ensoniq->dma_bug.addr, ES_REG(ensoniq, PHANTOM_FRAME));
< 	outl(0, ES_REG(ensoniq, PHANTOM_COUNT));
2005,2052d2128
< 	/* initialize the chips */
< 	outl(ensoniq->ctrl, ES_REG(ensoniq, CONTROL));
< 	outl(ensoniq->sctrl, ES_REG(ensoniq, SERIAL));
< 	outl(0, ES_REG(ensoniq, 1371_LEGACY));
< 	for (idx = 0; es1371_ac97_reset_hack[idx].vid != (unsigned short)PCI_ANY_ID; idx++)
< 		if (pci->vendor == es1371_ac97_reset_hack[idx].vid &&
< 		    pci->device == es1371_ac97_reset_hack[idx].did &&
< 		    ensoniq->rev == es1371_ac97_reset_hack[idx].rev) {
< 			ensoniq->cssr |= ES_1371_ST_AC97_RST;
< 			outl(ensoniq->cssr, ES_REG(ensoniq, STATUS));
< 			/* need to delay around 20ms(bleech) to give
< 			some CODECs enough time to wakeup */
< 			msleep(20);
< 			break;
< 		}
< 	/* AC'97 warm reset to start the bitclk */
< 	outl(ensoniq->ctrl | ES_1371_SYNC_RES, ES_REG(ensoniq, CONTROL));
< 	inl(ES_REG(ensoniq, CONTROL));
< 	udelay(20);
< 	outl(ensoniq->ctrl, ES_REG(ensoniq, CONTROL));
< 	/* Init the sample rate converter */
< 	snd_es1371_wait_src_ready(ensoniq);	
< 	outl(ES_1371_SRC_DISABLE, ES_REG(ensoniq, 1371_SMPRATE));
< 	for (idx = 0; idx < 0x80; idx++)
< 		snd_es1371_src_write(ensoniq, idx, 0);
< 	snd_es1371_src_write(ensoniq, ES_SMPREG_DAC1 + ES_SMPREG_TRUNC_N, 16 << 4);
< 	snd_es1371_src_write(ensoniq, ES_SMPREG_DAC1 + ES_SMPREG_INT_REGS, 16 << 10);
< 	snd_es1371_src_write(ensoniq, ES_SMPREG_DAC2 + ES_SMPREG_TRUNC_N, 16 << 4);
< 	snd_es1371_src_write(ensoniq, ES_SMPREG_DAC2 + ES_SMPREG_INT_REGS, 16 << 10);
< 	snd_es1371_src_write(ensoniq, ES_SMPREG_VOL_ADC, 1 << 12);
< 	snd_es1371_src_write(ensoniq, ES_SMPREG_VOL_ADC + 1, 1 << 12);
< 	snd_es1371_src_write(ensoniq, ES_SMPREG_VOL_DAC1, 1 << 12);
< 	snd_es1371_src_write(ensoniq, ES_SMPREG_VOL_DAC1 + 1, 1 << 12);
< 	snd_es1371_src_write(ensoniq, ES_SMPREG_VOL_DAC2, 1 << 12);
< 	snd_es1371_src_write(ensoniq, ES_SMPREG_VOL_DAC2 + 1, 1 << 12);
< 	snd_es1371_adc_rate(ensoniq, 22050);
< 	snd_es1371_dac1_rate(ensoniq, 22050);
< 	snd_es1371_dac2_rate(ensoniq, 22050);
< 	/* WARNING:
< 	 * enabling the sample rate converter without properly programming
< 	 * its parameters causes the chip to lock up (the SRC busy bit will
< 	 * be stuck high, and I've found no way to rectify this other than
< 	 * power cycle) - Thomas Sailer
< 	 */
< 	snd_es1371_wait_src_ready(ensoniq);
< 	outl(0, ES_REG(ensoniq, 1371_SMPRATE));
< 	/* try reset codec directly */
< 	outl(ES_1371_CODEC_WRITE(0, 0), ES_REG(ensoniq, 1371_CODEC));
2054,2057c2130,2131
< 	outb(ensoniq->uartc = 0x00, ES_REG(ensoniq, UART_CONTROL));
< 	outb(0x00, ES_REG(ensoniq, UART_RES));
< 	outl(ensoniq->cssr, ES_REG(ensoniq, STATUS));
< 	synchronize_irq(ensoniq->irq);
---
> 
> 	snd_ensoniq_chip_init(ensoniq); // kjb
2065a2140,2143
> #ifdef CHIP1371 /* FIXME */
> 	snd_card_set_pm_callback(card, snd_ensoniq_suspend, snd_ensoniq_resume, ensoniq); // kjb
> #endif
> 
2392a2471
> 	SND_PCI_PM_CALLBACKS // kjb

--------------060703060903050702090907--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
