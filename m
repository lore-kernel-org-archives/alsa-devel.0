From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001389]: snd-ens1371 / es1938 Creative
	Ectiva silent playout + new line-in capture failure
Date: Tue, 13 Jun 2006 07:05:09 +0200
Message-ID: <ac1a3835911bc5375542f1459fb7d2ab@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 961A0142
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Jun 2006 07:05:09 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1389> 
======================================================================
Reported By:                wood
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1389
Category:                   PCI - ens1371
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               Modified Redhat 9.0
Kernel Version:             2.4.24 self compiled
======================================================================
Date Submitted:             09-01-2005 20:32 CEST
Last Modified:              06-13-2006 07:05 CEST
======================================================================
Summary:                    snd-ens1371 / es1938 Creative Ectiva silent playout
+ new line-in capture failure
Description: 
Soundcard: Creative Soundblaster PCI (Ectiva) Model:CT4730
Chip Label: Creative EV1938

Platform: Stable 2.4.24 Linux kernel on VIA MiniITX ME6000/M10000
          w/ multiple soundcards. ALSA compiled from source
          works with VIA motherboard Audio
          and some other Creative PCI soundcards. Need a stable ALSA
driver
          for this soundcard.

Problem:
The snd-ens1371 module loads correctly as 3rd sound device (First audio
device is VIA 8235 from motherboard, 2nd is PCSP).

Alsamixer -c 2 shows a reasonable set of
controls. Playout either with OSS emulation (play) or ALSA player
(aplay) plays WAV files but only silence for both 1.0.9 and 1.0.10rc1
releases.  
On ALSA 1.0.9 codebase,the Master Volume does not always show in
alsamixer. 
In 1.0.10rc1 it does always show.
ALSO:
  On ALSA 1.0.9 code, the Line-In capture works under both OSS Emulation
and with ALSA arecord.
On the latest development release ALSA 1.0.10rc1, the Line-In
capture no longer works. So a new problem has been introduced from .9 to
.10.


Other info:
Native OSS driver es1371 works fine with this card. But I want to switch
to ALSA.

Earlier model Creative PCI128, Model CT4750 loads snd-ens1371 and
works fine with both tested ALSA releases using same platform
configuration.

Audigy 2 Value also works fine using snd-emu10k1 with same configuration
(I included this card info to rule out basic config problems).

======================================================================

----------------------------------------------------------------------
 wood - 06-13-06 06:43 
----------------------------------------------------------------------
IMPORTANT:

 I got this card to work perfectly in March under 1.0.11rc3
by adding some detection code in ac97_codec.c for this 
cards device ID. For this specific card
I bypass tests that were added in 1.0.8rc2 from 1.0.8rc1.
I confirmed that this card worked in 1.0.8rc1 but failed in 1.0.8rc2.
The snd_ac97_try_bit() test was added in snd_ac97_cmix_new() as
a condition before calling snd_ac97_cmute_new_stereo() with the control
named "Switch". There were also some other cases where detection for this
card
failed and thus controls were never added.

I have not tested 1.0.11 but from cursory glance I doubt the problem has
been fixed.  Here are the two changed functions I made in
file ../pci/ac97/ac97_codec.c: 

