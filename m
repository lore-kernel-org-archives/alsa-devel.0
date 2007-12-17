From: Andy Shevchenko <andy@smile.org.ua>
Subject: Re: rfe: keep SND_PCI_QUIRK groups are sorted
	by	vendor and product id pair
Date: Mon, 17 Dec 2007 18:49:38 +0200
Message-ID: <20071217164938.GB29292@serv.smile.org.ua>
References: <20071215223031.GA29292@serv.smile.org.ua>
	<s5hve6xz8rh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Nq2Wo0NMKNjxTN9z"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from serv.smile.org.ua (serv.smile.org.ua [193.178.237.153])
	by alsa0.perex.cz (Postfix) with ESMTP id C6A771038C3
	for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2007 17:50:38 +0100 (CET)
Resent-Message-ID: <20071217165037.GC29292@serv.smile.org.ua>
Resent-To: alsa-devel@alsa-project.org
Content-Disposition: inline
In-Reply-To: <s5hve6xz8rh.wl%tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline

Hi Takashi Iwai!

 On Mon, Dec 17, 2007 at 03:38:26PM +0100, Takashi Iwai wrote next:

> > Some to be discussed. I found the SND_PCI_QUIRK group (lines with this macro
> > under one structure) is unsorted. Almost in all cases no sense to make so.
> > I wrote python script to keep lists sorted.
> > Please, comment this.
> 
> Thanks, that's nice.  I applied it and fixed some entries manually
> (e.g. the wildcard one with device_id = 0).  Now patch_*.c have sorted
> list except for patch_sigmatel.c.
Yes, I find all sources with that macro and try to fix it.

First of, sigmatel need to be more complex algorithm.

Second, I wrote new (optimized) version of script (see attachment).

Third, the script makes warnings with the duplicate lines with the same
vendor and product id pair. Good to search possible collision.

Fourth, in appearance we need to separate some blocks in the structure by
empty lines like following

struct {
...
SND_PCI_QUIRK section1
...
<empty line>
section2
...
 {}
}

And then sort only in the sections of the groups. I'll think about that.
This case is a good to apply even to patch_sigmatel.c

As result, we need some special rules for these structures to keep they in
prefer manner.

-- 
With best regards,
Andy Shevchenko.      mailto: andy@smile.org.ua



--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=koi8-r
Content-Disposition: attachment; filename="snd_quirk_resort.py"

#!/usr/bin/python
# -*- coding: UTF-8 -*-
# vim: ts=4 sw=4 et:

"""
The script sorts SND_PCI_QUIRK groups by vendor and product id pair.
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

def get_vpid(vid, pid):
    """ Construct value of the vendor and product id pair """
    vconv = {
        'PCI_VENDOR_ID_INTEL':  '0x8086',
        'PCI_VENDOR_ID_DELL':   '0x1028',
    }
    if vid in vconv.keys():
        vid = vconv[vid]
    return (int(vid, 16) << 16) + int(pid, 16)

def parse_quirks(quirks):
    """ Parse buffer as SND_PCI_QUIRK group """
    rexp_begin = re.compile("^\s*[/\*]*\s*SND_PCI_QUIRK\((?P<vid>[^,]+),\s*(?P<pid>[^,]+)")
    rexp_end = re.compile("\),\s*(/\*.+\*/)?\s*$")

    xbuffer = {} # vendor, product: prefix lines + line + postfix lines

    flag = False
    vpid = 0
    prefix = []

    for line in quirks:
        if line.strip() == '':
            continue
        rmatch = rexp_begin.match(line)
        if rmatch:
            vpid = get_vpid(rmatch.group('vid'), rmatch.group('pid'))

            if xbuffer.has_key(vpid):
                print "Warning: the line '%s' is duplicate!" % line.strip()
                xbuffer[vpid].append(line)
            else:
                xbuffer[vpid] = prefix
                xbuffer[vpid].append(line)
                prefix = []

            if rexp_end.search(line):
                flag = False
            else:
                flag = True
        else:
            if flag == False:
                prefix.append(line)
            else:
                xbuffer[vpid].append(line)

            if rexp_end.search(line):
                flag = False
    return xbuffer

def sort_quirks(quirks):
    """ Sort SND_PCI_QUIRK group by vendor and product id pair """
    xbuffer = []

    keys = quirks.keys()
    keys.sort()

    for key in keys:
        xbuffer.extend(quirks[key])

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
        if flag == True and line.strip() in ('{}', '{} /* terminator */'):
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

--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Nq2Wo0NMKNjxTN9z--
