From: Donglin Peng <dolinux.peng@gmail.com>
Subject: Re: [PATCH v3] ASoC: use DEFINE_SHOW_ATTRIBUTE() to
	decrease code duplication
Date: Wed, 14 Feb 2018 22:52:42 +0800
Message-ID: <CAErzpmtW897Xa5Q_zsu1ye8XAKCFhDw-rn4YzqfsgeMQj6DcCg@mail.gmail.com>
References: <CAErzpmuxmrJszRz5_SZXPMkdU2UWNHChrnKjnHuCWZYrs4hgTA@mail.gmail.com>
 <20180212114937.GA12976@sirena.org.uk>
 <CAErzpmt+HhGkVoN199iPDmQx-1z3iS3waxYQ=oxvn14Bm0R5gg@mail.gmail.com>
 <CAHp75Vey-RoLw9kWRg1mdz7-4vBcmOUmdLxjz067f3qjN_S3NA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f169.google.com (mail-qk0-f169.google.com
 [209.85.220.169])
 by alsa0.perex.cz (Postfix) with ESMTP id A4507266EDF
 for <alsa-devel@alsa-project.org>; Wed, 14 Feb 2018 15:53:04 +0100 (CET)
Received: by mail-qk0-f169.google.com with SMTP id c128so26925926qkb.4
 for <alsa-devel@alsa-project.org>; Wed, 14 Feb 2018 06:53:03 -0800 (PST)
In-Reply-To: <CAHp75Vey-RoLw9kWRg1mdz7-4vBcmOUmdLxjz067f3qjN_S3NA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 14, 2018 at 10:41 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Feb 14, 2018 at 4:39 PM, Donglin Peng <dolinux.peng@gmail.com> wrote:
>> On Mon, Feb 12, 2018 at 7:49 PM, Mark Brown <broonie@kernel.org> wrote:
>>> On Fri, Feb 09, 2018 at 11:10:55PM +0800, Donglin Peng wrote:
>
>> Hi Mark, do you know the way to disable gmail word wrap in plain text mode?
>> I find that gmail will force to wrap word at 70 characters in plain text mode.
>
>> There is a connection error when I use git send-email to send the patch
>> because I am using VPN.
>
> You may use SMTPS port (587 IIRC?) of Gmail to send a patch via git send-email.
Thanks, I have sent it just now.
>
> --
> With Best Regards,
> Andy Shevchenko
