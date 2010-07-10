From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Smart 5.1 function not working on VIA VT1708S with
	*three* jacks on mainboard
Date: Sat, 10 Jul 2010 17:41:35 +0800
Message-ID: <AANLkTim0B4gB4X1SfURg_NF4-gnJ3GTGjCH1PIVwBtfD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6584F2443D
	for <alsa-devel@alsa-project.org>;
	Sat, 10 Jul 2010 11:41:38 +0200 (CEST)
Received: by gxk26 with SMTP id 26so1925154gxk.38
	for <alsa-devel@alsa-project.org>; Sat, 10 Jul 2010 02:41:36 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>> It might be. It is important not to mix VT1708 and VT1708S. For VT1708S,
the following DACs are used in code:

  /* config dac list */
  switch (i) {
  case AUTO_SEQ_FRONT:
  	spec->multiout.dac_nids[i] = 0x10;
  	break;
  case AUTO_SEQ_CENLFE:
  	spec->multiout.dac_nids[i] = 0x24;
  	break;
  case AUTO_SEQ_SURROUND:
  	spec->multiout.dac_nids[i] = 0x11;
  	break;
  case AUTO_SEQ_SIDE:
  	spec->multiout.dac_nids[i] = 0x25;
  	break;
  }

>>  So 0x12 is not used for any of the surround outputs.

I think your testing config is not compiled with smart 5.1 requirement

Refer to smart51_get() , this function exepct red jack and blue jack
are configued to Output

But you still plugged in Mic into the pink jack according to your photo.

Your speakers have to plugged in both pink and blue jacks
