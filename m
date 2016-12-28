From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1/2] ucm: Enable all warnings for automake
	C preprocessor
Date: Wed, 28 Dec 2016 21:22:12 +0900
Message-ID: <2eb6c9c3-a32a-40ee-544a-50eb03257e5b@sakamocchi.jp>
References: <1482833331-2261-1-git-send-email-mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 060AC26693C
 for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2016 13:22:19 +0100 (CET)
In-Reply-To: <1482833331-2261-1-git-send-email-mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@linux.intel.com, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

Hi,

On Dec 27 2016 19:08, mengdong.lin@linux.intel.com wrote:
> From: Mengdong Lin <mengdong.lin@linux.intel.com>
>
> To display warnings for us to fix them, add '-Wall' to AM_CPPFLAGS.
>
> Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
>
> diff --git a/src/ucm/Makefile.am b/src/ucm/Makefile.am
> index 9d66b24..79e57d2 100644
> --- a/src/ucm/Makefile.am
> +++ b/src/ucm/Makefile.am
> @@ -7,4 +7,4 @@ noinst_HEADERS = ucm_local.h
>  all: libucm.la
>
>
> -AM_CPPFLAGS=-I$(top_srcdir)/include
> +AM_CPPFLAGS=-I$(top_srcdir)/include -Wall

As long as I know, the '-Wall' option is for C/C++ compiler. Therefore, 
it's not necessarily correct to add the option to 'AM_CPPFLAGS' as 
options for preprocessor. In a manual of GNU Automake, there're some 
samples for this option; '-I' and '-D'[0]. Usage of 'AM_CFLAGS' might be 
better in this case.

...But this indication is a bit nitpicking and I'm not so strongly 
oppose this patch. I'll manage to describe the reason.

In a manual of GNU compiler collection, there're samples of implicit 
rules for C/C++ compilers:
  * $(CC) $(CPPFLAGS) $(CFLAGS) -c
  * $(CXX) $(CPPFLAGS) $(CXXFLAGS) -c

If the place of 'CPPFLAGS' is replaced with options in AM_CPPFLAGS, your 
patch has an effect for both of C code and C++ code. This is somehow 
expected for some developers, while it's also be obtrusive because of 
sub-effect to C++ code in our case.

Currently, alsa-lib includes no C++ codes, while this patch could bring 
the obtrusiveness for future when some C++ codes were added (i.e. by 
code refactoring). But the result were preferable by itself, I believe.

Well, if Makefile.am includes 'mumble_CFLAGS' lines, options in 
'AM_CFLAGS' is ignored to generate the 'mumble'. For example, a command 
to generate 'user_ctl_element_set' object in 'test' directory is this 
case (I wrote it[2]).

Currently I cannot judge which way is better... I'm sorry but could I 
request your opinion for this patch with the view of these specifications?

[0]: 
https://www.gnu.org/software/automake/manual/html_node/Program-Variables.html
[1]: 
https://www.gnu.org/software/make/manual/html_node/Catalogue-of-Rules.html#Catalogue-of-Rules
[2]: 
http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=test/Makefile.am;h=5f35159af2d64c12e5d394cff884765808d38e5b;hb=HEAD#l29


Regards

Takashi Sakamoto
