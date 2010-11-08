From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA processor usage is too high
Date: Mon, 08 Nov 2010 11:39:53 +0100
Message-ID: <4CD7D379.5020100@ladisch.de>
References: <AANLkTik-sb1OihaDhNgptH44gQ4__E+ozxhSKpA9GdSK@mail.gmail.com>
	<4CD41528.1060600@ladisch.de>
	<AANLkTinXm2G1y477xRTc_QjXuEZ_nyAqGWuSkq32KGe2@mail.gmail.com>
	<4CD445BD.3020501@ladisch.de>
	<AANLkTi=kMF=_1u40yTtvA=oSpyyQn=nEF_JHY_NskiAw@mail.gmail.com>
	<4CD456AE.7090302@ladisch.de>
	<AANLkTi=7pEPATKneHvZ-U-v7RUe90X-YSR-fqhF3bNx6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 6B151243F0
	for <alsa-devel@alsa-project.org>; Mon,  8 Nov 2010 11:37:55 +0100 (CET)
In-Reply-To: <AANLkTi=7pEPATKneHvZ-U-v7RUe90X-YSR-fqhF3bNx6@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adam Rosenberg <adam@alcorn.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Adam Rosenberg wrote:
> On Fri, Nov 5, 2010 at 3:10 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
> > And you should use poll() with all eight handles so that you don't
> > eat CPU while waiting.)
> 
> I can't use poll because the application has to perform many other
> tasks in a deterministic manner (meaning I can only use threads and
> other processes to notify the main loop to perform some task).

As Mark wrote, this is what poll() was designed for.

> the main loop of my application basically does this:
> while(1)
> {
>   processNextAlsaStream();
>   processMp3Decoder();
>   processLCD();
>   processInputs();
>   processSerial();
> }

With poll(), it would look somewhat like this:

  struct pollfd pollfds[...];
  // fill pollfds with all handles
  while (1)
  {
     poll(...);
     for (1..8)
       if (stream ready for writing)
         processAlsaStream(i);
     if (input ready for reading)
       processInputs();
     if (serial ready for whatever)
       processSerial();
     processMp3Decoder();
  }

If you set the PCM device to non-blocking mode, you do not need to call
avail_update before writing; just try to write as much as you currently
have.

If you want to do something regularly, use the timeout of poll(), or
use a timerfd.

You mentioned threads; these are not directly supported with poll()
because they do not have a file handle, but if you want to wake up the
main loop, you can write to an eventfd or to a pipe created with pipe().


Regards,
Clemens
