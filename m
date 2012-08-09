From: David Henningsson <david.henningsson@canonical.com>
Subject: Question about surround default pin config
Date: Thu, 09 Aug 2012 14:51:40 +0200
Message-ID: <5023B25C.2070204@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id DABD42652BF
 for <alsa-devel@alsa-project.org>; Thu,  9 Aug 2012 14:21:50 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi,

Sometimes it's better to just ask than getting confused trying to figure 
it out yourself.

When you have 2 stereo pairs of line-out or speaker, they are meant as 
either 4.0 (front left, front right, rear left, rear right), and 
sometimes they are meant as 2.1 (front left, front right, unused, lfe).

We should support both variations, I assume.

What is really the way to write my pin fixups to specify either 4.0 or 
2.1? Are there any de-facto standards?

If I look at e g check_output_sfx (in hda_auto_parser.c), it looks like 
it would be impossible to have 2.1, i e, impossible to have LFE without 
also having rear left and rear right. But I might be missing something?

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
