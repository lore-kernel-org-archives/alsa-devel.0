From: anish <yesanishhere@gmail.com>
Subject: Re: [PATCH] ASoC: Add max98925 codec driver
Date: Thu, 19 Feb 2015 23:47:09 -0800
Message-ID: <CABCoZhB_6eAKnoRJRA-d86XJv-vn+d4P_QQQbHtyfeaxMbwaEQ@mail.gmail.com>
References: <1424318986-18895-1-git-send-email-yesanishhere@gmail.com>
 <54E5876E.2090703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f46.google.com (mail-la0-f46.google.com
 [209.85.215.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 869402605FB
 for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2015 08:47:09 +0100 (CET)
Received: by labgm9 with SMTP id gm9so4574179lab.2
 for <alsa-devel@alsa-project.org>; Thu, 19 Feb 2015 23:47:09 -0800 (PST)
In-Reply-To: <54E5876E.2090703@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tushar Behera <trblinux@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, Maxwell McKinnon <Maxwell.McKinnon@maximintegrated.com>, "broonie@kernel.org" <broonie@kernel.org>, Nitin Mittal <nitin.mittal@maximintegrated.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 18, 2015 at 10:49 PM, Tushar Behera <trblinux@gmail.com> wrote:
> On 02/19/2015 09:39 AM, Anish Kumar wrote:
>> Signed-off-by: Anish Kumar <yesanishhere@gmail.com>
>> ---
> For the revised patches, it is a good idea to add the version number in
> the subject line. You can do that with --subject-prefix flag while
> issuing git-format-patch command.
>
> Also please include changelog in the patch explaining the changes in
> subsequent revisions.

will sure do it for the next revision. Can i get some comments
for this?
>
>>  sound/soc/codecs/Kconfig    |   9 +
>>  sound/soc/codecs/Makefile   |   2 +
>>  sound/soc/codecs/max98925.c | 843 +++++++++++++++++++++++++++++++++++++++++++
>>  sound/soc/codecs/max98925.h | 845 ++++++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 1699 insertions(+)
>>  create mode 100644 sound/soc/codecs/max98925.c
>>  create mode 100644 sound/soc/codecs/max98925.h
>>
>
> --
> Tushar Behera
