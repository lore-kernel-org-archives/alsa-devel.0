From: Uli Franke <uli.franke@weiss.ch>
Subject: Constraints and hw_params with highly configurable HW
Date: Tue, 03 Sep 2013 17:45:31 +0200
Message-ID: <5226041B.4010105@weiss.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server11.hostfactory.ch (server11.hostfactory.ch
 [80.190.249.120])
 by alsa0.perex.cz (Postfix) with ESMTP id D563226172B
 for <alsa-devel@alsa-project.org>; Tue,  3 Sep 2013 17:45:32 +0200 (CEST)
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
Cc: Daniel Weiss <weiss@weiss.ch>, Rolf Anderegg <rolf.anderegg@weiss.ch>
List-Id: alsa-devel@alsa-project.org

Hi everybody

We're currently working on some neat enhancements for the still
experimental snd_dice driver originally initiated by Clemens Ladisch. To
list some of the new and already working features:
 * firmware loading, backed by a user-space command line utility
 * generic ALSA control support for mostly all device specific settings
     for all our (i.e. Weiss Engineering) DICE based products
and last but not least
 * capture support
 * slave mode (external clock source support).

I'm currently debugging and fine-tuning things and that's where some
questions arose. The initial implementation of Clemens tried to fetch
all possible configurations of a device during probe in order to have
all combinations of rates and channels at hand when it comes to
formulate the constraints set within the ALSA pcm substream open
callback. That's a nice approach but will fail with a lot of devices as
their configurations can (and mostly will) be volatile. Our devices for
instance feature several switches, options and alike which have heavy
influence on the channel layout and sample rates and combination of both.

I consulted Takashi's documentation on constraints which suggests to
"use the source" but I couldn't find any similar situation within other
drivers (in case I should have missed something, just let me know of
course).

Therefore I had the idea to define some maximum constraints and let the
ALSA hw_params callback fail in case some settings or combinations are
determined to be not supported during its invocation.

Is this viable? Could this be/is this consistent with the specs? If yes,
would EINVAL an appropriate error code to return?

Regards
Uli
