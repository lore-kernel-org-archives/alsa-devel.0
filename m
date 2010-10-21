From: Adam Rosenberg <adam@alcorn.com>
Subject: Constraining the number of frames per period
Date: Thu, 21 Oct 2010 10:43:49 -0400
Message-ID: <AANLkTi=v2DKXfptubtwEPfH_4eZJ-vwLqVHAkmf3iE2D@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 0A26B1038A7
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Oct 2010 16:44:12 +0200 (CEST)
Received: by wyb32 with SMTP id 32so5457241wyb.38
	for <alsa-devel@alsa-project.org>; Thu, 21 Oct 2010 07:44:11 -0700 (PDT)
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

I would like to make sure that all programs that use the sound driver
I wrote are required to use 512 frames per period.=A0 Is there a
snd_pcm_hw_constraint function that will allow me to do this?  If not,
is this possible another way?

Thanks,
Adam

Adam Rosenberg
Software Engineer

Alcorn McBride Inc.
3300 South Hiawassee
Building 105
Orlando, FL 32835

(407) 296 - 5800 ext. 5490
