From: Christian Vogel <vogelchr@vogel.cx>
Subject: Uninitialized id returned by
	saffirepro_both_clk_src_get.
Date: Sat, 25 Oct 2014 13:40:40 +0200
Message-ID: <1414237241-18984-1-git-send-email-vogelchr@vogel.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay06.ispgateway.de (smtprelay06.ispgateway.de
 [80.67.31.103]) by alsa0.perex.cz (Postfix) with ESMTP id 0531A26060C
 for <alsa-devel@alsa-project.org>; Sat, 25 Oct 2014 13:40:52 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: o-takashi@sakamocchi.jp
List-Id: alsa-devel@alsa-project.org

Hi,

there's a possibility to get a Oops caused by an uninitialized value
in snd_bebob_stream_check_internal_clock for a SaffirePro running on the
internal clock.

	[   88.100531] BUG: unable to handle kernel paging request at 8a3c85fc          
	[   88.103808] IP: [<e8553aa0>] snd_bebob_stream_check_internal_clock+0x66/0x11e [snd_bebob]

...which is dereferencing of clk_spec->labels[id] in...

	sound/firewire/bebob/bebob_stream.c :

	/* 1.The device has its own operation to switch source of clock */
	if (clk_spec) {
		err = clk_spec->get(bebob, &id);
		if (err < 0)
			dev_err(&bebob->unit->device,
				"fail to get clock source: %d\n", err);
-->		else if (strncmp(clk_spec->labels[id], SND_BEBOB_CLOCK_INTERNAL,
				 strlen(SND_BEBOB_CLOCK_INTERNAL)) == 0)
			*internal = true;
		goto end;
	}

id is uninitialized, and will not be set by clk_spec->get (which is
saffirepro_both_clk_src_get(), even if it returns ok(0).

Attached patch tries to clean up the logic in saffirepro_both_clk_src_get()
and also adds a safety check to snd_bebob_stream_check_internal_clock().

Thanks for Takashi Sakamoto to whom I sent the patch initially and who
suggested some cleanup to my code, reviewed the patch and suggested I send
it to alsa-dev.

	Chris
