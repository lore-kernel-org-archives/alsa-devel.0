From: Jiang zhe <zhe.jiang@intel.com>
Subject: Re: Problem with DELL XPS M1530
Date: Thu, 21 Feb 2008 10:58:48 +0800
Message-ID: <1203562728.27014.12.camel@localhost.localdomain>
References: <mailman.1.1203505202.15472.alsa-devel@alsa-project.org>
	<194b8d500802200430j2be27899vf5ae8a2ddaca7389@mail.gmail.com>
	<s5hablvsque.wl%tiwai@suse.de> <47BC43E3.5010501@gmail.com>
	<s5h4pc3pqq7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id A47301037F9
	for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2008 03:58:34 +0100 (CET)
In-Reply-To: <s5h4pc3pqq7.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Anders =?ISO-8859-1?Q?R=F8nningen?= <andersronningen@gmail.com>, anders.ronningen@gmail.com
List-Id: alsa-devel@alsa-project.org


> >
> > http://pastebin.ca/911147
> >
> > Now the odd thing is that after the last compile of alsa-driver
> 1.0.16
> > ... stuff works! Both HP jacks, the internal speakers and the mic
> work
> > just fine. I don't really know what to make of it, since all I have
> done
> > is compile like I did earlier and reboot...
> 
> Thanks.  It's not that odd.  As I mentioned, the fix after 1.0.16
> might break the dual headphone configuration of Dell laptops.
> 
> Need to investigate a bit further...
> 
Hi,

The reason should be the following code of hda_codec.c :
	/* FIX-UP:
	 * If no line-out is defined but multiple HPs are found,
	 * some of them might be the real line-outs.
	 */
	if (!cfg->line_outs && cfg->hp_outs > 1) {
		int i = 0;
		while (i < cfg->hp_outs) {
			/* The real HPs should have the sequence 0x0f */
			if ((sequences_hp[i] & 0x0f) == 0x0f) {
				i++;
				continue;
			}
			/* Move it to the line-out table */
			cfg->line_out_pins[cfg->line_outs] = cfg->hp_pins[i];
			sequences_line_out[cfg->line_outs] = sequences_hp[i];
			cfg->line_outs++;
			cfg->hp_outs--;
			memmove(cfg->hp_pins + i, cfg->hp_pins + i + 1,
				sizeof(cfg->hp_pins[0]) * (cfg->hp_outs - i));
			memmove(sequences_hp + i - 1, sequences_hp + i,
				sizeof(sequences_hp[0]) * (cfg->hp_outs - i));
		}
	}


For dell machine which has two HP jacks, it will do some special process
in stac***_parse_auto_config().Please refer to the code of
patch_sigmatel.c, search the "hp_speaker_swap".
But the code in the hda_codec.c break the logic. So it failed.

Anders:
May you try latest alsa-driver and get rid of the above code from
snd_hda_parse_pin_def_config() in hda_codec.c?
I think that it will work.


Thanks!
> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
> 
