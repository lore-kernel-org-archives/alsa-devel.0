From: Pierre Ossman <ossman@cendio.se>
Subject: Re: alsa-plugins 1.0.11 has broken ltmain.sh
Date: Wed, 03 May 2006 16:01:38 +0200
Message-ID: <4458B7C2.7030900@cendio.se>
References: <4450657A.2010405@cendio.se> <s5hbqufgt6h.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.cendio.se (mail.cendio.se [193.12.253.69])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AD31F159
	for <alsa-devel@alsa-project.org>; Wed,  3 May 2006 16:01:40 +0200 (MEST)
In-Reply-To: <s5hbqufgt6h.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Thu, 27 Apr 2006 08:32:26 +0200,
> Pierre Ossman wrote:
>> When I compile the alsa-plugins package, the resulting modules lack the 
>> .so suffix, causing them to be installed incorrectly. This seems to be a 
>> problem with the ltmain.sh shipped in the package as things work 
>> perfectly if I re-libtoolize the tree.
> 
> Works for me.
> 
> Which distro are you using?
> 

FC4, fully updated.

-- 
Pierre Ossman                Telephone: +46-13-21 46 00
Cendio AB                    Web: http://www.cendio.com


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
