From: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>
Subject: LV2-C++-Tools
Date: Sat, 24 Mar 2012 14:34:54 +0000
Message-ID: <CAE-xCyPee5QGroQNWqMeOf07JwOetZTm4VRBoiryqqW7uZQqXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B8AF224380
	for <alsa-devel@alsa-project.org>; Sat, 24 Mar 2012 15:33:20 +0100 (CET)
Received: by vcbf11 with SMTP id f11so3860069vcb.38
	for <alsa-devel@alsa-project.org>; Sat, 24 Mar 2012 07:34:55 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Robillard <d@drobilla.net>, alsa-devel@alsa-project.org, devel@lists.lv2plug.in, lars.luthman@gmail.com
List-Id: alsa-devel@alsa-project.org

Hello,

I have been coding the porting of the AMS internal modules to LV2
plugins using the Lv2-C++-Tools.

The more I'm progressing, the more I am wondering if there are any
limitations involved in using this library, especially these days
where a lot of new features are being added to the Lv2 Extensions.

For example, I am coding a plugin that output the position of the
mouse cursor as two control ports (handy to develop a kind of theremin
synth).
Getting the cursor position from the X Library is an expensive
operation, and the new Worker Extension seems perfect for the job, but
I can't figure out if somehow it is compatible or not with the
Lv2-C++-Tools.

The most obvious pros of using Lv2-C++-Tools is its simplicity.
Porting an AMS module takes only 20 to 30 minutes with it, while doing
it without the help of the library takes much more time and is way
more tedious.
(I am much more confortable coding in C++ than C, but the question
deserves to be asked, am I doing something wrong here that I find it
way more difficult to code without the help of Lv2-C++-Tools?)

So I am putting the question to the community: what path you would you
advise to follow? With or Without Lv2-C++-Tools?

Aur=E9lien
