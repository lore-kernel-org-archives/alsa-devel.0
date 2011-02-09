From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: list *all* PCMs
Date: Wed, 09 Feb 2011 11:14:08 +0100
Message-ID: <4D5268F0.9030201@canonical.com>
References: <AANLkTikfPkpxshmJRVd_iHdNNddrM7LOT0cn+oTLGgtX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020505060800010103020501"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id B2679103873
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2011 11:14:10 +0100 (CET)
In-Reply-To: <AANLkTikfPkpxshmJRVd_iHdNNddrM7LOT0cn+oTLGgtX@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Aleksandar Kostadinov <akostadinov@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020505060800010103020501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 2011-02-08 20:25, Aleksandar Kostadinov wrote:
> Hello,
>
> I searched through the list archive and I can't find a way to list all
> PCM devices. aplay/arecord -L show only these that have hint show on.
> Is there such command that lists all PCMs?

The hw: and plughw: devices do not show up by default, which is why 
Ubuntu has a distro patch that turns them on. I'm attaching that patch.

> While on it, it is also hard to obtain a list of capabilities of a
> device. For example I don't see a way user can obtain the supported
> sample rates by a sound device. I have found a program (see it
> attached to http://www.spinics.net/linux/fedora/alsa-user/msg07230.html)
> that seems to work fine. Could that program or similar functionality
> be implemented in arecord/aplay so user can easily check device
> capabilities?
>
> Thank you,
> Aleksandar
>
> P.S. please cc me in replies because I'm not a subscriber

P.S. please subscribe, so we don't have to cc you. ;-)

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------020505060800010103020501
Content-Type: text/x-patch;
 name="lp652035-use-extended-namehints.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="lp652035-use-extended-namehints.patch"

Index: alsa-lib-1.0.23/src/conf/alsa.conf
===================================================================
--- alsa-lib-1.0.23.orig/src/conf/alsa.conf	2010-10-03 15:05:47.000000000 -0400
+++ alsa-lib-1.0.23/src/conf/alsa.conf	2010-10-03 15:09:27.000000000 -0400
@@ -54,11 +54,11 @@
 #
 
 # show all name hints also for definitions without hint {} section
-defaults.namehint.showall off
+defaults.namehint.showall on
 # show just basic name hints
 defaults.namehint.basic on
 # show extended name hints
-defaults.namehint.extended off
+defaults.namehint.extended on
 #
 defaults.ctl.card 0
 defaults.pcm.card 0

--------------020505060800010103020501
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------020505060800010103020501--
