From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8825: automatic BCLK and LRC
 divde in master mode
Date: Mon, 20 Feb 2017 10:32:18 +0800
Message-ID: <58AA5532.4040206@nuvoton.com>
References: <1487296533-20893-1-git-send-email-KCHSU0@nuvoton.com>
 <20170217104047.vhrcehhojpkdeksu@sirena.org.uk>
 <20170217104354.e6ylky6xqjaasl6m@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B4E6266AD4
 for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2017 03:32:22 +0100 (CET)
In-Reply-To: <20170217104354.e6ylky6xqjaasl6m@sirena.org.uk>
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
Cc: AP MS30 Linux ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,
On 2/17/2017 6:43 PM, Mark Brown wrote:
> On Fri, Feb 17, 2017 at 10:40:47AM +0000, Mark Brown wrote:
>
>> This is still broken, the above has tabs replaced by spaces.  I think
>> I'll try to fix up by hand but it's going to be fiddly and that's a one
>> time thing...
>
> OK, that worked - it's definitely a tab/space problem.  Please
> investigate this and try to get it fixed though, I'm not doing that for
> every patch you send.  It may be something to do with what happens when
> it leaves your company mail system and looks fine internally?

Thank you very much for help. I'll investigate what's the problem.
May I ask you more information? I need to know how to produce
the tab/space conversion issue. Do you save the patch mail
to text file with patch sub file name? Then type the "git am <"
command to apply the patch. I can't reproduce the issue in my
ubuntu linux with the patch mail sent by me.


===========================================================================================
The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Nuvoton is strictly prohibited; and any information in this email irrelevant to the official business of Nuvoton shall be deemed as neither given nor endorsed by Nuvoton.
