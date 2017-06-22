From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: ASoC: nau8825: fix jack type detection issue after
	resume
Date: Thu, 22 Jun 2017 09:40:08 +0800
Message-ID: <594B1FF8.2000603@nuvoton.com>
References: <1498028390-10952-1-git-send-email-KCHSU0@nuvoton.com>
 <20170621105927.nnxu3moceqkz6zub@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D32C12664EB
 for <alsa-devel@alsa-project.org>; Thu, 22 Jun 2017 03:40:10 +0200 (CEST)
In-Reply-To: <20170621105927.nnxu3moceqkz6zub@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, lgirdwood@gmail.com, benzh@chromium.org, mac.chiang@intel.com, CTLIN0@nuvoton.com, yong.zhi@intel.com, John Hsu <supercraig0719@gmail.com>, mhkuo@nuvoton.com
List-Id: alsa-devel@alsa-project.org

On 6/21/2017 6:59 PM, Mark Brown wrote:
> On Wed, Jun 21, 2017 at 02:59:50PM +0800, John Hsu wrote:
>> Fix the issue that mic type detection error after resume.
>> The patch help to fix the issue as follows:
>> Google issue 37973093: CTIA/OMTP jack type detection failure after resume
>
> What is the issue and in what way does this patch help fix it?  The
> changelog just says it's fixing a problem, it doesn't say what the
> problem is or what the change is supposed to do.

I'll resend the patch and make more description about the issue.


===========================================================================================
The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Nuvoton is strictly prohibited; and any information in this email irrelevant to the official business of Nuvoton shall be deemed as neither given nor endorsed by Nuvoton.
