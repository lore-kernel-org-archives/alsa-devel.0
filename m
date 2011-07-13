From: Tom Watson <sdc695@yahoo.com>
Subject: Re: Drop 2.2/2.4 kernel support in alsa-driver
Date: Wed, 13 Jul 2011 04:10:19 -0700 (PDT)
Message-ID: <1310555419.99392.YahooMailClassic@web65416.mail.ac4.yahoo.com>
References: <mailman.35.1310503697.2141.alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm8.bullet.mail.ac4.yahoo.com (nm8.bullet.mail.ac4.yahoo.com
	[98.139.52.205]) by alsa0.perex.cz (Postfix) with SMTP id BC37824383
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jul 2011 13:10:21 +0200 (CEST)
In-Reply-To: <mailman.35.1310503697.2141.alsa-devel@alsa-project.org>
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

Jaroslav Kysela <perex@perex.cz> Wrote:


>Date 12.7.2011 18:12, Takashi Iwai wrote:
>> [This is resent since I haven't seen my original post due to
>>  alsa-project.org site down.  If you have already read it, please
>>  disregard.]
>>
>> Hi,
>>
>> in upcoming 3.0-kernel era, I believe it's high time to drop the
>> support of old 2.2/2.4 kernels in alsa-driver external builds.
>> Recently I changed some PCI drivers to use KBUILD_MODNAME, and this
>> isn't supported by the old kernels, i.e. it's currently broken for
>> these kernels.  But I have no more gut to patch alsa-driver/* codes.
>>
>> Is there any active user of such kernels with the latest alsa-driver?
>> If not, let's clean up the whole things.
>> 2.2/2.4 kernel users can still use 1.0.24, and we can release 1.0.24.x
>> series if really needed.
>
> I agree. I believe that these kernels are using minimum users now.
> Almost all embeded devices are using 2.6 kernels, too.
>
>                    Jaroslav

While this IS a good idea, I would suggest that ALSA take a cue from the kernel people and bump the version up a major number.  It would make lots of sense that ALSA 2.0 go with kernel version 3.0.  An alternative might be to skip version 2.0 and go to ALSA 3.0 to match kernel version 3.0.

This won't change any code, but it would be a little clearer.  That way when you drop support for older kernels, you can easily tell what version should be used.

"Just a suggestion"  worth the paper it is written on.

-- 
Tom Watson
tsw@johana.com
