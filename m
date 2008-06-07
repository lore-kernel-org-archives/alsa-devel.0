From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: ASOC PCM formats
Date: Fri, 6 Jun 2008 20:00:04 -0400
Message-ID: <9e4733910806061700r6650ded8j7c7680e4774d327d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C6B124547
	for <alsa-devel@alsa-project.org>;
	Sat,  7 Jun 2008 02:00:11 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m28so799551wag.8
	for <alsa-devel@alsa-project.org>; Fri, 06 Jun 2008 17:00:09 -0700 (PDT)
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
To: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Why is the AC97 format set to S16 in all of the drivers? The link is
20b and my codec takes 20b, how do I get 20b data to the device? I
tried using SNDRV_PCM_FORMAT_S20_3BE but all I get is static.

If I use S24 for the format it works but volume is divided by 16. I
think the bits have been right justified into the 24 bits so the
bottom four bits are lost.

AC97 link is Efika, MPC5200
Codec is STAC9766.

-- 
Jon Smirl
jonsmirl@gmail.com
