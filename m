From: Mark Goldstein <goldstein.mark@gmail.com>
Subject: Re: [PATCH 1/16] ALSA: VIA HDA - suggesting additional
	patch
Date: Mon, 21 Mar 2011 21:37:24 +0200
Message-ID: <AANLkTinFk4k-fKDhT6P044Cup2qXRL6PyxT6s=fihMwp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015174be950fa167e049f0342f4
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 12C8224159
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 20:37:45 +0100 (CET)
Received: by eyg5 with SMTP id 5so1411634eyg.38
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 12:37:44 -0700 (PDT)
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
Cc: Takashi Iwai <tiwai@suse.de>, Lydia Wang <lydiawang@viatech.com.cn>
List-Id: alsa-devel@alsa-project.org

--0015174be950fa167e049f0342f4
Content-Type: text/plain; charset=ISO-8859-1

Hello,

I do not want to hijack the thread, but since it looks like many
changes are going to be applied to VIA HDA, I'd like to ask you to
look into potential patch that fixed my problem with VIA VT1708S.

There was a long thread "Problem with VIA VT1708S and git versions of
alsa-driver" on this list. I'll give a brief summary:
I have ASUS P5QL/EPU motherboard with VIA VT1708S on-board audio.  My
distribution is openSUSE.
The sound worked satisfactory with alsa driver 1.0.23. The problem
occurred first in oS 11.1.
After one of the updates from git snapshot repo (end of September /
beginning of October 2010), the functionality of controls got messed
up: Line control did not work, Front Mic control actually changed the
volume of Line In. Front Mic itself did not work at all.

I tried to figure out what happened with the help of Raymond Yau, but
at some stage gave up and reverted to working driver 1.0.23.

Later this year I had to try git version again (because I've got new
USB device). Still the same problem. So I decided to compare
patch_via.c from 1.0.23 that worked and from git version (and now
1.0.24) that did not. It turned out that the cause of my problem was
in the patch (identified by Raimond)
http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=f3268512c3a5dea587cfe875b8bca98d9e164cd9;hp=73413b120d5d6eb6c98451bbc19acf43e0e300ae

This patch introduced common function vt_auto_create_analog_input_ctls
and codec-specific functions passing the array pin_idxs to it.

The problem, as I understood it, is that
vt_auto_create_analog_input_ctls uses the same pin index in calls to
via_new_analog_input and snd_hda_add_imux_item, while in the old code
(1.0.23) for some codecs, including  VT1708S, VT1702 and VT1716S,
via_new_analog_input was called with pin index + 1.

I do not understand the details, so I just did straightforward patch
(attached here, based on the code of 1.0.24) to restore the old
behavior. In my case this patch resolved the problem and I have
working controls now.

Could you please check it? Maybe it should be done differently, but
the problem is real (at least for me) and needs a fix.

Regards,
-- 
Mark Goldstein

--0015174be950fa167e049f0342f4
Content-Type: text/x-patch; charset=US-ASCII; name="patch_via.c.diff"
Content-Disposition: attachment; filename="patch_via.c.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gljs4nnp0

MjQxNGMyNDE0CjwgCQkJCQkgICAgaGRhX25pZF90IHBpbl9pZHhzW10sIGludCBudW1faWR4cykK
LS0tCj4gCQkJCQkgICAgaGRhX25pZF90IHBpbl9pZHhzW10sIGludCBudW1faWR4cywgaW50IGlk
eF9vZmZzKQoyNDQxYzI0NDEKPCAJCWVyciA9IHZpYV9uZXdfYW5hbG9nX2lucHV0KHNwZWMsIGxh
YmVsLCB0eXBlX2lkeCwgaWR4LCBjYXBfbmlkKTsKLS0tCj4gCQllcnIgPSB2aWFfbmV3X2FuYWxv
Z19pbnB1dChzcGVjLCBsYWJlbCwgdHlwZV9pZHgsIGlkeCArIGlkeF9vZmZzLCBjYXBfbmlkKTsK
MjQ1NWMyNDU1CjwgCQkJCQkJQVJSQVlfU0laRShwaW5faWR4cykpOwotLS0KPiAJCQkJCQlBUlJB
WV9TSVpFKHBpbl9pZHhzKSwgMCk7CjMwMjhjMzAyOAo8IAkJCQkJCUFSUkFZX1NJWkUocGluX2lk
eHMpKTsKLS0tCj4gCQkJCQkJQVJSQVlfU0laRShwaW5faWR4cyksIDApOwozNTYwYzM1NjAKPCAJ
CQkJCQlBUlJBWV9TSVpFKHBpbl9pZHhzKSk7Ci0tLQo+IAkJCQkJCUFSUkFZX1NJWkUocGluX2lk
eHMpLCAwKTsKMzk5OGMzOTk4CjwgCQkJCQkJQVJSQVlfU0laRShwaW5faWR4cykpOwotLS0KPiAJ
CQkJCQlBUlJBWV9TSVpFKHBpbl9pZHhzKSwgMSk7CjQzNDljNDM0OQo8IAkJCQkJCUFSUkFZX1NJ
WkUocGluX2lkeHMpKTsKLS0tCj4gCQkJCQkJQVJSQVlfU0laRShwaW5faWR4cyksIDEpOwo0NzM2
YzQ3MzYKPCAJCQkJCQlBUlJBWV9TSVpFKHBpbl9pZHhzKSk7Ci0tLQo+IAkJCQkJCUFSUkFZX1NJ
WkUocGluX2lkeHMpLCAwKTsKNTIwMGM1MjAwCjwgCQkJCQkJQVJSQVlfU0laRShwaW5faWR4cykp
OwotLS0KPiAJCQkJCQlBUlJBWV9TSVpFKHBpbl9pZHhzKSwgMSk7CjU1MTNjNTUxMwo8IAkJCQkJ
ICAgICAgIEFSUkFZX1NJWkUocGluX2lkeHMpKTsKLS0tCj4gCQkJCQkgICAgICAgQVJSQVlfU0la
RShwaW5faWR4cyksIDApOwo1ODM0YzU4MzQKPCAJCQkJCSAgICAgICBBUlJBWV9TSVpFKHBpbl9p
ZHhzKSk7Ci0tLQo+IAkJCQkJICAgICAgIEFSUkFZX1NJWkUocGluX2lkeHMpLCAwKTsK
--0015174be950fa167e049f0342f4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0015174be950fa167e049f0342f4--
