From: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Subject: [PATCH v3 0/1]  Codec driver for TI WL1273 FM Radio.
Date: Fri, 23 Jul 2010 15:42:50 +0300
Message-ID: <1279888971-14296-1-git-send-email-matti.j.aaltonen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id C4F771039E1
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Jul 2010 14:43:06 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
Cc: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
List-Id: alsa-devel@alsa-project.org

Hello all.

Thank you for comments and thanks to Peter for advice on constraints
and ALSA in general.

New in this version:

1. Now constraints are used in the start-up function. It wasn't as big
a deal as I thought... Also now the codec is always in full duplex
mode.  But it still refuses to do the wrong thing with FM as real full
duplex is then impossible.

2. Fixed the exported mode support function. The name in now
wl1273_get_format and it returns the audio interface format.

3. Removed the remaining obsolete functions.

4. Not actually new but...

>> I didn't do this yet. But could you give me the git URL and then
>> I'll resend?
> git://git.kernel.org/pub/scm/linux/kernel/git/lrg/sound-2.6.git

I tried the corresponding http URL

http://www.kernel.org/pub/scm/linux/kernel/git/lrg/sound-2.6.git but
got

fatal: 
http://www.kernel.org/pub/scm/linux/kernel/git/lrg/sound-2.6.git/info/refs
not found: did you run git update-server-info on the server?

Cheers,
Matti

Matti J. Aaltonen (1):
  ASoC: TI WL1273 FM Radio Codec.

 sound/soc/codecs/wl1273.c |  598 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wl1273.h |   43 ++++
 2 files changed, 641 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/wl1273.c
 create mode 100644 sound/soc/codecs/wl1273.h
