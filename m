From: Andy Shevchenko <andy@smile.org.ua>
Subject: rfe: keep SND_PCI_QUIRK groups are sorted by vendor
	and product id	pair
Date: Sun, 16 Dec 2007 00:30:31 +0200
Message-ID: <20071215223031.GA29292@serv.smile.org.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from serv.smile.org.ua (serv.smile.org.ua [193.178.237.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 12AFA2437B
	for <alsa-devel@alsa-project.org>; Sat, 15 Dec 2007 23:30:36 +0100 (CET)
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

Hi!

Some to be discussed. I found the SND_PCI_QUIRK group (lines with this macro
under one structure) is unsorted. Almost in all cases no sense to make so.
I wrote python script to keep lists sorted.

Please, comment this.

P.S. Known bug is a deletion of the empty lines under group.

#!/usr/bin/python
# -*- coding: UTF-8 -*-
# vim: ts=4 sw=4 et:

"""
The sript sorts SND_PCI_QUIRK groups by vendor and product id pair.
"""

__author__ = "Andy Shevchenko <andy@smile.org.ua>"
__revision__ = "$Id$"

import sys
import os
import re

def read_file(fname):
    """ Read given file """
    fdes = open(fname, 'rt')
    result = fdes.readlines()
    fdes.close()
    return result

def save_file(fname, lines):
    """ Write lines to the given file """
    fdes = open(fname, 'wt')
    fdes.writelines(lines)
    fdes.flush()
    fdes.close()

def parse_quirks(quirks):
    """ Parse buffer as SND_PCI_QUIRK group """
    rexp_begin = re.compile("^\s*[/\*]*\s*SND_PCI_QUIRK\((?P<vid>[^,]+),\s*(?P<pid>[^,]+)")
    rexp_end = re.compile("\),\s*(/\*.+\*/)?\s*$")

    xbuffer = {} # vendor, product: prefix lines, line, postfix lines

    flag = False
    vpid = 0

    prefix = []
    postfix = []

    for line in quirks:
        if line.strip() == '':
            continue

        rmatch = rexp_begin.match(line)
        if rmatch:
            if flag == True:
                xbuffer[vpid][2].extend(postfix)
                postfix = []
                flag = False

            vpid = (int(rmatch.group('vid'), 16) << 16) + int(rmatch.group('pid'), 16)

            if xbuffer.has_key(vpid):
                print "Warning: the line '%s' is duplicate!" % line.strip()
                xbuffer[vpid][2].append(line)
            else:
                xbuffer[vpid] = [prefix, line, []]
                prefix = []

            if not rexp_end.search(line):
                flag = True
        else:
            if flag == False:
                prefix.append(line)
            else:
                postfix.append(line)

    return xbuffer

def sort_quirks(quirks):
    """ Sort SND_PCI_QUIRK group by vendor and product id pair """
    xbuffer = []

    keys = quirks.keys()
    keys.sort()

    for key in keys:
        quirk = quirks[key]
        xbuffer.extend(quirk[0])
        xbuffer.append(quirk[1])
        xbuffer.extend(quirk[2])

    return xbuffer

def catch_quirk_lines(lines):
    """ Catch SND_PCI_QUIRK group from lines and sort it """
    rexp_begin = re.compile("\s*struct\s+snd_pci_quirk\s+.+\s*=\s*{\s*$")

    flag = False
    xbuffer = []
    quirks = []
    for line in lines:
        if flag == False and rexp_begin.search(line):
            xbuffer.append(line)
            quirks.extend(xbuffer)
            flag = True
            xbuffer = []
            continue
        if flag == True and line.strip() == '{}':
            quirks.extend(sort_quirks(parse_quirks(xbuffer)))
            flag = False
            xbuffer = []
        xbuffer.append(line)
    quirks.extend(xbuffer)
    return quirks

def main():
    """ MAIN """
    try:
        fname = sys.argv[1]
    except IndexError:
        print "Usage: %s <input file>" % os.path.basename(sys.argv[0])
        sys.exit(1)
    lines = read_file(fname)
    quirks = catch_quirk_lines(lines)
    save_file('%s.sorted' % fname, quirks)

if __name__ == '__main__':
    main()

# End of file

-- 
With best regards,
Andy Shevchenko.      mailto: andy@smile.org.ua
