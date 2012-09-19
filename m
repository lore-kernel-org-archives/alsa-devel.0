From: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: Re: [PATCH 5/7] ASoC: fsl: convert pcm030-audio-fabric
 to a platform-driver
Date: Wed, 19 Sep 2012 10:35:45 -0400
Message-ID: <0A40042D85E7C84DB443060EC44B3FD3459868BABB@dekaexchange07.deka.local>
References: <1347572596-37540-1-git-send-email-emillbrandt@dekaresearch.com>
 <1347572596-37540-6-git-send-email-emillbrandt@dekaresearch.com>
 <20120919030324.GO8832@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dekaexchange07.deka.local (mail.dekaresearch.com
 [208.65.175.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D5A82651ED
 for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2012 16:34:29 +0200 (CEST)
In-Reply-To: <20120919030324.GO8832@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: 'Mark Brown' <broonie@opensource.wolfsonmicro.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Anatolij Gustschin <agust@denx.de>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 2012-09-18 Mark Brown wrote:
> On Thu, Sep 13, 2012 at 05:43:14PM -0400, Eric Millbrandt wrote:
>
>> +static int __devexit pcm030_fabric_remove(struct platform_device *op)
>> +{ + struct platform_device *pdev = platform_get_drvdata(op); +
>> +    platform_device_unregister(pdev); + +   return 0; +}
>
> This seems really confused...  why is a platform device registering
> another platform device?  Do you mean to convert to
> snd_soc_register_card()?
>
That was an artifact of me splitting the changes to pcm030-audio-fabric.c
into multiple patches.  I changed the driver to a platform device in this
patch and converted to snd_soc_register_card() in the next patch.  I can
merge the two patches back together if you think that is cleaner and
easier to understand.

Thanks
Eric


-DISCLAIMER: an automatically appended disclaimer may follow. By posting-
-to a public e-mail mailing list I hereby grant permission to distribute-
-and copy this message.-

This e-mail and the information, including any attachments, it contains are intended to be a confidential communication only to the person or entity to whom it is addressed and may contain information that is privileged. If the reader of this message is not the intended recipient, you are hereby notified that any dissemination, distribution or copying of this communication is strictly prohibited. If you have received this communication in error, please immediately notify the sender and destroy the original message.

Thank you.

Please consider the environment before printing this email.
