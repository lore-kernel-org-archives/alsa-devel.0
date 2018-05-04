From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH 2/2] ASoC: nau8810: change the target of
	MIC BIAS supply
Date: Fri, 4 May 2018 09:10:32 +0800
Message-ID: <5AEBB308.6020006@nuvoton.com>
References: <1525315602-3620-1-git-send-email-KCHSU0@nuvoton.com>
 <1525315602-3620-2-git-send-email-KCHSU0@nuvoton.com>
 <20180503231047.GB13402@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A337C266F44
 for <alsa-devel@alsa-project.org>; Fri,  4 May 2018 03:10:40 +0200 (CEST)
In-Reply-To: <20180503231047.GB13402@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, CFYU0@nuvoton.com, WTLI@nuvoton.com, lgirdwood@gmail.com, YHCHuang@nuvoton.com, CTLIN0@nuvoton.com, YCPENG7@nuvoton.com
List-Id: alsa-devel@alsa-project.org

On 5/4/2018 7:10 AM, Mark Brown wrote:
> On Thu, May 03, 2018 at 10:46:42AM +0800, John Hsu wrote:
>> The MICBAIS will not supply if there is only one path from MICP to
>> input boost stage. The driver fixes the issue by changing the supply
>> target to input boost stage mixer.
>
> Does the input boost stage actually use the MICBIAS supply directly?
> More usually a microphone bias would supply the microphone rather than
> anything on the chip itself.

The input boost stage has a mixer of two input sources. The normal case
is that MIC goes to input PGA, then to input boot stage. The case is
the original design of the driver. But there is another path that MIC
goes input boot stage directly. The case is less happened but has chance.
Ex. The single-end MIC goes to input boot stage. Therefore, we move
the target of MICBIAS to input boost stage which can supply power for
both cases.



===========================================================================================
The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Nuvoton is strictly prohibited; and any information in this email irrelevant to the official business of Nuvoton shall be deemed as neither given nor endorsed by Nuvoton.
