From: Ossi Niiranen <oniiranen@neolex.fi>
Subject: Re: GPL/LGPL licensing of the Alsa library
Date: Mon, 28 Mar 2011 12:19:55 +0300
Message-ID: <3675E51D-5F88-4BB6-8F68-1E40FF054A3E@neolex.fi>
References: <5B9D7D28-C10D-42D5-9BB1-675103BC0957@neolex.fi>
	<4D904E11.8020003@ladisch.de>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6241D1038C9
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Mar 2011 11:20:00 +0200 (CEST)
Received: by eyg5 with SMTP id 5so1001984eyg.38
	for <alsa-devel@alsa-project.org>; Mon, 28 Mar 2011 02:19:56 -0700 (PDT)
In-Reply-To: <4D904E11.8020003@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thank you Clemens and Jaroslav. 

I'll compare this file list to ours and let you know if there are differences. 

One question though. Can you point me to any documentation on aserver so I could understand a bit better what it does? Googling revealed rather simple descriptions in the form of "aserver is contained in the ALSA library" and "aserver provides the ALSA library".

And point taken re the confidentiality notice;). It is included as standard in all our emails (and actually serves a purpose in some cases), but you are absolutely right that I should remember to remove it when posting to a mailing list. An omission on my part.

On Mar 28, 2011, at 12:00 PM, Clemens Ladisch wrote:

> Ossi Niiranen wrote:
>> We recently performed a licensing audit of a larger software project
>> incorporating the Alsa library 1.0.19. One issue we identified was
>> that although the Alsa library purported to state that the library was
>> licensed under the LGPL, there were still several files with third
>> party copyright holders that indicated in their header that the file
>> in question was licensed under the GPL.
> 
> $ grep -rl 'GNU General' alsa-lib/
> alsa-lib/COPYING
> alsa-lib/aserver/COPYING
> alsa-lib/aserver/aserver.c
> alsa-lib/include/sound/asequencer.h
> alsa-lib/include/sound/asound.h
> alsa-lib/include/sound/asound_fm.h
> alsa-lib/include/sound/asoundef.h
> alsa-lib/include/sound/emu10k1.h
> alsa-lib/include/sound/hdsp.h
> alsa-lib/include/sound/hdspm.h
> alsa-lib/include/sound/sb16_csp.h
> alsa-lib/m4/attributes.m4
> alsa-lib/src/ucm/main.c
> alsa-lib/src/ucm/parser.c
> alsa-lib/src/ucm/ucm_local.h
> alsa-lib/src/ucm/utils.c
> alsa-lib/test/latency.c
> alsa-lib/test/oldapi.c
> alsa-lib/test/playmidi1.c
> 
> The aserver tool and the tests are separate and not part of the library
> itself; the UCM stuff is actually LGPL-licensed and mentions the GPL
> only in "You should have received a copy of the GNU General Public
> License ...".
> 
> Most files in include/sound/ are just copies of the kernel headers.
> 
> Is there any specific file that you think would make the resulting
> library not LGPL?
> 
>> The information contained in this e-mail is privileged ...
> 
> This e-mail contains public information intended for any subscriber of
> this mailing list and for anybody else who bothers to read it; it will
> be copied, disclosed and distributed to the public.  If you think you
> are not the intended recipient, please commit suicide immediately.
> These terms apply also to any e-mails quoted in, referenced from, or
> answering this e-mail, and supersede any confidentiality notices in
> those e-mails.  Additionally, confidentiality notices in those e-mails
> will incur legal processing fees of $42 per line; you have agreed to
> this by reading this confidentiality notice.
> 
> 
> Regards,
> Clemens

---
Ossi Niiranen
Lakimies / Attorney-at-law (NY)
Neolex AB
Tel. +358 400 414 289
http://www.neolex.fi
LinkedIn: http://fi.linkedin.com/in/oniiranen
Twitter: http://www.twitter.com/oniiranen
