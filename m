From: Paulo Silva <paulo.jnkml@gmail.com>
Subject: jack-sense where is it?
Date: Sun, 16 Jan 2011 02:32:53 +0900
Message-ID: <AANLkTikhy-mRzUJbyJBV2YzFvrQyvyd5_QWzh88+kVZ+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id AD20F24359
	for <alsa-devel@alsa-project.org>; Sat, 15 Jan 2011 18:35:27 +0100 (CET)
Received: by wyi11 with SMTP id 11so3883047wyi.38
	for <alsa-devel@alsa-project.org>; Sat, 15 Jan 2011 09:35:27 -0800 (PST)
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

Hi, I'm not sure if this is the right place to post this, so forgive me if
I'm making a mistake.

I'm trying to find where in the source of alsa kernel modules is the part
that enumerates the jacks (outputs) of the sound card.

This is because I have two headphone jacks and since I upgraded to 2.6.26,
when I plug anything to the 2nd headphone the first gets muted.

I think this is a jack sensing related bug, since the 1st jack is enumerated
as "Front" and the 2nd as "Headphone" when in reality they are both
"Headphone" 1 and 2.

If someone can give me a hint to where the code related with the enumeration
of the jack sensing is located, then I could make some tests myself. I just
want to save some work searching for it.

Regards,
paulo