------------------------------------------
static int snd_ac97_cmix_new_stereo(struct snd_card *card, const char
*pfx, int reg, int check_stereo, struct snd_ac97 *ac97)
{
        int err;
        char name[44];
        unsigned char lo_max, hi_max;

        snd_printk(KERN_DEBUG "snd_ac97_cmix_new %s : Enter\n",pfx);
        if (! snd_ac97_valid_reg(ac97, reg))
        {
                //snd_printk(KERN_DEBUG "snd_ac97_cmix_new %s : Invalid
reg 0x%x\n",pfx,reg);
                return 0;
        }
 /*******ADDED THIS CODE *************/
        int special_card = (((ac97->id == 0x76058384) ||
                             (ac97->id == 0x8a058384)) &&
                            (strstr(pfx,"Playback")));
 /********************/
        if (snd_ac97_try_bit(ac97, reg, 15)
 /*******ADDED THIS CODE *************/
           || special_card)
  /********************/
       {
                sprintf(name, "%s Switch", pfx);
                if ((err = snd_ac97_cmute_new_stereo(card, name, reg,
check_stereo, ac97)) < 0)
                        return err;
        }
        check_volume_resolution(ac97, reg, &lo_max, &hi_max);
        if (lo_max) {
                sprintf(name, "%s Volume", pfx);
                if (special_card && (lo_max > 31))
                {
                    lo_max = 31; if (hi_max) hi_max = 31;
                }

                if ((err = snd_ac97_cvol_new(card, name, reg, lo_max,
hi_max, ac97)) < 0)
                        return err;
        }
        else snd_printk(KERN_DEBUG "snd_ac97_cmix_new : %s Volume control
omitted, no lo_max val after check_volume_resolution call,
lo=%d,hi=%d\n",pfx,lo_max,hi_max);
        snd_printk(KERN_DEBUG "snd_ac97_cmix_new %s : Done\n",pfx);
        return 0;
}

and in function:
 snd_ac97_mixer_build():

static int snd_ac97_mixer_build(struct snd_ac97 * ac97)
{
        struct snd_card *card = ac97->bus->card;
        struct snd_kcontrol *kctl;
        int err;
        unsigned int idx;
        unsigned char max;

        snd_printk(KERN_DEBUG "snd_ac97_mixer_build : Enter
ID=0x%x\n",ac97->id);
/*******ADDED THIS CODE *************/
        int special_card = (((ac97->id == 0x76058384) ||
                             (ac97->id == 0x8a058384)));
/********************/
then, code the same ..... until:

/* build MIC Capture controls */
        if (!special_card && s
             snd_ac97_try_volume_mix(ac97, AC97_REC_GAIN_MIC)) {
                  
                for (idx = 0; idx < 2; idx++)
                {
                    if ((err = snd_ctl_add(card,
snd_ac97_cnew(&snd_ac97_controls_mic_capture[idx], ac97))) < 0)
                                return err;
                    //snd_printk(KERN_DEBUG "snd_ac97_mixer_build : build
MIC Capture [%d]\n",idx);
                }
                snd_ac97_write_cache(ac97, AC97_REC_GAIN_MIC, 0x0000);
        }
...
...
...

My fix is a hack, relying on special handling of a specific device. 
But it works, so someone who knows more about these arcane device
differences stands a better chance of making this work correctly.

I can send the original file and the changed one outside of this
forum to anybody who sends me an email.

Raymond, here are the requested posts, but I do not 
think they shed light:
With unmodified 1.0.9 =, sound card not working:
# >  cat /proc/asound/card2/codec97#0/ac97#0-0
0-0/0: 0x8a057605 ?&#65533;F

Capabilities     : -dedicated MIC PCM IN channel- -bass & treble-
DAC resolution   : 16-bit
ADC resolution   : 20-bit
3D enhancement   : Reserved 29

Current setup
Mic gain         : +20dB [+20dB]
POP path         : post 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : Mic
Mic select       : Mic2
ADC/DAC loopback : on
---------------------------------------

 With modified 1.0.11rc3 that works with this card:
# > cat /proc/asound/card2/codec97#0/ac97#0-0
0-0/0: 0x76058384 F&#65533;S

PCI Subsys Vendor: 0x0000
PCI Subsys Device: 0x0000

Capabilities     : -dedicated MIC PCM IN channel- -bass & treble-
DAC resolution   : 16-bit
ADC resolution   : 20-bit
3D enhancement   : Reserved 29

Current setup
Mic gain         : +0dB [+20dB]
POP path         : post 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off

----------------------------------------------------------------------
 Raymond - 06-13-06 07:05 
----------------------------------------------------------------------
Refer to https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2132, it seem
that snd_es1371_codec_read() only work on first
read and subsequent read return incorrect value.

Please post the output of

cat /proc/asound/card2/codec97#0/ac97#0-0+regs

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-01-05 20:32 wood           New Issue                                    
09-01-05 20:32 wood           Distribution              => Modified Redhat 9.0
09-01-05 20:32 wood           Kernel Version            => 2.4.24 self compiled
06-13-06 05:06 Raymond        Note Added: 0010186                          
06-13-06 06:43 wood           Note Added: 0010188                          
06-13-06 07:05 Raymond        Note Added: 0010189                          
======================================================================
