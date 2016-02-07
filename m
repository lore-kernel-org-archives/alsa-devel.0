From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: About planning of libhinawa ITP to debian project
Date: Sun, 7 Feb 2016 22:10:25 +0900
Message-ID: <56B74241.6040803@sakamocchi.jp>
References: <56ADEF9C.50303@sakamocchi.jp> <56ADF3E8.1050109@sakamocchi.jp>
 <56B0B751.9080609@sakamocchi.jp> <56B6B599.2020002@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id C437526049B
 for <alsa-devel@alsa-project.org>; Sun,  7 Feb 2016 14:10:28 +0100 (CET)
In-Reply-To: <56B6B599.2020002@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: hayashi@clear-code.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, linux1394-devel@lists.sourceforge.net, "ffado-devel@lists.sf.net" <ffado-devel@lists.sf.net>
List-Id: alsa-devel@alsa-project.org

Hi,

On Feb 7 2016 12:10, Takashi Sakamoto wrote:
> Hi,
> 
> On Feb 2 2016 23:04, Takashi Sakamoto wrote:
>> On Jan 31 2016 20:45, Takashi Sakamoto wrote:
>>> In this message, I explain about a plan of libhinawa ITP[0] to debian
>>> project. Fortunately, I got a help of a debian package maintainer,
>>> Kentaro Hayashi. He maintains groonga package[1] and experienced
>>> related works[2].
>>>
>>> Currently, we plan to work for it in next month, February 2016. I have
>>> no idea about when FTP master acked to our ITP and when the package is
>>> released from debian project.
>>
>> Today, we register this to Debian Bug report #813474.
>> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=813474
>>
>> And start RFS (Request For Sponsorship).
>> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=813489
>>
>> Thanks for Kentaro.
> 
> A few days ago, we got a sponsor for the package and yesterday it's in
> new queue. Today, a few hours before, I received a notification that the
> package was granted and moved to Debian ftp-master server.
> 
> In short, the package is in unstable repository and may be released
> within a few days. Thanks all.

Now it's in Debian unstable.
https://packages.debian.org/source/unstable/libhinawa

> Now I'm preparing for 'needs-packaging' request [3] to Ubuntu project.
> We have 10 days to FeatureFreeze[4] for Ubuntu 16.04 (Xenyal Xerus)[5].

In Ubuntu project, AutoSync bot imported it and the package is now
available.
https://launchpad.net/ubuntu/+source/libhinawa

Thanks for all ;)

>>> I with the package will be available as early as possible, and this work
>>> will be a part of his great work as a debian package maintainer.
>>>
>>> FYI,
>>>
>>> [0] ITP = Intent To Packaging
>>> [1] Debian -- Details of package groonga in sid:
>>> https://packages.debian.org/sid/groonga
>>> [2] Debian Bug report logs - #732055
>>> ITP: groonga -- Fulltext search engine
>>> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=732055
> 
> [3] https://wiki.ubuntu.com/UbuntuDevelopment/NewPackages
> [4] https://wiki.ubuntu.com/FeatureFreeze
> [5] https://wiki.ubuntu.com/XenialXerus/ReleaseSchedule


Takashi Sakamoto
