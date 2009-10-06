From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: alsa-utils cross compilation error
Date: Tue, 6 Oct 2009 16:21:59 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0910061620410.31529@eeebox2.perex-int.cz>
References: <7df11cd50910060719t66c353b0jc865f04e09f49c12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 3906A10395A
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 16:22:00 +0200 (CEST)
In-Reply-To: <7df11cd50910060719t66c353b0jc865f04e09f49c12@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Harish Kumar <harishkumarb7@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 6 Oct 2009, Harish Kumar wrote:

> Hi,
>
> I am trying to cross compile the alsa utils for PPC and as well as arm
> architecture. the compilation of alsa-libs was successful with their
> respective toolchains. But configuring the alsa-util is failing. I am
> using alsa-utils-1.0.11rc2,alsa-lib-1.0.11rc2.  I am getting the error
> checking for libasound headers version >= 1.0.9... not present.
> configure: error: Sufficiently new version of libasound not found. I
> feel i have to provide the path of the include files but not sure
> which path to be passed and how it needs to be passed to configure.

# ./configure --help | grep alsa | grep prefix
   --with-alsa-prefix=PFX  Prefix where Alsa library is installed(optional)
   --with-alsa-inc-prefix=PFX  Prefix where include libraries are (optional)

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
