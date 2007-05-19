From: Andrew Callan <acallan.alsa@ugnet.org>
Subject: Re: Alsa 1.0.13 (and others) does not work on ALC880
Date: Sat, 19 May 2007 02:08:14 -0500 (CDT)
Message-ID: <Pine.LNX.4.58.0705190144230.8331@integrity.ugnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from integrity.ugnet.org (integrity.ugnet.org [208.251.149.193])
	by alsa0.perex.cz (Postfix) with ESMTP id 73C4C24475
	for <alsa-devel@alsa-project.org>;
	Sat, 19 May 2007 08:08:47 +0200 (CEST)
Received: from integrity.ugnet.org (localhost [127.0.0.1])
	by integrity.ugnet.org (8.12.11.20060308/8.12.10) with ESMTP id
	l4J78EP0009056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Sat, 19 May 2007 02:08:34 -0500
Received: from localhost (acc@localhost)
	by integrity.ugnet.org (8.12.11.20060308/8.12.6/Submit) with ESMTP id
	l4J78E2A009053
	for <alsa-devel@alsa-project.org>; Sat, 19 May 2007 02:08:14 -0500
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

I have been without sound using Fedora Core ever since the 2.6.16 or
2.6.17 kernel update (2.6.16 crashed during initialization, so I could not
tell whether sound worked or not).  It had worked well through the 2.6.15
Fedora kernels.  I finally sat down tonight to work the problem as hard as
I could and happened upon Eric and Tobin's timely exchange.

First, simply adding probe_mask=1 to the snd-hda-intel options worked for
me as well; I did not end up having to specify a specific model.

Second, I too was seeing a LONG hang when trying to do:
cat /proc/asound/card0/codec#0
but now with the probe_mask=1, I do not see this.

If it helps, the alsa-info.sh output for my system is at
http://pastebin.ca/496293
If it makes any difference, I'm not sure which model I had specified on
the modprobe line at the time I captured this output.

One thing I do notice is that after adding probe_mask=1, aplay -l does not
show the Si3054 Modem which shows up in the alsa-info output.

Thanks for the help you gave in the thread with Eric.

Andrew
