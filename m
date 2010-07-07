From: Adish Kuvelker <adkuvi@gmail.com>
Subject: Re: Problems running "amixer"
Date: Wed, 7 Jul 2010 18:43:00 +0530
Message-ID: <AANLkTikvbxebpDbMl_3ui9TOmF4glhhJRT31-fQhXHCW@mail.gmail.com>
References: <AANLkTinSa0nOGY0OQDdjRaPZFES9QM-5zr_F3ZwIxCEw@mail.gmail.com>
	<4C347742.3050404@ladisch.de>
	<AANLkTikQfdPuAGwPyq4j1Syi9iiBgj-MzLmPEiAy2lYc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 74772244BF
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Jul 2010 15:13:02 +0200 (CEST)
Received: by vws9 with SMTP id 9so5400514vws.38
	for <alsa-devel@alsa-project.org>; Wed, 07 Jul 2010 06:13:00 -0700 (PDT)
In-Reply-To: <AANLkTikQfdPuAGwPyq4j1Syi9iiBgj-MzLmPEiAy2lYc@mail.gmail.com>
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

Hello,

I don't have this file ".asoundrc" in my ramdisk. Do I need this?

Regards
Aadish

On Wed, Jul 7, 2010 at 6:38 PM, Adish Kuvelker <adkuvi@gmail.com> wrote:
> Hello Clemens,
>
> I have the "alsa" folder with the files alsa.conf. My "amixer" utility
> has been copied under "/bin".
> I followed a mail thread which said to load "share" folder under
> "/usr". But even with this the problem persisted.
>
> I'm just pasting here the contents of my /usr/share
> # ls share/
> aclocal =A0alsa =A0 =A0 locale
> # ls -la share/alsa/
> drwxr-xr-x =A0 =A04 root =A0 =A0 root =A0 =A0 =A0 =A0 1024 May 12 =A02010=
 .
> drwxr-xr-x =A0 =A05 root =A0 =A0 root =A0 =A0 =A0 =A0 1024 May 12 =A02010=
 ..
> -rw-r--r-- =A0 =A01 root =A0 =A0 root =A0 =A0 =A0 =A0 7701 May 12 =A02010=
 alsa.conf
> drwxr-xr-x =A0 =A03 root =A0 =A0 root =A0 =A0 =A0 =A0 2048 May 12 =A02010=
 cards
> drwxr-xr-x =A0 =A02 root =A0 =A0 root =A0 =A0 =A0 =A0 1024 May 12 =A02010=
 pcm
> -rw-r--r-- =A0 =A01 root =A0 =A0 root =A0 =A0 =A0 =A0 3205 May 12 =A02010=
 sndo-mixer.alisp
>
>
>
>
> Just to make sure, do I have to install my entire staging area created
> through install of alsa-lib and alsa-utils in to the /usr/share?
>
> Regards;
> Aadish
>
>
>
>
> On Wed, Jul 7, 2010 at 6:16 PM, Clemens Ladisch <clemens@ladisch.de> wrot=
e:
>> Adish Kuvelker wrote:
>>> # ./amixer
>>> ALSA lib control.c:910:(snd_ctl_open_noupdate) Invalid CTL default
>>
>> Apparently, alsa-lib has not been installed correctly, i.e.,
>> /usr/share/alsa/alsa.conf and other files in this directory are missing.
>>
>>
>> Regards,
>> Clemens
>>
>
