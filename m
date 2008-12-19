From: "vasudha rao" <vasudha.jrao@gmail.com>
Subject: arecord working now..
Date: Fri, 19 Dec 2008 19:14:19 +0530
Message-ID: <eeb9eca50812190544q52b3ee2cua347faa7cb3134a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ik-out-1112.google.com (ik-out-1112.google.com [66.249.90.176])
	by alsa0.perex.cz (Postfix) with ESMTP id A4ABD243E9
	for <alsa-devel@alsa-project.org>; Fri, 19 Dec 2008 14:44:20 +0100 (CET)
Received: by ik-out-1112.google.com with SMTP id c28so240421ika.0
	for <alsa-devel@alsa-project.org>; Fri, 19 Dec 2008 05:44:19 -0800 (PST)
Content-Disposition: inline
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

Hi..

I am able to record now..

I used arecord like,

$arecord -d 10 -f cd -t wav -D copy foobar.wav

and I play like,

$aplay -D hw:0,0 foobar.wav

All works fine..:-)

But the thing is I dont know why it was not working and why it is working
now..??

Please tel me if u found it why??and if time permits for u..

Thank you ..
