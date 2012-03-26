From: =?ISO-8859-1?B?ROFtYXNvIEzzcGV6?= <dlopezsk@gmail.com>
Subject: How to cross compile the alsa ?
Date: Mon, 26 Mar 2012 17:15:26 +0200
Message-ID: <CAC-Zu+6S4WNnqBf1fjbHAQnXwSOEOPQ4UQGBmd15jsZCvL_UHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B74424A6E
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Mar 2012 17:13:53 +0200 (CEST)
Received: by qcha6 with SMTP id a6so3352562qch.38
	for <alsa-devel@alsa-project.org>; Mon, 26 Mar 2012 08:15:26 -0700 (PDT)
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

Hi all,

I need you help not to understant how cross compile alsa with
arm-gp2x-linux. I downloaded alsa-lib-1.0.17 and alsa-utils-1.0.17
last week

Step to step, because I don't know if I will forget any step.

Once I descrompressed in /home/dam:

tar -xvfj alsa-lib-1.0.17.tar.bz2
tar -xvfj alsa-utils-1.0.17.tar.bz2

Then to descompress I went to directory alsa-lib... and I put in
directory, the next line:

# CC=arm-gp2x-linux ./configure --host=i686.linux --target=arm-linux
#make
#make install

When it finish I copy all include from alsa-lib-1.0.17 in my directory
/usr/arm-gp2x-linux/include.

After I did:

#arm-gp2x-linux -o micro micro.c -lasound

But it say that can't find -lasound and ld returned 1 exit status.
What I did bad do? Can you put step to step, please?
