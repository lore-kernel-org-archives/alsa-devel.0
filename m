From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8540: new codec driver
Date: Thu, 26 Jan 2017 14:30:19 +0800
Message-ID: <5889977B.4090202@nuvoton.com>
References: <1483597244-9761-1-git-send-email-KCHSU0@nuvoton.com>
 <20170109200052.szyldvyxnki2jggj@sirena.org.uk>
 <58881F56.3080007@nuvoton.com>
 <20170125125049.aml35ei6oc4kwguu@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B6496266F1C
 for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2017 07:30:23 +0100 (CET)
In-Reply-To: <20170125125049.aml35ei6oc4kwguu@sirena.org.uk>
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
Cc: WTLI@nuvoton.com, YHCHuang@nuvoton.com, alsa-devel@alsa-project.org, CTLIN0@nuvoton.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi,
On 1/25/2017 8:50 PM, Mark Brown wrote:
> On Wed, Jan 25, 2017 at 11:45:26AM +0800, John Hsu wrote:
>
>> On 1/10/2017 4:00 AM, Mark Brown wrote:
>>
>>> On Thu, Jan 05, 2017 at 02:20:44PM +0800, John Hsu wrote:
>>>
>
>
>>> Does this sequence need to be done as part of resume as well?
>>>
>
>
>> These initiation just only need to do once when the codec boots.
>> I think it's better to do it when driver module is loaded.
>>
>
> Why not on resume?  While it won't always happen system suspend does
> frequently mean that the device will have lost power so anything done on
> boot will have been lost.
>

Yes, I can move it to resume.
By the way, is it better to do cache sync instead for the situation?



===========================================================================================
The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Nuvoton is strictly prohibited; and any information in this email irrelevant to the official business of Nuvoton shall be deemed as neither given nor endorsed by Nuvoton.
