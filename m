From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: 1.0.15rc3 patch_analog.s bug + fix
Date: Tue, 16 Oct 2007 10:58:19 +0300
Message-ID: <200710161058.19929.anarsoul@gmail.com>
References: <20071015025303.GA17664@jay.phy.queensu.ca>
	<s5hsl4c62fl.wl%tiwai@suse.de>
	<20071015203421.GA6047@jay.phy.queensu.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 588C9244F7
	for <alsa-devel@alsa-project.org>;
	Tue, 16 Oct 2007 09:58:28 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id b21so1408419nfd
	for <alsa-devel@alsa-project.org>; Tue, 16 Oct 2007 00:58:27 -0700 (PDT)
In-Reply-To: <20071015203421.GA6047@jay.phy.queensu.ca>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> > Hmm, the code logic looks correct to me.  If HP jack is present, the
> > internal speaker should be muted.  Otherwise it follows the state of
> > HP jack (muted/unmuted, that acts as a master switch).

Original patch:
	present = snd_hda_codec_read(codec, 0x1a, 0,
				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
 
Code in alsa (patch-analog.c line 614):

	present = snd_hda_codec_read(codec, 0x1a, 0, AC_VERB_GET_PIN_SENSE, 0);
	spec->jack_present = (present & 0x80000000) != 0;

Seems to have quite different logic, don't it?

Should be:

	present = snd_hda_codec_read(codec, 0x1a, 0, AC_VERB_GET_PIN_SENSE, 0);
	spec->jack_present = (present & 0x80000000) == 0;

P.S. It's very sad that you've released 1.0.15 with that bug :(
