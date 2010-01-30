From: Klaus Schulz <kls.schlz@googlemail.com>
Subject: Some installation questions
Date: Sat, 30 Jan 2010 12:42:31 +0100
Message-ID: <d9690f191001300342ve4095cfl82e01a5b5118e1e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.145])
	by alsa0.perex.cz (Postfix) with ESMTP id A6CF52434C
	for <alsa-devel@alsa-project.org>; Sat, 30 Jan 2010 12:42:33 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 26so682599eyw.16
	for <alsa-devel@alsa-project.org>; Sat, 30 Jan 2010 03:42:33 -0800 (PST)
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

Hi there.

I am still maintaining the (inoffical) Ubuntu Alsa Upgrade Script over at
http://ubuntuforums.org/showthread.php?t=1046137


Perhaps somebody can give me a hint on some installation problems I am
running into:


1. Quite some people reporting that /proc/asound/version is still showing
the "original" revision  after running  the upgrade-script instead of
1.0.22.1.

   What could be the issue? What is setting /proc/asound/version?


2. I also introduced a kind of restore function. What it does is basically
reinstalling all the required Ubuntu packages from the repo to overwrite the
(by my script) upgraded files again.
    a. My first problem was that I was only able to get the original modules
activated when running the module assistant. ( module-assistant -f -t -q a-i
alsa-source )
       Just a re-installation of kernel packages and alsa-packages didn't
work.
    b. When redoing the Alsa Upgrade  after the restore (by my script) , I
still see in /proc/asound the old Alsa version.

    Looks again a bit like I am having slight problems with the module
handling



FYI:

Below I run after the "make install" of the driver package

The way the .ko files are handled is that they are copied to
/lib/modules/`uname -r`/kernel/sound/

#####################

cd ${ALSASRCDIR}/${DRIVER}/

find ./ -name ''*.ko'' > /tmp/alsa_modules

header "Copy modules to target directories..."
if [ "`uname -a| grep "2.6.24"`" != "" ] ; then
 tar -cv -T /tmp/alsa_modules -f /lib/modules/`uname
-r`/ubuntu/sound/alsa-driver/${DRIVER}.tar
 cd /lib/modules/`uname -r`/ubuntu/sound/alsa-driver
 else
 tar -cv -T /tmp/alsa_modules -f /lib/modules/`uname
-r`/kernel/sound/${DRIVER}.tar
 cd /lib/modules/`uname -r`/kernel/sound/
fi
#Extract new modules, overwriting old ones
tar -xvf ${DRIVER}.tar
rm *.tar

depmod -a


##############################


I obviously lack some kind of understanding how all this works.

Perhaps somebody can show me directions how to tackle the subject.


THX
\Klaus
