From: rct@gherkin.frus.com (Bob Tracy)
Subject: PNP vs. sound/isa/cs423x/cs4236.c in 2.6.16-rc1
Date: Sat, 21 Jan 2006 09:48:05 -0600 (CST)
Message-ID: <20060121154805.4D3DADBA1@gherkin.frus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gherkin.frus.com (gherkin.frus.com [192.158.254.49])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7AC3D192
	for <alsa-devel@alsa-project.org>; Sat, 21 Jan 2006 16:48:07 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

The rework of various ALSA drivers between 2.6.15 and 2.6.16-rc1 has
apparently introduced a dependency on CONFIG_PNP.  Unfortunately, PNP
has been problematic on my old Toshiba notebook (Tecra 730XCDT), so I
have CONFIG_PNP undefined in my kernel configuration.  This is the
result, because the define for CS423X_DRIVER doesn't happen without
CONFIG_PNP:

  CC [M]  sound/isa/cs423x/cs4232.o
  In file included from sound/isa/cs423x/cs4232.c:2:
  sound/isa/cs423x/cs4236.c:612: error: `CS423X_DRIVER' undeclared here (not in a function)
  sound/isa/cs423x/cs4236.c:612: error: initializer element is not constant
  sound/isa/cs423x/cs4236.c:612: error: (near initialization for `cs423x_nonpnp_driver.driver.name')
  sound/isa/cs423x/cs4236.c:612: error: initializer element is not constant
  sound/isa/cs423x/cs4236.c:612: error: (near initialization for `cs423x_nonpnp_driver.driver')
  sound/isa/cs423x/cs4236.c: In function `snd_cs423x_unregister_all':
  sound/isa/cs423x/cs4236.c:751: error: `cs423x_pnpc_driver' undeclared (first use in this function)
  sound/isa/cs423x/cs4236.c:751: error: (Each undeclared identifier is reported only once
  sound/isa/cs423x/cs4236.c:751: error: for each function it appears in.)
  sound/isa/cs423x/cs4236.c:754: error: `cs4232_pnp_driver' undeclared (first use in this function)
  sound/isa/cs423x/cs4236.c: In function `alsa_card_cs423x_init':
  sound/isa/cs423x/cs4236.c:772: error: `CS423X_DRIVER' undeclared (first use in this function)
  sound/isa/cs423x/cs4236.c:782: error: `cs4232_pnp_driver' undeclared (first use in this function)
  sound/isa/cs423x/cs4236.c:788: error: `cs423x_pnpc_driver' undeclared (first use in this function)
  make[3]: *** [sound/isa/cs423x/cs4232.o] Error 1
  make[2]: *** [sound/isa/cs423x] Error 2
  make[1]: *** [sound/isa] Error 2
  make: *** [sound] Error 2

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
