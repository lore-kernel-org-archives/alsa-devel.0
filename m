From: David Henderson <dhenderson@digital-pipe.com>
Subject: compile problems
Date: Mon, 27 Jun 2011 09:09:39 -0400
Message-ID: <4E088113.6040500@digital-pipe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8139124503
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Jun 2011 15:11:22 +0200 (CEST)
Received: by gwj17 with SMTP id 17so2204304gwj.38
	for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2011 06:11:21 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Greetings all!  I've tried this question in the "alsa user" group 
without success, but was pointed in the direction of this mailing list.  
Currently I'm trying to compile the alsa packages to get it compiled for 
a custom Linux distro.  I'm not having any problems compiling the 
alsa-lib package, but when I try to compile alsa-utils, I keep getting 
the following error:

checking for libasound headers version>= 1.0.16... not present.
configure: error: Sufficiently new version of libasound not
found.


To provide more details about the situation, I'm using an existing 
distro (Kubuntu 9.10) to build the alsa packages and are using the 
/opt/staging/alsa directory to compile and "install" to (using the 
DESTDIR parameter).  Seeing as how this is a staging directory and not 
the actual place the package is being installed to, I'm having the afore 
mentioned problem because the alsa-utils package is looking under /... 
for the header files instead of the /opt/staging/alsa/... directory.  Is 
there a compile-time parameter that I can use so that alsa-utils looks 
in the staging directory for the header files - just during the compile 
phase?

Thanks,
Dave
