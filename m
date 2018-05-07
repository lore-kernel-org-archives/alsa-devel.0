From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH 2/2] ASoC: nau8810: change the target of
	MIC BIAS supply
Date: Mon, 7 May 2018 14:57:28 +0800
Message-ID: <5AEFF8D8.5090003@nuvoton.com>
References: <1525315602-3620-1-git-send-email-KCHSU0@nuvoton.com>
 <1525315602-3620-2-git-send-email-KCHSU0@nuvoton.com>
 <20180503231047.GB13402@sirena.org.uk> <5AEBB308.6020006@nuvoton.com>
 <20180505010110.GI13402@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D37C267634
 for <alsa-devel@alsa-project.org>; Mon,  7 May 2018 08:57:35 +0200 (CEST)
In-Reply-To: <20180505010110.GI13402@sirena.org.uk>
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

On 5/5/2018 9:01 AM, Mark Brown wrote:
> On Fri, May 04, 2018 at 09:10:32AM +0800, John Hsu wrote:
>> On 5/4/2018 7:10 AM, Mark Brown wrote:
>>> On Thu, May 03, 2018 at 10:46:42AM +0800, John Hsu wrote:
>>>> The MICBAIS will not supply if there is only one path from MICP to
>>>> input boost stage. The driver fixes the issue by changing the supply
>>>> target to input boost stage mixer.
>
>>> Does the input boost stage actually use the MICBIAS supply directly?
>>> More usually a microphone bias would supply the microphone rather than
>>> anything on the chip itself.
>
>> The input boost stage has a mixer of two input sources. The normal case
>> is that MIC goes to input PGA, then to input boot stage. The case is
>> the original design of the driver. But there is another path that MIC
>> goes input boot stage directly. The case is less happened but has chance.
>> Ex. The single-end MIC goes to input boot stage. Therefore, we move
>> the target of MICBIAS to input boost stage which can supply power for
>> both cases.
>
> That's not really answering the question - the issue is that the micbias
> is normally connected to the microphone and supplies that, it's not
> normally connected to anything in the CODEC itself.  You're talking
> about the path for the signal from the microphone which isn't the same
> thing as the power to the microphone.  The system could have external
> micbiases or use the input for something that isn't actually a
> microphone for example.

Yes, you are right. In the driver, we suppose that the input of codec
is microphone always. Therefore, we make the micbias on to provide the
power of microphone automatically if any input path is enabled.
What advice do you have to deal with micbias? Thank you.



===========================================================================================
The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Nuvoton is strictly prohibited; and any information in this email irrelevant to the official business of Nuvoton shall be deemed as neither given nor endorsed by Nuvoton.
