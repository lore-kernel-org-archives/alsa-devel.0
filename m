From: Jason Baron <jbaron@redhat.com>
Subject: stac92xx_parse_auto_config() can return 0 on error?
Date: Mon, 5 Feb 2007 16:40:57 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702051624060.26250@dhcp83-20.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 14F6D18F
	for <alsa-devel@alsa-project.org>; Mon,  5 Feb 2007 22:43:23 +0100 (MET)
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com
	[172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l15LhMuf012602
	for <alsa-devel@alsa-project.org>; Mon, 5 Feb 2007 16:43:22 -0500
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
Cc: John Linville <linville@redhat.com>
List-Id: alsa-devel@alsa-project.org


hi,

I just ran into a RHEL4 U5 beta kernel oops in snd_hda_input_mux_info(), 
because the 'imux' parameter pointer was NULL. I traced this back to 
stac92xx_parse_auto_config(), which can return 0, if 'line_outs' is not 
set, without having initialized the 'input_mux'.

The oops does not happen on the upstream kernel on this hardware b/c 
'line_outs' was set (additional code has been added since RHEL4 to set 
it). However, it still appears to me, that if 'line_outs' is not set, we 
should return an error code, and not 0.

thanks,

-Jason

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
