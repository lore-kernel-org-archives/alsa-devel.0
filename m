From: Nicholas Smethurst <nick.smethurst@gmail.com>
Subject: Re: Getting a full device list
Date: Fri, 11 May 2007 13:05:36 +0200
Message-ID: <46444E00.1040808@gmail.com>
References: <560009e30704190730q1047b43fh37f5df5fef9ec51f@mail.gmail.com>
	<75b66ecd0704190846g4036b493q8d7c2bec8cdc08b2@mail.gmail.com>
	<4627B015.7030401@gmail.com>
	<75b66ecd0704191145u3414a5e6id9e3f10ef9c6b854@mail.gmail.com>
	<4644455B.4080706@gmail.com>
	<Pine.LNX.4.61.0705111233090.7579@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.234])
	by alsa0.perex.cz (Postfix) with ESMTP id CE43E2448A
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2007 13:05:42 +0200 (CEST)
Received: by wx-out-0506.google.com with SMTP id h30so834472wxd
	for <alsa-devel@alsa-project.org>; Fri, 11 May 2007 04:05:41 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.61.0705111233090.7579@tm8103.perex-int.cz>
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

Jaroslav Kysela wrote:
> On Fri, 11 May 2007, Nicholas Smethurst wrote:
> 
>> Is this possible? If not, can we work towards implementing such
>> functionality?
> 
> User or system software manager should create a configuration which is 
> suitable for users. You're trying to overload the user settings. Why?
> Use information returned without any hacks in your application (you may 
> eventually describe in documentation, how users can get more devices).

I'm not sure I understand.

I found the global variable "defaults.namehint.showall" in alsa.conf, which
lives in /usr/share/alsa/. This is not the sort of place a user should be
fiddling with. Users don't have the knowledge (or the desire) to manually
change system configuration files.. us developers should be able to do all we
need to do via alsa-lib.

I understand that you are suggesting that user applications list what ever
snd_device_name_hint() returns, and then describe in the application
documentation that if the user does not see devices such as hw, they should
manually edit a system configuration file.

Or do you mean that a user application can create its own global
configuration? I didn't know that that was possible.

If this is the case, can I copy the default configuration and turn on
"defaults.namehint.showall" in order that my user application can call have
the full list from snd_device_name_hint()?

Nicholas
