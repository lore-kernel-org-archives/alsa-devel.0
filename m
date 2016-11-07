From: Tanu Kaskinen <tanuk@iki.fi>
Subject: How to package the smixer modules?
Date: Mon, 07 Nov 2016 14:43:49 +0200
Message-ID: <1478522629.1939.3.camel@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id A2A18265D2B
 for <alsa-devel@alsa-project.org>; Mon,  7 Nov 2016 13:43:56 +0100 (CET)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 06FDF2088C
 for <alsa-devel@alsa-project.org>; Mon,  7 Nov 2016 07:43:54 -0500 (EST)
Received: from laptop (a88-113-211-72.elisa-laajakaista.fi [88.113.211.72])
 by mail.messagingengine.com (Postfix) with ESMTPA id B9CD8CC02A
 for <alsa-devel@alsa-project.org>; Mon,  7 Nov 2016 07:43:51 -0500 (EST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi all!

What do the smixer modules do? I mean these files:

/usr/lib/alsa-lib/smixer/smixer-ac97.so
/usr/lib/alsa-lib/smixer/smixer-hda.so
/usr/lib/alsa-lib/smixer/smixer-sbase.so

Should they always be shipped along with the main libasound library? I
maintain the alsa-lib package in OpenEmbedded, and currently
OpenEmbedded has separate packages for libasound and the smixer
modules, and I wonder if that's a good idea. It looks like the smixer
modules don't get installed by default when libasound is installed.
Debian, in contrast, ships the smixer modules in the libasound package.

After studying the source code a bit, it seems that the smixer modules
are dynamically loaded by the "simple mixer" interface of libasound.
I'm not familiar with the purpose of that interface. I don't know if
there are many applications that use that interface, and I don't know
if those applications that do use it suffer badly if the smixer modules
aren't installed.

-- 
Tanu

https://www.patreon.com/tanuk
