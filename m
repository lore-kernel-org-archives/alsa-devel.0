From: "Michael Bourgeous" <sts.nitrogen@gmail.com>
Subject: Swap channel order in interleaved audio
Date: Fri, 14 Sep 2007 18:14:44 -0600
Message-ID: <8e4fc8270709141714x405af594jb5e3b1d2553e5318@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.190])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F68F2454F
	for <alsa-devel@alsa-project.org>;
	Sat, 15 Sep 2007 02:14:45 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id f40so922894fka
	for <alsa-devel@alsa-project.org>; Fri, 14 Sep 2007 17:14:45 -0700 (PDT)
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
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I'm working on an ALSA driver for the TL880 (myhd.sf.net), and I can't
figure out how to indicate in my driver that the right channel comes
first.  Unfortunately there doesn't seem to be a way for me to change
that in the card, and I haven't found a channel order setting in the
headers.  So, is it possible to tell ALSA to swap the channel order of
the data it gives to my driver?

Thanks,
Mike Bourgeous
