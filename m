From: Christopher Arndt <chris.arndt@web.de>
Subject: Re: pyalsa: SeqEvent.time strangeness
Date: Mon, 03 Aug 2009 14:21:54 +0200
Message-ID: <4A76D662.9030002@web.de>
References: <4A607468.7010300@web.de>	<4A65C370.3030205@ladisch.de>	<4A65EADE.70007@web.de>	<4A733753.60808@web.de>
	<4A76D01F.1090603@ladisch.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050400010701050109050500"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fmmailgate01.web.de (fmmailgate01.web.de [217.72.192.221])
	by alsa0.perex.cz (Postfix) with ESMTP id 574FB245C3
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Aug 2009 14:22:48 +0200 (CEST)
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 997F510F80893
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Aug 2009 14:21:41 +0200 (CEST)
Received: from [84.44.236.118] (helo=minimax.paddyland.lan)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277) id 1MXwXt-0007hB-00
	for alsa-devel@alsa-project.org; Mon, 03 Aug 2009 14:21:41 +0200
In-Reply-To: <4A76D01F.1090603@ladisch.de>
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

This is a multi-part message in MIME format.
--------------050400010701050109050500
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Clemens Ladisch schrieb:
> Christopher Arndt wrote:
>> I've tested this now and encountered a very strange bevahior of the
>> event time set by the queue:
> 
> Apparently, you are the first one who tried to use this.  Fixed now:
> http://git.alsa-project.org/?p=alsa-python.git;a=commitdiff;h=9a7dea33dddeb2d9d7693257323d43ccffbffed2

Excelllent! The test script now produces correct results.
Thanks for the fix!

Might I suggest another patch to pyalsa? This would allow to use
developers to use "python setup.py develop" to install their git version
as a Python egg-link and makes it much easier to use pyalasa with
virtual Python environments.


Chris

--------------050400010701050109050500
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="setuptools.diff"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="setuptools.diff"

ZGlmZiAtLWdpdCBhL3NldHVwLnB5IGIvc2V0dXAucHkKaW5kZXggZmE3ZjJkNi4uYzJiNjM4
OSAxMDA3NTUKLS0tIGEvc2V0dXAucHkKKysrIGIvc2V0dXAucHkKQEAgLTMsNyArMywxMCBA
QAogCiBpbXBvcnQgb3MKIGltcG9ydCBzeXMKLWZyb20gZGlzdHV0aWxzLmNvcmUgaW1wb3J0
IHNldHVwLCBFeHRlbnNpb24KK3RyeToKKyAgICBmcm9tIHNldHVwdG9vbHMgaW1wb3J0IHNl
dHVwLCBFeHRlbnNpb24KK2V4Y2VwdCBJbXBvcnRFcnJvcjoKKyAgICBmcm9tIGRpc3R1dGls
cy5jb3JlIGltcG9ydCBzZXR1cCwgRXh0ZW5zaW9uCiAKIFZFUlNJT049JzEuMC4yMCcKIAo=
--------------050400010701050109050500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------050400010701050109050500--
