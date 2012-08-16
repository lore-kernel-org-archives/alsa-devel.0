From: David Henningsson <david.henningsson@canonical.com>
Subject: command 0x7e7 sent on STAC9200 / STAC9228
Date: Thu, 16 Aug 2012 14:03:39 +0200
Message-ID: <502CE19B.9030000@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A20A265FDA
 for <alsa-devel@alsa-project.org>; Thu, 16 Aug 2012 13:33:53 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

While working with fixing the stuff that my automated test tool has 
discovered, here's one I'm not sure what to do with.

If you run hda-emu on any of these three:

codecs/canonical/stac9200-dell-inspiron-6400-ccert-200705-83
codecs/canonical/stac9200-dell-inspiron-6400-ccert-200712-207
codecs/canonical/stac9228-dell-inspiron-1420-ccert-200708-95

Hda-emu prints out:
invalid command: NID=0x1, verb=0x7e7, parm=0x0

In this case, I'm not sure if the command is invalid (and thus should be 
removed), or if it's a secret IDT verb that we need to set.

 From patch_sigmatel.c:

	/* Configure GPIOx as CMOS */
	snd_hda_codec_write(codec, codec->afg, 0, 0x7e7, 0);

But in hda-spec.c this verb is only in the verb table of IDT codecs, not 
STAC codecs.

Can you offer some enlightement?

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
