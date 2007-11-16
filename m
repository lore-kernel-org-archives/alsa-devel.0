From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: No sound on Intel DQ965GF motherboard
Date: Fri, 16 Nov 2007 11:16:19 -0500
Message-ID: <20071116161619.GA6292@thyrsus.com>
References: <20071116061042.C5E9D830734@snark.thyrsus.com>
	<1195195147.6392.15.camel@razman.gruemaster.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from snark.thyrsus.com (static-71-162-243-5.phlapa.fios.verizon.net
	[71.162.243.5]) by alsa0.perex.cz (Postfix) with ESMTP id E0E1E24398
	for <alsa-devel@alsa-project.org>; Fri, 16 Nov 2007 17:16:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1195195147.6392.15.camel@razman.gruemaster.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tobin Davis <tdavis@dsl-only.net>
Cc: "Eric S. Raymond" <esr@snark.thyrsus.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Tobin Davis <tdavis@dsl-only.net>:
> Interesting that you would post a link to one of my responses on
> linuxquestions.org.

Ah, you must be GrueMaster, then.
 
> I still have my DP965LT, and I usually update my audio driver whenever
> there is a significant change to the tip for my specific audio codec.
> Couple of things to check.  First, is the audio disabled in bios?

No.  I checked, audio is enabled.

>                                                      Does
> audio work if you use the latest daily snapshot of alsa-driver from
> ftp://ftp.suse.com/pub/projects/alsa/snapshot/driver/ ?

No.  Installing these changes the problem; the "no codecs" message
goes away, but snd_hda_intel no longer appears in the output of lsmod.
Grepping the dmesg output yields these messages:

[   37.951029] snd_hda_intel: disagrees about version of symbol snd_ctl_add
[   37.951033] snd_hda_intel: Unknown symbol snd_ctl_add
[   37.951070] snd_hda_intel: disagrees about version of symbol snd_pcm_new
[   37.951073] snd_hda_intel: Unknown symbol snd_pcm_new
[   37.951110] snd_hda_intel: disagrees about version of symbol snd_pcm_limit_hw_rates
[   37.951113] snd_hda_intel: Unknown symbol snd_pcm_limit_hw_rates
[   37.951146] snd_hda_intel: disagrees about version of symbol snd_card_register
[   37.951148] snd_hda_intel: Unknown symbol snd_card_register
[   37.951187] snd_hda_intel: disagrees about version of symbol snd_card_free
[   37.951188] snd_hda_intel: Unknown symbol snd_card_free
[   37.951209] snd_hda_intel: disagrees about version of symbol snd_pcm_lib_preallocate_pages_for_all
[   37.951211] snd_hda_intel: Unknown symbol snd_pcm_lib_preallocate_pages_for_all
[   37.951234] snd_hda_intel: disagrees about version of symbol snd_card_proc_new
[   37.951235] snd_hda_intel: Unknown symbol snd_card_proc_new
[   37.951315] snd_hda_intel: disagrees about version of symbol snd_ctl_find_id
[   37.951317] snd_hda_intel: Unknown symbol snd_ctl_find_id
[   37.951375] snd_hda_intel: disagrees about version of symbol snd_ctl_new1
[   37.951376] snd_hda_intel: Unknown symbol snd_ctl_new1
[   37.951424] snd_hda_intel: disagrees about version of symbol snd_component_add
[   37.951426] snd_hda_intel: Unknown symbol snd_component_add
[   37.951452] snd_hda_intel: disagrees about version of symbol snd_card_new
[   37.951454] snd_hda_intel: Unknown symbol snd_card_new
[   37.951500] snd_hda_intel: disagrees about version of symbol snd_pcm_lib_malloc_pages
[   37.951502] snd_hda_intel: Unknown symbol snd_pcm_lib_malloc_pages
[   37.951530] snd_hda_intel: disagrees about version of symbol snd_pcm_lib_ioctl
[   37.951532] snd_hda_intel: Unknown symbol snd_pcm_lib_ioctl
[   37.951555] snd_hda_intel: disagrees about version of symbol snd_pcm_lib_free_pages
[   37.951557] snd_hda_intel: Unknown symbol snd_pcm_lib_free_pages
[   37.951591] snd_hda_intel: Unknown symbol snd_ctl_elem_read
[   37.951622] snd_hda_intel: Unknown symbol snd_ctl_elem_write
[   37.951641] snd_hda_intel: disagrees about version of symbol snd_pcm_set_ops
[   37.951643] snd_hda_intel: Unknown symbol snd_pcm_set_ops
[   37.951669] snd_hda_intel: disagrees about version of symbol snd_pcm_hw_constraint_list
[   37.951671] snd_hda_intel: Unknown symbol snd_pcm_hw_constraint_list
[   37.951700] snd_hda_intel: disagrees about version of symbol snd_device_new
[   37.951702] snd_hda_intel: Unknown symbol snd_device_new
[   37.951735] snd_hda_intel: disagrees about version of symbol snd_pcm_suspend_all
[   37.951736] snd_hda_intel: Unknown symbol snd_pcm_suspend_all
[   37.951767] snd_hda_intel: disagrees about version of symbol snd_card_disconnect
[   37.951769] snd_hda_intel: Unknown symbol snd_card_disconnect
[   37.951789] snd_hda_intel: disagrees about version of symbol snd_pcm_hw_constraint_integer
[   37.951791] snd_hda_intel: Unknown symbol snd_pcm_hw_constraint_integer
[   37.951897] snd_hda_intel: disagrees about version of symbol snd_pcm_period_elapsed
[   37.951898] snd_hda_intel: Unknown symbol snd_pcm_period_elapsed
[   37.951917] snd_hda_intel: disagrees about version of symbol snd_pcm_hw_constraint_step
[   37.951919] snd_hda_intel: Unknown symbol snd_pcm_hw_constraint_step

This may just mean I fluffed the installation, but there is nothing in the
install file to clue me in about how.

> Also, if this doesn't fix the problem, can you send a link generated
> from running http://bulletproof.servebeer.com/alsa/scripts/alsa-info.sh
> It has a lot of detailed information about your audio configuration.

http://pastebin.ca/777163
 
> I looked at the driver code, and your specific system is listed (I
> should know - I added it 8/2006).

If it would help, I'd be willing to create a guest account on the machine 
for you and work with you in real-time to resolve the problem.  You can't hear
my speakers, of course, but I strongly suspect that if we could get the
driver and its codecs to load properly the rest would just be a matter of
making sure they're plugged in.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
