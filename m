From: Daniel Mack <zonque@gmail.com>
Subject: Re: alsa-utils cross-compilation problem
Date: Tue, 19 Oct 2010 01:03:29 +0200
Message-ID: <4CBCD241.6010100@gmail.com>
References: <AANLkTikV4gGR8Pstd9vFQvBXi7BJcpi6hcK+DRuX4swe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id CC0FC10384C
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Oct 2010 01:03:33 +0200 (CEST)
Received: by ewy9 with SMTP id 9so1151960ewy.38
	for <alsa-devel@alsa-project.org>; Mon, 18 Oct 2010 16:03:30 -0700 (PDT)
In-Reply-To: <AANLkTikV4gGR8Pstd9vFQvBXi7BJcpi6hcK+DRuX4swe@mail.gmail.com>
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

On 10/18/2010 08:52 AM, Reena Chauhan wrote:
> hi
> I had tried to cross compile the Alsa-utils 1.0.23&  m getting following
> errors:
> checking for libasound headers version>= 1.0.16... not present.
> configure: error: Sufficiently new version of libasound not found
>
> In my host PC alsa-lib 1.0.22 is installed
>

You need to cross-compile alsa-lib as well and then point the build 
process of alsa-utils to the correct pathes.

I can really suggest to let this job be done by some kind of 
cross-compile environment such as buildroot 
(http://buildroot.uclibc.org) or OpenEmbedded unless you have very good 
reasons to do it yourself.

Daniel
