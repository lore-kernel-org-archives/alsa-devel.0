From: Gerard Janssen <G.Janssen@ITS.TUDelft.NL>
Subject: Re: How to route "spdif" to an FXBUS of emu10k1
Date: Thu, 09 Jan 2003 09:24:36 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <73972737454@Octopus.et.tudelft.nl>
References: <724D1102774@Octopus.et.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailhst2.its.tudelft.nl (mailhst2.its.tudelft.nl [130.161.34.250])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id JAA29857
	for <alsa-devel@alsa-project.org>; Thu, 9 Jan 2003 09:21:49 +0100
In-Reply-To: <Pine.LNX.4.33.0301081618500.2215-100000@pnote.perex-int.cz
 >
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Jaroslav,

Many thanks for your reply. This realy solved my problem.

I have been able to implement a new PCM-stream and send it to empty FXBUS
registers. However, I could not find .asoundcr (I am using SUSE 8.1 with
ALSA_rc6). Where is it? In stead, I adapted alsa.conf, emu10k1.conf and
added a pcm_new.conf in /usr/share/alsa/ and this worked. 

After having done this, I am stuck with some questions. Why are there no
"Send Routing" lines in the "front" and "rear" config files, since they are
routed to FXBUS? 
Why do the lines:
>        /* 22: */ OP(icode, &ptr, iMACINT1, ETRAM_ADDR(ipcm->etram[0]),
GPR(gpr + 8), GPR_DBAC, C_ffffffff);
>        /* 23: */ OP(icode, &ptr, iMACINT1, ETRAM_ADDR(ipcm->etram[1]),
GPR(gpr + 9), GPR_DBAC, C_ffffffff);
have to be removed?

With kind regards,

Gerard Janssen

At 04:30 PM 1/8/03 +0100, Jaroslav Kysela wrote:
>On Wed, 8 Jan 2003, Gerard Janssen wrote:
>
>> Hi,
>> 
>> By making slight changes in emufx.c, I could use all four spdif stereo
>> channels of the sblive! that are present on the audio-ext connector. These
>> spdif0..3 outputs can be accessed via: EXTOUT_TOSLINK_L,R ;
>> EXTOUT_HEADPHONE_L,R ; EXTOUT_REAR_L,R and EXTOUT_CENTER,LFE. By re-routing
>> "spdif", "front", "rear" and "center_lfe" to the respective outputs, four
>> stereo signals (8 channels) can be simultaneously send to these outputs. 
>> 
>> The "front", "rear" and "center_lfe" signals are alsmost perfectly
>> synchronized (within a few samples) and the small delays are constant.
>> However, the signal via "spdif" is not: its delay w.r.t. the other signals
>> is about 60 samples and changes randomly every time the application is
>> started. 
>> The "spdif" signal is taken from GPR(8) and GPR(9) in emufx.c. As far as I
>> could backtrace these signals come from etram, which probably is the cause
>> of the random delay.
>> 
>> A solution might be to put the "spdif" also directly in two FXBUS registers
>> (there are still 6 free FXBUS registers), as is done with the other
>> signals. However, I don't know how to do this.
>> 
>> I would appreciate any help or suggestions in routing "spdif" to an FXBUS.
>
>These steps are necessary:
>
>1) remove the emufx PCM code (or the last two lines):
>
>        /* 22: */ OP(icode, &ptr, iMACINT1, ETRAM_ADDR(ipcm->etram[0]),
GPR(gpr + 8), GPR_DBAC, C_ffffffff);
>        /* 23: */ OP(icode, &ptr, iMACINT1, ETRAM_ADDR(ipcm->etram[1]),
GPR(gpr + 9), GPR_DBAC, C_ffffffff);
>
>   you can do it without modification of driver code itself (see 
>   SNDRV_EMU10K1_IOCTL_CODE_POKE and SNDRV_EMU10K1_IOCTL_CODE_PEEK ioctls)
>
>2) replace these two lines in emufx:
>
>        OP(icode, &ptr, iMACINT0, GPR(6), C_00000000,
FXBUS(FXBUS_PCM_CENTER), C_00000004);
>        OP(icode, &ptr, iMACINT0, GPR(7), C_00000000,
FXBUS(FXBUS_PCM_LFE), C_00000004);
>
>to
>
>        OP(icode, &ptr, iMACINT0, GPR(6), C_00000000, FXBUS(8), C_00000004);
>        OP(icode, &ptr, iMACINT0, GPR(7), C_00000000, FXBUS(9), C_00000004);
>
>3) create a new "chn67" pcm in your .asoundrc:
>
>pcm.chn67 {
>        @args [ CARD ]
>        @args.CARD {
>                type string
>        }
>        type hooks
>        slave.pcm {
>                type hw
>                card $CARD
>                device 0
>        }
>        hooks.0 {
>                type ctl_elems
>                hook_args [
>                        {
>                                name "EMU10K1 PCM Send Volume"
>                                index { @func private_pcm_subdevice }
>                                lock true
>                                value [ 0 0 0 0 255 0 0 0 0 255 0 0 ]
>                        }
>                        {
>                                name "EMU10K1 PCM Send Routing"
>                                index { @func private_pcm_subdevice }
>                                lock true
>                                value [ 0 1 2 3 8 9 0 1 8 9 0 1 ]
>                        }
>	}
>}
>
>Note: Send Routing is fxbus setup
>
>						Jaroslav
>
>-----
>Jaroslav Kysela <perex@suse.cz>
>Linux Kernel Sound Maintainer
>ALSA Project, SuSE Labs
>
>
>
>-------------------------------------------------------
>This SF.NET email is sponsored by:
>SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
>http://www.vasoftware.com
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 
********************************************************************** 
Dr.ir. Gerard J.M. Janssen
Delft University of Technology 
Faculty of Information Technology and Systems (ITS) 
Wireless Mobile Communications Group
P.O. Box 5031, 2600 GA Delft, The Netherlands 
Phone +31-15-2786736, Fax +31-15-2781774 
E-mail G.Janssen@ITS.TUDelft.NL 
**********************************************************************




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
