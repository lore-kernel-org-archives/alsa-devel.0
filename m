From: "guan yim" <guanyim@hotmail.com>
Subject: Re: Need to know SBLive Chip difference
Date: Wed, 31 Mar 2004 10:16:46 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Sea2-F60EGuaYve5T7H000030d7@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: pzad@pobox.sk
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org




>From: p z oooo <pzad@pobox.sk>
>Reply-To: p z oooo <pzad@pobox.sk>
>To: guanyim@hotmail.com
>Subject: Re: [Alsa-devel] Need to know SBLive Chip difference
>Date: Tue, 30 Mar 2004 14:09:20 +0200

>Could you try change these lines in alsa-driver/alsa-
>kernel/emu10k1/emufx.c
>
>if (emu->fx8010.extout_mask & ((1<<EXTOUT_REAR_L)|1<<EXTOUT_REAR_R)))
>   for (z = 0; z < 2; z++)
>     OP(icode, &ptr, iACC3, EXTOUT(EXTOUT_REAR_L + z), GPR(playback +
>SND_EMU10K1_PLAYBACK_CHANNELS + 2 + z), C_00000000, C_00000000);
>
>to:
>
>if (emu->fx8010.extout_mask & ((1<<EXTOUT_REAR_L)|1<<EXTOUT_REAR_R)))
>   for (z = 0; z < 2; z++) {
>     OP(icode, &ptr, iACC3, EXTOUT(EXTOUT_REAR_L + z), GPR(playback +
>SND_EMU10K1_PLAYBACK_CHANNELS + 2 + z), C_00000000, C_00000000);
>     OP(icode, &ptr, iACC3, EXTOUT(0xd + z), GPR(playback +
>SND_EMU10K1_PLAYBACK_CHANNELS + 2 + z), C_00000000, C_00000000);
>     OP(icode, &ptr, iACC3, EXTOUT(0xf + z), GPR(playback +
>SND_EMU10K1_PLAYBACK_CHANNELS + 2 + z), C_00000000, C_00000000);
>   }
>


Yes I tried this with 1.0.4rc1 and also commented out the control names in 
emumixer.c but still could get the rear analog output.

_________________________________________________________________
MSN 8 with e-mail virus protection service: 2 months FREE* 
http://join.msn.com/?page=features/virus



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
