From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 000/112] HD-audio generic parser
	improvements
Date: Tue,  8 Jan 2013 12:37:53 +0100
Message-ID: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E1722615C5
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:23 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 00002A51B8
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:21 +0100 (CET)
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
List-Id: alsa-devel@alsa-project.org

Hi,

this is a large series of patches to implement the really generic
HD-audio codec parser usable for various codecs.  It's based on the
Realtek codec parser, so I started hacking patch_realtek.c for more
generalization and improvements.  Then it's merged to the existing
generic parser code, hda_generic.c, and let Realtek parser just uses
this new parser code.  In the end, patch_realtek.c contains only
the device specific fixups and the call of generic parser functions.

The series contains a few improvements in the HD-audio core code,
some of which aren't really dependent on the generic parser code.
They are just there as I've developed this for a couple of weeks.

After this patchset, most of other codecs can be migrated as well.
Currently analog, ca0110, cirrus, cmedia, conexant and via codecs
have been already rewritten (i.e. the own parser codes dropped).
patch_sigmatel.c is still not converted yet, but can be done soon
later.  I'm going to send the conversion patches for these codecs
right after this series.

I don't expect to merge all conversions of codec parsers in 3.9
kernel, but at least, the conversion of Realtek and this generic
parser code addition can be merged to 3.9.  Maybe minor and easy ones
like ca0110 and cmedia can be merged as well.


Takashi
