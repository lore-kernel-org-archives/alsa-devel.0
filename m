From: =?us-ascii?Q?Vaclav=20Peroutka?= <vaclavpe@seznam.cz>
Subject: repost - snd_via82xx input channels problem
Date: Sun, 24 Aug 2008 17:14:28 +0200 (CEST)
Message-ID: <3621.6574-20902-997551035-1219590868@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mxh.seznam.cz (mxh.seznam.cz [77.75.72.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 20AF524353
	for <alsa-devel@alsa-project.org>;
	Sun, 24 Aug 2008 17:14:29 +0200 (CEST)
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


thank you for your answer. Finally I found, that backporting is not so
necessary for me as I needed just three drivers - bt87x, via82xx and ice1724.
Those drivers do not use newer functions I mentioned before, so the compilation
has successfully ended.

But I noticed that even with the newset driver the alc655 line-in inputs do
not work well. Before ( alsa 1.0.9 ) I had the right channel always connected to
the Mic input. Now (Alsa 2008-08-22 ) in the right channel there is a copy of
the left channel. Thus I have monophonic input instead of stereo.

I just downloaded the datasheet of ALC655 codec. I will read it hopefully
tomorrow. But can you just advice me where to look to try to fix the problem ?
It should be somewhere in snd_via82xx module ? Or somewhere else ? Inputs in
snd_ice1724 (my second sound card) work properly. But I have never worked with
kernel modules or kernel programming. I am just interested how to fix the
problem I have.

Thank you in advance,
Vaclav
