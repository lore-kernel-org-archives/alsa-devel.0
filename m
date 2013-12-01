From: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Subject: Why does `aplay -L' not show PCM's defined in
	~/.asoundrc ?
Date: Sun, 01 Dec 2013 11:45:10 -0800
Message-ID: <529B91C6.8070302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f47.google.com (mail-pb0-f47.google.com
 [209.85.160.47])
 by alsa0.perex.cz (Postfix) with ESMTP id DB3BF2608EA
 for <alsa-devel@alsa-project.org>; Sun,  1 Dec 2013 20:45:19 +0100 (CET)
Received: by mail-pb0-f47.google.com with SMTP id um1so17355570pbc.20
 for <alsa-devel@alsa-project.org>; Sun, 01 Dec 2013 11:45:18 -0800 (PST)
Received: from localhost.localdomain (c-24-6-80-191.hsd1.ca.comcast.net.
 [24.6.80.191])
 by mx.google.com with ESMTPSA id og5sm75537257pbb.10.2013.12.01.11.45.17
 for <alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Sun, 01 Dec 2013 11:45:17 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Hi guys,

Why does `aplay -L' not list PCM's that are defined in ~/.asoundrc (i.e. 
PCM's implemented by plugins)?

How do you get a listing that includes these?

I was helping a user today who needed to set up a device using the 
`multi' plugin -- and the fact that the new virtual pcm device didn't 
show up in any standard listing made things very confusing.

-gabriel
