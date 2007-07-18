From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: ALSA driver for RealTek ALC268 chip
Date: Wed, 18 Jul 2007 13:32:51 +0930 (CST)
Message-ID: <200707180402.l6I42pr5008894@turbo.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelphi.physics.adelaide.edu.au
	(adelphi.physics.adelaide.edu.au [129.127.102.1])
	by alsa0.perex.cz (Postfix) with ESMTP id 43D8F1038F7
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Jul 2007 06:02:52 +0200 (CEST)
Received: from turbo.physics.adelaide.edu.au (IDENT:0@turbo [129.127.102.108])
	by adelphi.physics.adelaide.edu.au (8.13.7/8.13.7/UofA-Physics-1.0)
	with ESMTP id l6I42p6N006098
	for <alsa-devel@alsa-project.org>; Wed, 18 Jul 2007 13:32:51 +0930
Received: from turbo.physics.adelaide.edu.au (IDENT:7157@localhost [127.0.0.1])
	by turbo.physics.adelaide.edu.au (8.13.4/8.13.4) with ESMTP id
	l6I42pJl008895
	for <alsa-devel@alsa-project.org>; Wed, 18 Jul 2007 13:32:51 +0930
Received: (from jwoithe@localhost)
	by turbo.physics.adelaide.edu.au (8.13.4/8.13.4/Submit) id
	l6I42pr5008894
	for alsa-devel@alsa-project.org; Wed, 18 Jul 2007 13:32:51 +0930
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

Hi Amitay

Amitay Isaacs (A.Isaacs@adfa.edu.au) wrote:
> I found your names from the ALSA RealTek driver available for download
> on the realtek website. Unfortunately the driver package does not have
> support for the ALC268 chip. 
> 
> I have an ACER laptop with ALC268 HDA sound and would like to run linux
> on it. 
> 
> Is the ALC268 chip driver available yet? Even the alpha/test version?

Firstly, please submit queries like this to the ALSA development list.  While
I'm not fussed, other developers may not respond to emails sent only to
their private addresses.  It also means you don't have to guess who would be
the most appropriate person to ask.  Consequently I have added alsa-devel to
the CC of this email.

It would probably not take a lot of effort to add support for the ALC268
chip given that the ALC260 and ALC262 are supported.  Furthermore, it seems
that some work has already gone into this - see for example

  https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3104

So I would say that ALC268 support is being worked on.  Pshou can probably
give more details or provide further assistance.

Note that my involvement in the ALSA RealTek driver was limited to the
extended ALC260 support I added to take full advantage of this chip in my
laptop.  I don't have access to machines with other Realtek chips in them
and so I'm not in the best position to provide direct assistance for other
chips.

Regards
  jonathan
