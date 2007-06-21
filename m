From: "Paul Kavan" <pkavan@gmail.com>
Subject: Re: Help with SoC alsa.conf
Date: Thu, 21 Jun 2007 12:10:56 -0500
Message-ID: <61c0054e0706211010t3de67c0ew806c6b95267b0579@mail.gmail.com>
References: <61c0054e0706210820g17f90888qed3d9548d46ec1f6@mail.gmail.com>
	<61c0054e0706210836r131c3335o9af39df5b6638eae@mail.gmail.com>
	<61c0054e0706210923v61503317t9c2fa67cdb969c46@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by alsa0.perex.cz (Postfix) with ESMTP id BCED9103843
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Jun 2007 19:10:57 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id o2so613373uge
	for <alsa-devel@alsa-project.org>; Thu, 21 Jun 2007 10:10:57 -0700 (PDT)
In-Reply-To: <61c0054e0706210923v61503317t9c2fa67cdb969c46@mail.gmail.com>
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

Some further looking has uncovered some strange behavior on the record side.
When I use

arecord -d5 -fS8 -r8000 -traw test.raw

and then look at the data and clock lines, I see that the pcm is not
functioning as designed. aplay works as advertised.

The frame sync line is at ground before the record, during the record it
cycles between 3.3 and 2.8 V with a rough square pattern at the bitclock
rate of 256k. Not sure if this is hw or sw...will continue to invesigate.

Paul

***************************************
Paul David Kavan
Project Engineer
GRH Electronics, Inc.
402-734-4900
pkavan@gmail.com
***************************************
