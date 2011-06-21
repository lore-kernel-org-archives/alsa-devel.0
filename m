From: Ian Minett <ian_minett@creativelabs.com>
Subject: [PATCH 1/1][resubmit] Add patch file and Makefile
	entry for CA0132 HDA codec
Date: Mon, 20 Jun 2011 17:36:10 -0700
Message-ID: <1308616570-4331-1-git-send-email-ian_minett@creativelabs.com>
References: <s5hsjra86ze.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-outbound2.cli.creative.com (unknown [198.95.32.213])
	by alsa0.perex.cz (Postfix) with ESMTP id 1D20C244DC
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jun 2011 02:39:19 +0200 (CEST)
In-Reply-To: <s5hsjra86ze.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Ian Minett <ian_minett@creativelabs.com>
List-Id: alsa-devel@alsa-project.org

Great, thank you very much for your help.
I've included the new changelog text below.

- Ian

Signed-off-by: Ian Minett <ian_minett@creativelabs.com>

---

ALSA: hda - Add Creative CA0132 HDA codec support.

Create patch_ca0132.c, to add support for devices featuring the Creative CA0132 HD-audio codec.

This driver implements :-
* 1 playback subdevice to headphone and speaker
* 2 capture subdevices:
   i - Mic-in 
   ii- Line-in
* mixer device

Advanced DSP features are not yet included.
Developed and maintained by Creative Labs, Inc.
