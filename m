From: David Henderson <dhenderson@digital-pipe.com>
Subject: Re: compile problems
Date: Mon, 27 Jun 2011 10:59:34 -0400
Message-ID: <4E089AD6.8030606@digital-pipe.com>
References: <4E088113.6040500@digital-pipe.com>	<BANLkTi=mDwbo59wT5tAhmV0K60f6+TT2BQ@mail.gmail.com>	<4E088C15.3030608@digital-pipe.com>
	<BANLkTikPDJ3UQgoaPniBEei3pkVQT=b0hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B8FAE243F0
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Jun 2011 17:01:18 +0200 (CEST)
Received: by gxk1 with SMTP id 1so2396492gxk.38
	for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2011 08:01:18 -0700 (PDT)
In-Reply-To: <BANLkTikPDJ3UQgoaPniBEei3pkVQT=b0hw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adrian Pardini <pardo.bsso@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 06/27/2011 10:25 AM, Adrian Pardini wrote:
> On 27/06/2011, David Henderson<dhenderson@digital-pipe.com>  wrote:
>> On 06/27/2011 09:35 AM, Adrian Pardini wrote:
> [...]
>>> Hi Dave, try giving --with-alsa-inc-prefix=/opt/staging/alsa to the
>>> configure script.
>>>
>> Thanks for the help Adrian.  I tried passing that parameter to the
>> configure script and here's the below output:
>> checking for libasound headers version>= 1.0.16... not present.
>> configure: error: Sufficiently new version of libasound not found.
>>
>> I've double checked that the header files are present:
>> $ ls -1 /opt/staging/alsa/var/share/include/alsa/
> My bad, here it works using ./configure
> --with-alsa-inc-prefix=/usr/include/alsa/ so I think you should use
> ./configure --with-alsa-inc-prefix=/opt/staging/alsa/var/share/include/alsa/.
>   If you are not in a hurry I can try to replicate your directory
> structure when I get back to home. Also you may have to set the
> LDFLAGS environment variable to point to where your libraries are
> being installed under /opt
>

Thanks for the continued help Adrian.  I tried the adjusted configure 
parameter value, but it's still giving the same error message.  
Currently I'm in no rush, so let me know once you're able to get home.  
Also, if you need my compiled version of the alsa-lib package (or any 
other info), let me know.

Thanks,
Dave
