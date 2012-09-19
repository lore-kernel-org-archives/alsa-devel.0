From: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: Re: [PATCH v2 1/7] ASoC: fsl: add PPC_MPC52xx
	dependency to	SND_POWERPC_SOC
Date: Wed, 19 Sep 2012 17:07:34 -0400
Message-ID: <0A40042D85E7C84DB443060EC44B3FD3459868BAC0@dekaexchange07.deka.local>
References: <1348066285-87741-1-git-send-email-emillbrandt@dekaresearch.com>
 <20120919204730.GB12297@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dekaexchange07.deka.local (mail.dekaresearch.com
 [208.65.175.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 66AA026522F
 for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2012 23:06:24 +0200 (CEST)
In-Reply-To: <20120919204730.GB12297@opensource.wolfsonmicro.com>
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
To: 'Mark Brown' <broonie@opensource.wolfsonmicro.com>, Grant Likely <grant.likely@secretlab.ca>, Liam Girdwood <lrg@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

On 2012-09-19 Mark Brown wrote:
> On Wed, Sep 19, 2012 at 10:51:25AM -0400,  wrote:
>> From: Eric Millbrandt <emillbrandt@dekaresearch.com>
>>
>> mpc52xx socs need to define SND_POWERPC_SOC to build ASoC drivers.
>>
>> Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com> ---
>> Changes since v1: Patch was "powerpc/52xx: define FSL_SOC" Changed from
>> defining FSL_SOC for PPC_MPC52xx to adding PPC_MPC52xx as a dependency
>> of SND_POWERPC_SOC as per Anatolij Gustschin's comment.
>
> Patches 2 to 7 appear to have gone AWOL?
>
No changes to 2 through 7, so I didn't repost the full series.

Eric



-DISCLAIMER: an automatically appended disclaimer may follow. By posting-
-to a public e-mail mailing list I hereby grant permission to distribute-
-and copy this message.-

This e-mail and the information, including any attachments, it contains are intended to be a confidential communication only to the person or entity to whom it is addressed and may contain information that is privileged. If the reader of this message is not the intended recipient, you are hereby notified that any dissemination, distribution or copying of this communication is strictly prohibited. If you have received this communication in error, please immediately notify the sender and destroy the original message.

Thank you.

Please consider the environment before printing this email.
