From: "Paul Kavan" <pkavan@gmail.com>
Subject: Re: Help with SoC alsa.conf
Date: Thu, 21 Jun 2007 11:23:23 -0500
Message-ID: <61c0054e0706210923v61503317t9c2fa67cdb969c46@mail.gmail.com>
References: <61c0054e0706210820g17f90888qed3d9548d46ec1f6@mail.gmail.com>
	<61c0054e0706210836r131c3335o9af39df5b6638eae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by alsa0.perex.cz (Postfix) with ESMTP id 89EA9103843
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Jun 2007 18:23:24 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id o2so603930uge
	for <alsa-devel@alsa-project.org>; Thu, 21 Jun 2007 09:23:24 -0700 (PDT)
In-Reply-To: <61c0054e0706210836r131c3335o9af39df5b6638eae@mail.gmail.com>
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

Some more progress to report. I created a raw file from data recommended in
the data sheet for my codec to produce 0dBm0 output for u-law. Essentially,
I created 80k samples of the repeating pattern:

{0x1E, 0x0B, 0x0B, 0x1E, 0x9E, 0x8B, 0x8B, 0x9E}

which according to the datasheet should produce a 1020 Hz sine wave at
2.2V,pp. Both the bare bones and default
alsa.conf files do this. So, this gives me confidence that my machine/codec
driver works as desired. So, I think it is simply a matter of getting my
alsa.conf working.

I will keep digging and see if I can determine why it is not working, but I
am not sure what I am looking for.

Paul
-- 
***************************************
Paul David Kavan
Project Engineer
GRH Electronics, Inc.
402-734-4900
pkavan@gmail.com
***************************************
