From: "Sebastian H." <vand2@gmx.de>
Subject: Re: alsa-lib TLVs and valgrind
Date: Wed, 02 Feb 2011 16:16:15 +0100
Message-ID: <4D49753F.7000507@gmx.de>
References: <4D4945FA.4030506@gmx.de> <4D495859.6070101@ladisch.de>
	<4D4959AB.1050703@gmx.de> <4D497464.4050506@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.22])
	by alsa0.perex.cz (Postfix) with SMTP id EA18D24597
	for <alsa-devel@alsa-project.org>; Wed,  2 Feb 2011 16:21:23 +0100 (CET)
In-Reply-To: <4D497464.4050506@ladisch.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Am 02.02.2011 16:12, schrieb Clemens Ladisch:
> Sebastian H. wrote:
>> Am 02.02.2011 14:12, schrieb Clemens Ladisch:
>>> Valgrind doesn't know about some of the ALSA ioctls.
>>> Somebody would have to add them to valgrind.
>>
>> That seems to require quite some effort - also to maintain.
>> Couldn't just the dB min/max values be initialized with 0 or sth.?
> 
> Then it wouldn't be possible for valgrind to catch wrong uses of the
> ioctl.

Ok. My knowledge of how valgrind works is limited anyway.

Thank you,
Sebastian
