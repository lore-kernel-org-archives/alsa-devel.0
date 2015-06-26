From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ALSA: hdac_ext: add hdac extended controller
Date: Fri, 26 Jun 2015 12:42:44 +0300
Message-ID: <20150626094244.GA29672@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 56E882614D3
 for <alsa-devel@alsa-project.org>; Fri, 26 Jun 2015 11:44:05 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: jeeja.kp@intel.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Jeeja KP,

The patch 0b00a5615dc4: "ALSA: hdac_ext: add hdac extended
controller" from Jun 11, 2015, leads to the following static checker
warning:

	sound/hda/ext/hdac_ext_controller.c:47 snd_hdac_ext_bus_parse_capabilities()
	warn: unsigned 'offset' is never less than zero.

	sound/hda/ext/hdac_ext_controller.c:54 snd_hdac_ext_bus_parse_capabilities()
	warn: unsigned 'cur_cap' is never less than zero.

sound/hda/ext/hdac_ext_controller.c
    38  int snd_hdac_ext_bus_parse_capabilities(struct hdac_ext_bus *ebus)
    39  {
    40          unsigned int cur_cap;
    41          unsigned int offset;
    42          struct hdac_bus *bus = &ebus->bus;
    43          unsigned int counter = 0;
    44  
    45          offset = snd_hdac_chip_readl(bus, LLCH);
    46  
    47          if (offset < 0)
                    ^^^^^^^^^^
    48                  return -EIO;
    49  
    50          /* Lets walk the linked capabilities list */
    51          do {
    52                  cur_cap = _snd_hdac_chip_read(l, bus, offset);
    53  
    54                  if (cur_cap < 0)
                            ^^^^^^^^^^^
    55                          return -EIO;



regards,
dan carpenter
