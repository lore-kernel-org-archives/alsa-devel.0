From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: via82xx: how to get microphone working?
Date: Mon, 14 Apr 2008 12:56:26 +0200
Message-ID: <4803385A.4020509@ladisch.de>
References: <4802FFD0.1000302@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 02D9324483
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Apr 2008 12:56:31 +0200 (CEST)
In-Reply-To: <4802FFD0.1000302@freemail.hu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-2?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

N=E9meth M=E1rton wrote:
> I enabled the microphone input, increased the microphone record level
> to maximum, and enabled "Mic Boost". I can hear my voice through the
> speakers, but I cannot record sound.

This looks as if you've set the playback level and not the record level
of the microphone.  In alsamixer, use F3/F4 to switch between playback
and record controls.


HTH
Clemens
