From: "John Utz" <john.utz@dmx.com>
Subject: Re: Alsa Callbacks and C++ classes
Date: Mon, 21 Apr 2008 11:08:01 -0700
Message-ID: <20080421110801.5013fa00@jutz-gnto64>
References: <200804202128.25675.reuben.m@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C71C24468
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Apr 2008 20:08:21 +0200 (CEST)
In-Reply-To: <200804202128.25675.reuben.m@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Reuben Martin <reuben.m@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 20 Apr 2008 21:28:25 -0500
"Reuben Martin" <reuben.m@gmail.com> wrote:

> Hello all,
> 
> I have an AES32 sound card that I am trying to write a general
> control interface for using qt4. I'm wanting to register callbacks so
> that the interface will reflect changes made by other apps. Now I'm
> not entirely up to speed on the API, but from what I can gather, the
> callback can be registered to call a regular function, or to change a
> public class variable.
> 
> Since I decided to use qt4, everything is in classes. Is there any
> way to have the callback trigger a public class function? I guess I
> don't understand why you would want to use a public variable instead.
> Wouldn't you have to set up a means within the class to continually
> pole the variable to see if it has been changed? Or can the option to
> call a regular function be used to call a public class function as
> well?

I am not looking at the API docs at the moment, but I would expect that
it would work but would probably require a significant bit of casting
fu to deal with the c++ pointers and maybe some #defines to deal
with C++ name mangling, ie:

00000000 T dqzport_CommunicateInit__FPi
dfxportInit.o:
00000000 a dqzportInit.cpp
00000000 T dqzportInit__FPPiPciP6CSlout
         U dqzport_CommunicateInit__FPi

Given the grief that i have experienced attempting to get c and c++ to
play nicely together, i'd be choosing to communicate via some other
means.

My interoperability issues may be tied to the fact that i am stuck with
dealing with some legacy c++ libs that where written with g++2 and it
may all be solved and work transparently when using gcc4/g++4, i dont
really know because i dont get to use it for our application.

> Go easy on me. I'm not much of an experienced programmer. More of a
> hack who can kinda get by with his sloppy programming most of the
> time.

No prob, the public variable idea certainly seems to be appropriate
given that perspective. :-)

> Thanks,
> -Reuben
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
