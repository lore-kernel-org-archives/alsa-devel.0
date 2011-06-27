From: Adrian Pardini <pardo.bsso@gmail.com>
Subject: Re: compile problems
Date: Mon, 27 Jun 2011 11:25:12 -0300
Message-ID: <BANLkTikPDJ3UQgoaPniBEei3pkVQT=b0hw@mail.gmail.com>
References: <4E088113.6040500@digital-pipe.com>
	<BANLkTi=mDwbo59wT5tAhmV0K60f6+TT2BQ@mail.gmail.com>
	<4E088C15.3030608@digital-pipe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id DB85E243A4
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Jun 2011 16:25:15 +0200 (CEST)
Received: by vws20 with SMTP id 20so3790531vws.38
	for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2011 07:25:12 -0700 (PDT)
In-Reply-To: <4E088C15.3030608@digital-pipe.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henderson <dhenderson@digital-pipe.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 27/06/2011, David Henderson <dhenderson@digital-pipe.com> wrote:
> On 06/27/2011 09:35 AM, Adrian Pardini wrote:
[...]
>> Hi Dave, try giving --with-alsa-inc-prefix=/opt/staging/alsa to the
>> configure script.
>>
>
> Thanks for the help Adrian.  I tried passing that parameter to the
> configure script and here's the below output:
> checking for libasound headers version >= 1.0.16... not present.
> configure: error: Sufficiently new version of libasound not found.
>
> I've double checked that the header files are present:
> $ ls -1 /opt/staging/alsa/var/share/include/alsa/

My bad, here it works using ./configure
--with-alsa-inc-prefix=/usr/include/alsa/ so I think you should use
./configure --with-alsa-inc-prefix=/opt/staging/alsa/var/share/include/alsa/.
 If you are not in a hurry I can try to replicate your directory
structure when I get back to home. Also you may have to set the
LDFLAGS environment variable to point to where your libraries are
being installed under /opt

-- 
Adrian.
http://ovejafm.com
http://elesquinazotango.com.ar
http://www.elarteylatecnologia.com.ar
