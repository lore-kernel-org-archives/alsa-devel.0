From: Glenn Golden <gdg@zplane.com>
Subject: Re: [pulseaudio-discuss] ThinkPad T-510 audio output
 mute LED non-workingness
Date: Tue, 28 Apr 2015 05:39:48 -0600
Message-ID: <20150428113948.GN550@huh.zplane.com>
References: <20150426152012.GE550@huh.zplane.com>
 <s5hvbgiho2o.wl-tiwai@suse.de>
 <CAN8cciZQBRz2Ty3YRt2+3KO9v1BWef-_8FU_d_SsE87mLdgY-w@mail.gmail.com>
 <s5hh9s2gj45.wl-tiwai@suse.de>
 <20150427135859.GI550@huh.zplane.com>
 <s5ha8xt4hsa.wl-tiwai@suse.de>
 <20150428000206.GK550@huh.zplane.com>
 <s5hmw1s3hxh.wl-tiwai@suse.de>
 <20150428101645.GM550@huh.zplane.com>
 <s5h618gwnno.wl-tiwai@suse.de>
Reply-To: gdg@zplane.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.indra.com (smtp.indra.com [209.169.0.20])
 by alsa0.perex.cz (Postfix) with ESMTP id C10282605A3
 for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2015 13:39:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h618gwnno.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Alex Hung <alex.hung@canonical.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Raymond Yau <superquad.vortex2@gmail.com>, bruno.mueller@gmail.com, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> [2015-04-28 12:30:19 +0200]:
> 
> Then it's likely an issue in thinkpad_acpi.c.  It implies that the
> driver couldn't get SSMS acpi handle.
> 

Raymond had pointed this out earlier as a (the?) patch that brought the static
tp_led_table led_tables[] into existence:

    http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/platform/x86/thinkpad_acpi.c?id=420f9739a62cdb027f5580d25c813501ff93aa6f

To my eyes, the table appears to be as it was in that patch:

    ---------------------------------------------------------------------------
    static struct tp_led_table led_tables[] = {
	    [TPACPI_LED_MUTE] = {
		    .name = "SSMS",
		    .on_value = 1,
		    .off_value = 0,
	    },
	    [TPACPI_LED_MICMUTE] = {
		    .name = "MMTS",
		    .on_value = 2,
		    .off_value = 0,
	    },
    };
    ---------------------------------------------------------------------------

thinkpad_acpi.h defines this enum and func:

    ---------------------------------------------------------------------------
    /* These two functions return 0 if success, or negative error code
       (e g -ENODEV if no led present) */

    enum {
	    TPACPI_LED_MUTE,
	    TPACPI_LED_MICMUTE,
	    TPACPI_LED_MAX,
    };

    int tpacpi_led_set(int whichled, bool on);
    ---------------------------------------------------------------------------

although I don't understand why the comment says "these TWO functions..."
since there's only one.

How to learn more about the source of LED_MUTE's evident non-existence in
my build? I guess I don't understand how the above "SSMS" entry in the table
is non-existent? Is there a function-pointer table/hash in which "SSMS" is
further used as a key?

> 
> For HD-audio, you need to unload the codec drivers at first, e.g.
> [ ... ]
>

Thanks, that will help a lot, as the machine is in constant use and
reboots are painful.
