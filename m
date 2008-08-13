From: Jaroslav Kysela <perex@perex.cz>
Subject: alsactl init - implementation and more..
Date: Wed, 13 Aug 2008 12:59:32 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0808131205130.21669@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id DEA12244CC
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Aug 2008 12:59:41 +0200 (CEST)
Received: from server.perex.cz (server.perex.cz [172.16.0.20])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	C9CE2149C3D for <alsa-devel@alsa-project.org>;
	Wed, 13 Aug 2008 12:59:39 +0200 (CEST)
Received: from tm8103.perex-int.cz (localhost [127.0.0.1])
	by server.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	BA45D84378 for <alsa-devel@alsa-project.org>;
	Wed, 13 Aug 2008 12:59:39 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

	some developers probably already noted, I commited to alsactl 
utility (alsa-utils package) initial implementation of soundcard 
initialization stuff aka 'alsactl init'.
	The basic idea was to "reuse" nice udev configuration style and 
modify it to ALSA purposes. I hope that I ended up with a syntax which is 
easy understandable and configuration can be created with minimal effort.
Please, look to 'man 7 alsactl_init' for more details and to 
alsa-utils/alsactl/init directory for example files.
	Note that the runtime evaluation of commands can be modified using 
environment variables like udev does. Just try 'alsactl -E CMD=help init' 
or 'CMD=help alsactl init'.
	Hardware can be detected using sysfs. For older kernel, I'm 
plannig to add some compatibility layer to read at least 
ATTR{subsystem_vendor} and ATTR{subsystem_device} information from procfs 
(codec files).
	Also, a way to gather working configurations for specific hardware 
is required. A nice script alsa-info.sh is already in the alsa-driver 
package, so I just created a simple persistent "file" dabatase on 
www.alsa-project.org: http://www.alsa-project.org/cardinfo-db/ and 
modified alsa-info.sh to use this database for the contents upload by 
default. Developers can download whole database in a tar package to 
extract necessary information using command line text tools and use this 
database also for other purposes (HDA codec graphing and so).

	More ideas, corrections, opinions are welcome.

						Jaroslav	

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
