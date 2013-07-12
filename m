From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2 1/3] ASoC: sglt5000: Provide the
	reg_stride field
Date: Fri, 12 Jul 2013 11:32:10 -0300
Message-ID: <CAOMZO5ByyLo929bRy+Trzg+aU8LfLMnXDDDni+RqitgYNoYXpw@mail.gmail.com>
References: <1372978863-4872-1-git-send-email-festevam@gmail.com>
 <20130705094521.GP27646@sirena.org.uk>
 <CAOMZO5COBNrYF+LrdgHFhpH=rGBdZA9_cRdjd-WwCd52KQ1D2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ve0-f174.google.com (mail-ve0-f174.google.com
 [209.85.128.174])
 by alsa0.perex.cz (Postfix) with ESMTP id B9A28265A16
 for <alsa-devel@alsa-project.org>; Fri, 12 Jul 2013 16:32:10 +0200 (CEST)
Received: by mail-ve0-f174.google.com with SMTP id oz10so8177959veb.5
 for <alsa-devel@alsa-project.org>; Fri, 12 Jul 2013 07:32:10 -0700 (PDT)
In-Reply-To: <CAOMZO5COBNrYF+LrdgHFhpH=rGBdZA9_cRdjd-WwCd52KQ1D2g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, oskar@scara.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 12, 2013 at 11:27 AM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Mark,
>
> On Fri, Jul 5, 2013 at 6:45 AM, Mark Brown <broonie@kernel.org> wrote:
>> On Thu, Jul 04, 2013 at 08:01:01PM -0300, Fabio Estevam wrote:
>>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>>
>>> sgtl5000 has 16-bit registers, and only even numbers are valid for its registers
>>> addresses.
>>
>> Applied, but note that it's only the second bit of that that makes any
>> diffrence - the registers could be any size.
>
> Which branch have you applied this one, please? I am not able to
> locate it in any of your branches.

Good, just found it:
https://git.kernel.org/cgit/linux/kernel/git/broonie/sound.git/log/?h=topic/sgtl5000
