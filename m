From: David Henningsson <david.henningsson@canonical.com>
Subject: hda-jack-sense-test
Date: Mon, 16 May 2011 17:40:56 +0200
Message-ID: <4DD14588.5090101@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030109030706000807020800"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 7C4942450B
	for <alsa-devel@alsa-project.org>;
	Mon, 16 May 2011 17:40:57 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, ubuntu-audio-dev@lists.launchpad.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030109030706000807020800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Just a little something I wrote on the train back home yesterday. I hope 
someone finds it a nice way to figure out if your BIOS is lying to you 
about what pin is used for what. It (re)uses some of the classes in 
hda-analyzer.

For Ubuntu 11.04 users, this small tool is now packaged together with 
codecgraph, hda-verb, hda-emu and hda-analyzer in my snd-hda-tools 
package, which is available in ppa:diwic/ppa.


-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------030109030706000807020800
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


--------------030109030706000807020800
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030109030706000807020800--
