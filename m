From: Simon Brenner <simon.brenner@mobotix.com>
Subject: Problem configuring alsa-lib for cross-compilation
Date: Fri, 08 Oct 2010 13:00:16 +0200
Message-ID: <4CAEF9C0.5000509@mobotix.com>
Reply-To: simon.brenner@mobotix.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smail.mobotixserver.de (smail.mobotixserver.de [213.183.84.167])
	by alsa0.perex.cz (Postfix) with ESMTP id D5AA42433C
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Oct 2010 13:00:16 +0200 (CEST)
Received: from mobotix.com (localhost [127.0.0.1])
	by smail.mobotixserver.de (Postfix) with ESMTP id 53370783
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Oct 2010 13:00:16 +0200 (CEST)
Received: from [192.168.24.20] ([192.168.24.20] verified)
	by mobotix.com (CommuniGate Pro SMTP 5.3.7)
	with ESMTP id 10725275 for alsa-devel@alsa-project.org;
	Fri, 08 Oct 2010 13:00:16 +0200
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

Hi,

I'm building and installing the alsa libs for an embedded system.
My current process runs as follows:

 1) the alsa-lib package is crosscompiled on my PC host system (x86);
 2) the alsa-lib package is installed on a special prefix (say '/tmp/dest') on the host system;
 3) some installed files are copied from the dir. '/tmp/dest' to the final target root filesystem
   tree (say '/tmp/emb_root');

Now there are a couple of details that do not work with this process:

in point 1) I configure the alsa-lib package with the option --prefix=/tmp/dest because I want
to install the package there and use it later to compile other packages against it (alsa-utils for
example); at the same time I want also to use the alsa libs in my target system but it is not
possible because, at runtime, the init functions in the libasound.so looks for its configuration
file under '/tmp/dest/share/alsa/alsa.conf'!
The same problem happens with the plugins dir.

I tracked back this problems to the fact that, in the configure.in, the variable ALSA_CONFIG_DIR is
used both to be substituted in the Makefile.am's (AC_SUBST(ALSA_CONFIG_DIR)) and to define the
preprocessor constant in the 'include/config.h' (C_DEFINE_UNQUOTED(ALSA_CONFIG_DIR,...)). There is
currently no way to have two independent values for the two cases.

My current 'best' solution is to patch the header 'include/config.h' after running the configure script.

Is there any standard solution to this without patching the configure results ?

Regards,
-Simon.
