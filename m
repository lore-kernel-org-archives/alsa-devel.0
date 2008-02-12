From: Matej Laitl <strohel@gmail.com>
Subject: Re: [ALSA] HDA: no sound in headphone-out caused by
	commit f889fa91ad47e (2.6.25-rc1 regression)
Date: Tue, 12 Feb 2008 12:36:43 +0100
Message-ID: <200802121236.43523.strohel@gmail.com>
References: <200802112158.41989.strohel@gmail.com>
	<200802121150.36743.strohel@gmail.com>
	<s5h7ihav3nr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.187])
	by alsa0.perex.cz (Postfix) with ESMTP id A0AB4103920
	for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2008 12:36:50 +0100 (CET)
Received: by nf-out-0910.google.com with SMTP id b21so1272380nfd.32
	for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2008 03:36:50 -0800 (PST)
In-Reply-To: <s5h7ihav3nr.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Thanks.  It seems that your device has two headphone jacks according
> to the BIOS setup, and this seems to be the problem.
>
> Could you show the kernel messages like "autoconfig: line_outs..." for
> both cases?  This appears when build with CONFIG_SND_DEBUG=y.

Kernel with broken sound:
hda_codec: Unknown model for ALC262, trying auto-probe from BIOS...
autoconfig: line_outs=1 (0x14/0x0/0x0/0x0/0x0)
   speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
   hp_outs=2 (0x1b/0x15/0x0/0x0/0x0)
   mono: mono_out=0x0
   inputs: mic=0x18, fmic=0x19, line=0x0, fline=0x0, cd=0x0, aux=0x0

Kernel with fine sound:
hda_codec: Unknown model for ALC262, trying auto-probe from BIOS...
autoconfig: line_outs=1 (0x14/0x0/0x0/0x0/0x0)
   speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
   hp_outs=2 (0x15/0x1b/0x0/0x0/0x0)
   mono: mono_out=0x0
   inputs: mic=0x18, fmic=0x19, line=0x0, fline=0x0, cd=0x0, aux=0x0

The machine has just headphone-out and mic-in audio connector, but it is 
equipped with port replicator connector, which may feature additional audio 
ports. (and which I unfortunately do not own)

Thanks, Matej
