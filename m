From: =?windows-1252?Q?Ren=E9_Rebe?= <rene@exactcode.de>
Subject: [RFC] hda/realtek filtered headphone output
Date: Sun, 4 Mar 2018 16:05:44 +0100
Message-ID: <52CB25E0-9FF0-4383-BE2A-F31488B5B1A8@exactcode.de>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.exactcode.de (mx.exactcode.de [144.76.154.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 07514267016
 for <alsa-devel@alsa-project.org>; Sun,  4 Mar 2018 16:05:55 +0100 (CET)
Received: from exactco.de ([90.187.5.221])
 by mx.exactcode.de with esmtp (Exim 4.82)
 (envelope-from <rene@exactcode.de>) id 1esVDZ-000739-8V
 for alsa-devel@alsa-project.org; Sun, 04 Mar 2018 15:06:29 +0000
Received: from [192.168.2.174] (helo=[192.168.2.174])
 by exactco.de with esmtpsa (TLSv1:AES128-SHA:128) (Exim 4.54)
 id 1esUC1-0005eC-7m
 for alsa-devel@alsa-project.org; Sun, 04 Mar 2018 14:00:59 +0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

testing some new laptops, I noticed the headphone frequency response was la=
cking
bass. First I noticed this in the Lenovo T470s, and later I found this also=
 be the case
on Surface Pro 2 and 3. The Dell XPS13 may also be affected, but I had to r=
eturn it
before I found out the solution on the other machines:

	https://www.youtube.com/watch?v=3Da1YkPtfC4LI

I had not yet sent the patch because a) I was too busy and b) I wanted to r=
eview this further.

As the other day I got a Lenovo ideapad 720s to test with exactly the same =
issue, here is the
current hacked patch:

	https://svn.exactcode.de/t2/trunk/package/base/linux/surface-audio.patch

However, given that all newer realtek codecs that came on my desk are affec=
ted,
maybe there is something wrong with the hda_auto_parser.c - I did not yet f=
ully grasp
all the logic of that.

As you can see in the patch and video (=85) the problem is the signal routi=
ng of NID 0x15
or 0x21 (depending whether it is an older, or newer codec). This is the hea=
dphone out,
and as far as I can see the auto_parser assigned the index 0 pcm output (NI=
D 0x0c)
which result in this filtered frequency response, likely intended for the l=
aptop=92s speakers?
Using the next NID (I guess that was 0xd?) results in a full frequency resp=
onse and at
least to my ears is immediately hearable and obvious.

Without this fixed routing the headphone sounds like a PC speaker in a coke=
 can.

So the question for the authors and HDA experts: Can this be fixed in the a=
uto_parser,
or is my patch (which btw. has to small unrelated cleanups) modulo potentia=
lly some
renaming of the enum and function, now that more than the Surface is affect=
ed, the
way to go? If this can be fixed more generally I would be happy to hear!

Greetings from Berlin,
	Ren=E9 Rebe

-- =

ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
http://exactcode.com | http://exactscan.com | http://ocrkit.com | http://t2=
-project.org | http://rene.rebe.de
