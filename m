From: "Christian Steffen" <c-steffen@web.de>
Subject: still: clicking noise on Sigmatel 9202 - how can I use
	patches for 2.6.24 kernel on 2.6.30?
Date: Wed, 28 Oct 2009 10:53:30 +0100
Message-ID: <000301ca57b4$81a9f750$84fde5f0$@de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fmmailgate03.web.de (fmmailgate03.web.de [217.72.192.234])
	by alsa0.perex.cz (Postfix) with ESMTP id E69E3244FB
	for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2009 10:53:31 +0100 (CET)
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id C58A412BCF291
	for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2009 10:53:31 +0100 (CET)
Received: from [78.48.137.120] (helo=Crusoe)
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314) id 1N35Df-00080k-00
	for alsa-devel@alsa-project.org; Wed, 28 Oct 2009 10:53:31 +0100
Content-Language: de
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

Hello,

I still have my problem that I have a constant clicking noise coming out of
my boxes with a sigmatel 9202 sound chip on intel-hda (Poulsbo) soundcard.

I now found two patches for the alsa driver that can be applied on a 2.6.24
kernel. Those patches are exactly for the sigmatel 9202, so possibly they
would fix my problem.

http://redirectingat.com/?id=593X1004&url=http%3A%2F%2Flists.moblin.org%2Fpi
permail%2Fcommits%2F2007-December%2F001232.html
and
http://redirectingat.com/?id=593X1004&url=http%3A%2F%2Fwww.google.com%2Furl%
3Fsa%3Dt%26source%3Dweb%26ct%3Dres%26cd%3D9%26ved%3D0CDAQFjAI%26url%3Dhttp%2
53A%252F%252Fwww.soulinfo.com%252F~hugang%252Ftmp%252Fubuntu-hardy%25252Btux
onice%252Fdebian%252Fbinary-custom.d%252Flpia%252Fpatchset%252F0010-hda_sigm
atel.patch%26ei%3D4AfoSs24OpeG_Abfy7yGCA%26usg%3DAFQjCNH-mrDdDcgvhNh_eM5hy4W
hepUtUQ%26sig2%3D2fK3ED_DyaLSexlPlkFufQ

I found both patches here:
http://software.intel.com/en-us/articles/patches-for-moblin-kernel-on-menlow
/


I think these patches aren't yet completely integrated into alsa driver
1.0.21?

I tried to manually insert them into the files of my kernel 2.6.30 source
files but without any expertise this is "impossible" to me.

I think this is not the easiest job but I appreciate any help! :)

Thank you very much,

Cheers
Christian
