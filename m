From: David Moylan <dave@westphila.net>
Subject: Bug in snd-powemac?
Date: Tue, 02 Apr 2002 14:12:21 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CAA0295.7070802@westphila.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from gull.prod.itd.earthlink.net (gull.mail.pas.earthlink.net [207.217.120.84])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA10167
	for <alsa-devel@alsa-project.org>; Tue, 2 Apr 2002 21:13:19 +0200
Received: from nycmny1-ar3-4-43-214-161.elnk.dsl.gtei.net ([4.43.214.161] helo=westphila.net)
	by gull.prod.itd.earthlink.net with esmtp (Exim 3.33 #1)
	id 16sTiM-0002Ae-00
	for alsa-devel@alsa-project.org; Tue, 02 Apr 2002 11:13:06 -0800
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

I've been hunting through the snd-powermac source trying to get sound to 
work on my Powerbook G4 (3,2).  This didn't get sound working, but I 
think I found an easily correctable bug in the code.

I'd like some input from anyone who might be more more familiar with 
than code than me.  The bug is in the function snd_pmac_awacs_put_switch 
defined in awacs.c at about line 214 (i've been adding snd_printk debug 
messages so my line numbers may be slightly off).  The function is 
similar to snd_pmac_awacs_put_volume which I believe is coded correctly.

The problem is that _put_switch doesn't allow a switch to write to any 
register but register 1.  It is hard coded.  At the very least though, 
one could expect desired writes to registers 0 and 1.  Besides, the 
switches themselves carry a parameter specifying which register to use. 
  I believe the code should be changed to allow writing to the specified 
register.  Also, to make the code more clear and I think more 
functional, the desired register and bitmask should be stripped off from 
kcontrol->private_value and stored in variables reg and bitmask.  Again, 
this is similar to _put_volume.

Any thoughts?

Dave Moylan
