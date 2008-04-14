From: =?ISO-8859-2?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Subject: Re: via82xx: how to get microphone working?
Date: Mon, 14 Apr 2008 21:31:48 +0200
Message-ID: <4803B124.10403@freemail.hu>
References: <4802FFD0.1000302@freemail.hu> <4803385A.4020509@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail02a.mail.t-online.hu (mail02a.mail.t-online.hu [84.2.40.7])
	by alsa0.perex.cz (Postfix) with ESMTP id 11C13245E1
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Apr 2008 21:31:51 +0200 (CEST)
In-Reply-To: <4803385A.4020509@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> N=E9meth M=E1rton wrote:
>> I enabled the microphone input, increased the microphone record level
>> to maximum, and enabled "Mic Boost". I can hear my voice through the
>> speakers, but I cannot record sound.
> =

> This looks as if you've set the playback level and not the record level
> of the microphone.  In alsamixer, use F3/F4 to switch between playback
> and record controls.

Thanks a lot, that was the solution.

In alsamixer I pressed F4 to reach the "[Capture]" settings. At "Mic" the r=
ed
"CAPTUR" text was there. What was missing is that at "Capture" the red "CAP=
TUR"
text was not there. I had to navigate to "Capture" and press the SPACE bar.=
 I
also had to increase the level of "Capture" with the up/down arrows.

What I recognised that in KMix 2.6.1 (KDE 3.5.8) there is a "Capture" level
adjuster, but its level is not connected with the "Capture" level in AlsaMi=
xer
v1.0.16. But maybe that's a KMix problem.

Thanks again,

	M=E1rton N=E9meth
