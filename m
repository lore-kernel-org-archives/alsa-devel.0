From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH -mm] sb16: Shut up uninitialized var build
	warning
Date: Sat, 22 Sep 2007 06:20:00 +0200
Message-ID: <46F497F0.1090608@gmail.com>
References: <alpine.LFD.0.999.0709022344550.27844@enigma.security.iitk.ac.i n>
	<alpine.LFD.0.999.0709030143550.29617@enigma.security.iitk.ac.in>
	<46DB33D0.40204@gmail.com>
	<200709201852.11497.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id B6E2A246F6
	for <alsa-devel@alsa-project.org>;
	Sat, 22 Sep 2007 06:21:27 +0200 (CEST)
In-Reply-To: <200709201852.11497.vda.linux@googlemail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Denys Vlasenko <vda.linux@googlemail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@suse.cz>, Satyam Sharma <satyam@infradead.org>
List-Id: alsa-devel@alsa-project.org

On 09/20/2007 07:52 PM, Denys Vlasenko wrote:

> On Sunday 02 September 2007 23:06, Rene Herman wrote:

>> Blah. Your message has:
>>
>> 	Content-Type: TEXT/PLAIN; charset=iso-2022-jp
>>
>> This apparently is caused by a combination of GCC using groovy UTF tickmarks 
>> in its error messages when in a UTF locale and alpine believing it to be a 
>> great idea to automatically try for the "simplest" character set it can 
>> encode the content in. No idea why that means that iso-2022-jp is picked, 
>> but it is.
>>
>> While I could actually read the message this time you should see what 
>> iso-2022-jp does to my font. It's scary. Best solution as far as I'm 
>> concerned is slap a few GCC developers (not that it wil help, but it'll 
>> certainly feel good) and then teach alpine to go for UTF-8 directly if 
>> US-ASCII won't do.
> 
> rotfl.
> 
> Kindly give me permission to convert your email into gcc bugreport
> and/or to forward it to gcc mailing list.

Blessings be upon thou, oh courageous one...

Rene.
