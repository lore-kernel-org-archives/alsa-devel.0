From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: [alsa-devel] [PATCH 13/13] libhinawa: add sample scripts
Date: Sun, 25 Jan 2015 17:14:59 +0500
Message-ID: <54C4DE43.1050105@gmail.com>
References: <1422185674-16431-1-git-send-email-o-takashi@sakamocchi.jp>
	<1422185674-16431-14-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1422185674-16431-14-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

25.01.2015 16:34, Takashi Sakamoto wrote:
> +from array import array
> +
> +# helper function
> +def get_array():
> +    # The width with 'L' parameter is depending on environment.
> +    arr = array('L')
> +    if arr.itemsize is not 4:
> +        arr = array('I')
> +    return arr


If you insist on using arrays, then please add an assertion that you 
have actually got an array with itemsize 4 at the end. But, if I were 
you, I'd go with the "ctypes" module instead, if it works. Here is how 
you get a fixed-size (in the example, 10 elements) array with signed 
4-byte elements:

from ctypes import *
TenInts = c_int32 * 10
ii = TenInts()

The result supports buffer protocol.

-- 
Alexander E. Patrakov

------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
