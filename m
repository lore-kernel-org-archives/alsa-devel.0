From: Daniel Mack <daniel@caiaq.org>
Subject: snd_pcm_hw_params_get_period_size points to __old_
	symbol
Date: Sun, 22 Feb 2009 22:35:53 +0100
Message-ID: <20090222213553.GA5893@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id AE74424492
	for <alsa-devel@alsa-project.org>; Sun, 22 Feb 2009 22:35:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id C98F67F404F
	for <alsa-devel@alsa-project.org>; Sun, 22 Feb 2009 22:35:55 +0100 (CET)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop.caiaq.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y7UnIwXhvuHT for <alsa-devel@alsa-project.org>;
	Sun, 22 Feb 2009 22:35:53 +0100 (CET)
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

Hi,

With alsa-lib and alsa-utils cross-compiled for ARM by
buildroot (currently version 1.0.19, but earlier versions
seem to be equally affected), I encounter the effect that
snd_pcm_hw_params_get_period_size() does not write the expected
value to the given snd_pcm_uframes_t pointer. In fact, this
variable is not written at all. This makes aplay calculate 0
for chunk_bytes in set_params() and then exit with the bogus error
message "Not enough memory". I did some tracing and found out that
the function called for snd_pcm_hw_params_get_period_size() is in
fact __old_snd_pcm_hw_params_get_period_size() which has a different
footprint and hence the pointer given to it is leaved untouched.

As I don't fully understand all the system behind the symbol names
remapping, I'm stuck here. Can anybody reproduce this bug?

Daniel
