From: Bernhard Gerlach <gerlacbd@emt.iis.fhg.de>
Subject: Re: Q:  Error on compiling/linking
Date: Fri, 10 Oct 2003 13:32:58 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F8698EA.7060100@emt.iis.fhg.de>
References: <3F8587F0.1070902@emt.iis.fhg.de>	<s5hy8vu7500.wl@alsa2.suse.de>	<3F865EE1.8080704@emt.iis.fhg.de> <s5hu16h75gq.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hu16h75gq.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Hello,

I found the mistake. The problem was our complicated project/makefile 
structure. We were using the 0.9.7 ALSA-Libs on our systems and we are 
using the header files of the 0.9.7 ALSA-Api. Anyway, we were linking 
against an old ALSA-lib (maybe a 0.9.0 version). After a change in the 
project tree, everything (old and new api) works great now.

However, thank you very much for your efforts!!


Thanks,

Bernhard

-- 

---------------------------------
Bernhard Gerlach
Fraunhofer AEMT
Am Helmholtzring 1 (Haus M)
98693 Ilmenau
Germany

mail: gerlacbd@emt.iis.fhg.de
---------------------------------



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
