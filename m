From: "Don Gulotta" <DGULOTTA@alliance.csc.com>
Subject: question about parameter settings.
Date: Thu, 06 Jan 2005 07:40:11 -0600
Message-ID: <s1dceb67.088@CSCOTM.rss.hyatt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from CSCOTM.rss.hyatt.com (alliance.csc.com [140.95.202.227])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 53C6723E
	for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2005 14:39:31 +0100 (MET)
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I have a question about the parameters that need to be passed to CS46xx.
 I am running Suse Linux 9.2 and it automatically finds the CS46xx but I
get no sound.  I have looked at the Alsa documentation and the parameter
lists but don't know what the actual values should be.  I only see three
to configure in Yast2 hardware config for the card yet I see 6 in the
documentation.  I get the last three to configure.   

description: "Cirrus Logic Sound Fusion CS46XX" 

author: "Jaroslav Kysela " 

license: "GPL" 

parm: index int array (min = 1, max = 8), description "Index value for
the CS46xx soundcard." 

parm: id string array (min = 1, max = 8), description "ID string for
the CS46xx soundcard." 

parm: enable int array (min = 1, max = 8), description "Enable CS46xx
soundcard." 

parm: external_amp int array (min = 1, max = 8), description "Force to
enable external amplifer." 

parm: thinkpad int array (min = 1, max = 8), description "Force to
enable Thinkpad's CLKRUN control." 

parm: mmap_valid int array (min = 1, max = 8), description "Support OSS
mmap." 


Don Gulotta
Member Technical Staff
MCSE W2k,MCNE,CCNA,Unix Admin
Computer Sciences Corporation
 
1 Tower Lane, Suite 400
Oakbrook Terrace, IL 60181 USA
Direct: 630.990.4867
Fax: 630.990.4832
Email: dgulotta@alliance.csc.com 
Aim: dlg2609


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
