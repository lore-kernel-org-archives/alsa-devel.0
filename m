From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: ac97 Master and PCM volume control
Date: Sat, 12 Jun 2010 09:37:45 +0800
Message-ID: <AANLkTinXIaneJsawemC1denpwFsmKdlo4G8wSZ531cWl@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 486F32456D
	for <alsa-devel@alsa-project.org>;
	Sat, 12 Jun 2010 03:37:46 +0200 (CEST)
Received: by vws6 with SMTP id 6so1883083vws.38
	for <alsa-devel@alsa-project.org>; Fri, 11 Jun 2010 18:37:45 -0700 (PDT)
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

https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/581650


>> Master ranges from -46.5dB to 0dB but PCM ranges from -34.5dB to +12dB,

Daniel T Chen <https://launchpad.net/%7Ecrimsun> wrote on 2010-05-18:
#1<https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/581650/comments/1>
 This is not a pulse bug but a hardware one

I wonder why you said this is a hardware bug since this is ac97
specification

maximum the total gain will be +12dB, not 0dB as indicated.

Did you read those ac97 2.x specification ?
