From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Use of _hint() functions and older machines
Date: Mon, 24 Oct 2011 15:00:11 +0800
Message-ID: <CAN8ccibOiNtP_8ypBD=WsfCPkQsvd9bRi3wcE3Sg6tqxJHq1+w@mail.gmail.com>
References: <4EA0E6E5.1050600@jesup.org> <4EA3EE43.3010904@ladisch.de>
	<4EA4F573.9060704@jesup.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 83CC7243AC
	for <alsa-devel@alsa-project.org>;
	Mon, 24 Oct 2011 09:00:12 +0200 (CEST)
Received: by bkbzs8 with SMTP id zs8so7635873bkb.38
	for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2011 00:00:12 -0700 (PDT)
In-Reply-To: <4EA4F573.9060704@jesup.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/10/24 Randell Jesup <randell1@jesup.org>:
> On 10/23/2011 6:36 AM, Clemens Ladisch wrote:
>> On 10/21/2011 05:28 AM, Randell Jesup wrote:
>>> On older machines, _hint() aren't available, so even if I make them
>>> optional to dlsym-loading, I would need some other method to get the
>>> information I assume using older, now-deprecated-or-gone interfaces.
>>
>> On older machines, that information wasn't available at all.
>>
>> The recommendation was to use "default" or to let the user enter
>> a device name.
>
> Ah. =A0Ok. =A0Wow, was it really that painful? =A0I didn't do a lot of Li=
nux
> media stuff back then, and generally had only built-in-audio (no USB
> headsets, etc) with simple speakers.

Those rack servers which are running 7x24 non-stop inside data center,
does not have any on-board audio,
