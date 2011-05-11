From: Caleb Crome <caleb@crome.org>
Subject: Need general idea how to architect driver for
	multi-codec board
Date: Wed, 11 May 2011 10:31:15 -0700
Message-ID: <BANLkTi=Fi_4nCP7A3Jd9C=4N_FTijOwGdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by alsa0.perex.cz (Postfix) with ESMTP id EAF4B247CB
	for <alsa-devel@alsa-project.org>;
	Wed, 11 May 2011 19:31:21 +0200 (CEST)
Received: by pzk26 with SMTP id 26so393705pzk.38
	for <alsa-devel@alsa-project.org>; Wed, 11 May 2011 10:31:15 -0700 (PDT)
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

Hello All,
   I'm building a board with multiple TLV320AIC33 codecs on board, and I
don't know how I should architect the interface.

The board is set up to use TDM (16 channels on 1 TDM PORT), it has 16 input
and 16 output channels, all bonded together -- the hardware does not allow
different codecs to run at different speeds.

The board also includes several other widgets, like an I2C mux (to address
all 8 stereo codecs), a couple of power amplifiers, and a limited number of
ways the audio can be routed in or out.

My question is this:  I'm not sure how to architect the driver:

1)  Simply instantiate multiple TLV320IAC33 codec drivers, as the AIC33
driver is already written.
    This seems like it won't work because I'd end up with multiple
user-space 'cards', yet I want the card to appear as a single 16-channel
sound card.  Also, when you start one PCM interface for one codec, they
would all start automatically, which I imagine the linux system wouldn't
get.  Also, the PCM interface needs to be configured differently for each
codec (the TDM offset must be 0, 16, 32, 48, etc. bits).

2) rewrite the AIC33 driver to include all 8 codecs, including all the mixer
controls for each codec.  This is going to get REALLY big and ugly in the
user space mixer control -- there will be a zillion controls, most of which
are not really useful for this board.

3) rewrite the AIC33 driver to include all 8 codecs, but pare down the mixer
controls to just the ones that I care about.  If the card changes later, add
in the changes to the driver.

I don't have any huge desire to get the driver into the mainstream kernel
(though I would not be upset if it was popular enough to warrant that), it's
just not a priority.

Any thoughts would be most welcome.

Thanks,
  -Caleb
