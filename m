From: David Henningsson <david.henningsson@canonical.com>
Subject: hda-jack-sense-test (was: Sound issues with
	ALC269VB-based hardware)
Date: Tue, 17 Jul 2012 17:20:27 +0200
Message-ID: <500582BB.4090001@canonical.com>
References: <20120717151109.66d239a5@destiny.ordissimo>
 <s5htxx6jum7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050507090008040904070707"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B42F2651FD
 for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2012 17:20:25 +0200 (CEST)
In-Reply-To: <s5htxx6jum7.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050507090008040904070707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 07/17/2012 05:05 PM, Takashi Iwai wrote:
> Usually the device has a jack detection mechanism, and you can check
> it via hda-verb or whatever.  Plug your headphone to the headphone
> jack, and check any of the pin reacts to GET_PIN_SENSE verb (call it
> after setting SET_PIN_SENSE verb).  For example,
>
> 	% hda-verb /dev/snd/hwC0D0 0x21 SET_PIN_SENSE 1

How many codecs really require SET_PIN_SENSE? I have never had a problem 
with omitting the SET_PIN_SENSE command.

> 	% hda-verb /dev/snd/hwC0D0 0x21 GET_PIN_SENSE 0
>
> Check the value returned from GET_PIN_SENSE.  If bit 31 (0x80000000)
> is set, this is likely the pin of the interest.
>
> Check this for all pins, i.e. between 0x12 and 0x21.  Some nodes are
> no pins, but it doesn't matter much.

Btw, I made convenience script for doing this a year ago. Here it is again.

To install, you put it right next to the hda-analyzer py files, as it 
makes use of hda_codec.py from hda-analyzer, then run "sudo 
hda-jack-sense-test.py -a" (see -h for switches to set codec and card 
indices).

Let me know if you're interested in having this small script in ALSA 
upstream, and if so, what I should do to get it in there.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic



--------------050507090008040904070707
Content-Type: text/x-python;
 name="hda-jack-sense-test.py"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="hda-jack-sense-test.py"

#!/usr/bin/env python
#
# Written by David Henningsson, Copyright 2011 Canonical Ltd. 
# Licensed under GPLv2+

# the hda_codec.py file comes from Jaroslav Kysela's hda_analyzer program.
from hda_codec import *


def parseoptions():
    from optparse import OptionParser
    parser = OptionParser()
    parser.add_option("-c", "--card", dest="cardindex", default=0, metavar="CARD",
        help="card index (as can be seen in /proc/asound/cards)")
    parser.add_option("-d", "--codec", dest="codecindex", default=0, metavar="CODEC",
        help="codec device index (as can be seen in /proc/asound/cardX/codecY)")
    parser.add_option("-a", "--allpins", dest="tryallpins", default=False,
        action="store_true",
        help="also check pins which (probably) are not physical jacks")
    (options, args) = parser.parse_args()
    return int(options.cardindex), int(options.codecindex), options.tryallpins
    
def should_check_presence(node, tryallpins):
    if WIDGET_TYPE_IDS[node.wtype] != 'PIN':
        return False
    if tryallpins:
        return True
    conn_type = (node.defcfg_pincaps >> 30) & 0x03
    if conn_type != 0: # Not a Jack
        return False
    if node.defcfg_pincaps & (1 << 8): # Jack has NO_PRESENCE set
        return False     
    return True

def get_simplecaps(node):
    conn_type = (node.defcfg_pincaps >> 30) & 0x03
    if conn_type == 1: # N/A
        return 'Not connected'
    if conn_type == 0: # Jack
        return "%s %s" % (node.jack_color_name, node.jack_type_name)
    return "Internal %s" % node.jack_type_name

cardindex, codecindex, tryallpins = parseoptions()
codec = HDACodec(cardindex, codecindex)
codec.analyze()
for nid in codec.nodes:
    node = codec.get_node(nid)
    if not should_check_presence(node, tryallpins):
        continue
    present = codec.rw(nid, VERBS['GET_PIN_SENSE'], 0) & 0x80000000
    print "Pin 0x%.2x (%s): present = %s" % (nid, get_simplecaps(node), "Yes" if present else "No")


--------------050507090008040904070707
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------050507090008040904070707--
