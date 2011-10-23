From: Randell Jesup <randell1@jesup.org>
Subject: Re: Use of _hint() functions and older machines
Date: Sun, 23 Oct 2011 03:46:07 -0400
Message-ID: <4EA3C63F.4090501@jesup.org>
References: <4EA0E6E5.1050600@jesup.org> <4EA305B7.6050001@colin.guthr.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from r2-chicago.webserversystems.com
	(r2-chicago.webserversystems.com [173.236.101.58])
	by alsa0.perex.cz (Postfix) with ESMTP id 3FF042453E
	for <alsa-devel@alsa-project.org>;
	Sun, 23 Oct 2011 09:51:00 +0200 (CEST)
In-Reply-To: <4EA305B7.6050001@colin.guthr.ie>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Colin Guthrie <gmane@colin.guthr.ie>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Randell Jesup <randell1@jesup.org>
List-Id: alsa-devel@alsa-project.org

On 10/22/2011 2:04 PM, Colin Guthrie wrote:
> 'Twas brillig, and Randell Jesup at 21/10/11 04:28 did gyre and gimble:
>> [ I initially posted this to the -users list, but it may be more
>> appropriate here ]
>>
>> At Mozilla, we're in the process of adding support for WebRTC
>> (http://webrtc.org/), which is being standardized by the IETF (their
>> part is 'rtcweb'), and the W3C.  This adds real-time audio and video
>> (and data) communication to browsers, peer-to-peer over encrypted channels.
>>
>> We have a sound library that can load either Pulse or Alsa.  However,
>> for Alsa, it wants to look at snd_device_name_hint() and also
>> _get_hint() and _free_hint().  It lazy-binds to libasound, so it will
>> dlopen() it and then dlsym() all the symbols it uses; if any fail it
>> unloads the lib and says it's not there.  It  uses the hint functions to
>> build a device list, for example for presenting to the user.
>>
>> I have two problems:
>>
>> 1) Firefox is build on machines configured with I believe Centos5, and
>> I'm told the machines run Alsa 1.0.12, while the hints() functions were
>> added in 1.0.14 (released June 2007).  Right now I can't build release
>> or 'try' builds on the build servers because of this.
>
> Are you sure? CentOS 5 is fairly new and on a box I have access to:
>
> [csuk@shake ~]$ cat /etc/redhat-release
> CentOS release 5.5 (Final)
> [csuk@shake ~]$ rpm -q alsa-lib
> alsa-lib-1.0.17-1.el5
>
>
> So I guess it's likely CentOS 4? Even still updating alsa-lib to 1.0.14
> should be pretty trivial and safe. Or do you not have any control at all
> over the version used?

In general no, I do not have any control.  These are the 'hive' of build 
and 'try' servers used at Mozilla; they run a "least-common-denominator" 
set of packages so that we don't accidentally introduce a dependency on 
a newer version.  With 400+ million users, we need to be careful about 
this.  (I don't know how many of those are Linux, but it's still a 
substantial number.)

Also, the point here is we need to package a binary that will operate on 
the minimum configuration we support.  10.1.14 was released initially 
just over 4 years ago; I don't know when it got into distro releases, 
but one would assume that would have occurred over the next 6 months to 
a year, so users who installed more than 3-4 years ago might have 
versions before .14, depending on if they installed updates.

>> 2) We'd like to run on older machines if possible, and official release
>> builds are made on those servers.  On older machines, _hint() aren't
>> available, so even if I make them optional to dlsym-loading, I would
>> need some other method to get the information I assume using older,
>> now-deprecated-or-gone interfaces.
>
> Not sure, but I suspect strongly that you should simply not worry about
> this too much. While it's nice to give a good experience to everyone,
> people with systems 4 years old have got to expect a degree of
> degradation over a more recent install.

I understand, and I can try to make an argument for bumping the minimum 
configuration required - and that might fly.  But I need to know what 
the alternative is to even make the argument for bumping.

Thanks for the reply!


-- 
Randell Jesup
randell-ietf@jesup.org
