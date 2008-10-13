From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Salsa-lib  : _snd_pcm_hw_param_test is not defined
Date: Mon, 13 Oct 2008 11:49:03 +0200
Message-ID: <48F3198F.50409@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from toronto.xi-lite.net (co203.xi-lite.net [149.6.83.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 0532B243F8
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Oct 2008 11:49:29 +0200 (CEST)
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
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

it seems there is a missing implementation of _snd_pcm_hw_param_test
function in src/pcm_params.c .

It is used in pcm_macros.h by snd_pcm_hw_params_test_xxx functions.

Thanks

Matthieu
