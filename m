From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: wrong decibel data?
Date: Sun, 11 Apr 2010 07:32:17 +0800
Message-ID: <q2q4f3252891004101632h5b3d7b1cmf937b9dfc5b6c9da@mail.gmail.com>
References: <q2s98391a7b1004021121sde36d074m8a70acc142f95d93@mail.gmail.com>
	<q2l4f3252891004071905l553da6a0he8b53448524fc94d@mail.gmail.com>
	<z2s98391a7b1004080542ud4af307l992ac9636d9aa508@mail.gmail.com>
	<u2w4f3252891004081611tc0293e7fzb6312ca188eacdc1@mail.gmail.com>
	<s2l98391a7b1004090030vd55faadew6ae97c85a7a4b379@mail.gmail.com>
	<r2u4f3252891004090649p3f327273x3af60905a06045fe@mail.gmail.com>
	<r2o98391a7b1004090659s3493aa86gb47819d4f2e9c742@mail.gmail.com>
	<h2i98391a7b1004091135u5519f86w31e7d85ed83e2f67@mail.gmail.com>
	<h2r4f3252891004100227q1eca2166z280ebcf3f7a122e0@mail.gmail.com>
	<g2g98391a7b1004100241h978b490an26ef2c549aa78eb0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id CBF16103809
	for <alsa-devel@alsa-project.org>;
	Sun, 11 Apr 2010 01:32:18 +0200 (CEST)
Received: by pwj8 with SMTP id 8so2530118pwj.38
	for <alsa-devel@alsa-project.org>; Sat, 10 Apr 2010 16:32:17 -0700 (PDT)
In-Reply-To: <g2g98391a7b1004100241h978b490an26ef2c549aa78eb0@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/4/10 Nicolo' Chieffo <nicolo.chieffo@gmail.com>

> On Sat, Apr 10, 2010 at 11:27 AM, Raymond Yau
> <superquad.vortex2@gmail.com> wrote:
> > the point is that PA developer think the dB range of the pulseaudio
> master
> > volume control is -inf dB to 0dB
>
> The range is 200 dB, since they use that value as -inf.
> Can you suggest something to tell to the pulseaudio developers?
>

As your reported bug is "pulseaudio master volume is scaled differently as
alsa master"

the answer is because "pulseaudio master volume" has a different dB ranage
from the alsa master volume control
