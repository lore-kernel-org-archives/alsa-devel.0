From: Paul Davis <pbd@op.net>
Subject: another control API issue
Date: Tue, 7 May 2002 20:08:54 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205080008.g4808se10498@op.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx1.fast.net (newmx1.fast.net [209.92.1.31])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id CAA29762
	for <alsa-devel@alsa-project.org>; Wed, 8 May 2002 02:08:18 +0200
Received: from unknown (HELO op.net) ([209.92.100.57]) (envelope-sender <pbd@op.net>)
          by newmx1.fast.net (qmail-ldap-1.03) with SMTP
          for <alsa-devel@alsa-project.org>; 8 May 2002 00:08:16 -0000
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

the h-dsp has some 64 bit registers. the current control API doesn't
offer a way of representing such values. shall i add
      
      SNDRV_CTL_ELEM_TYPE_INTEGER64 

?

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
