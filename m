From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH] ASoC: fsl: expand the size of the name in
 fsl_ssi_private struct
Date: Thu, 23 May 2013 06:19:53 -0500
Message-ID: <519DFB59.6090004@tabi.org>
References: <1369299072-25147-1-git-send-email-b42378@freescale.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B7248@saturn3.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
 [71.74.56.122]) by alsa0.perex.cz (Postfix) with ESMTP id 6248A2625EE
 for <alsa-devel@alsa-project.org>; Thu, 23 May 2013 13:19:56 +0200 (CEST)
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B7248@saturn3.aculab.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Laight <David.Laight@ACULAB.COM>, Nicolin Chen <b42378@freescale.com>, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org
Cc: broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

David Laight wrote:
>> strcpy(ssi_private->name, p) in probe() sets "name" by "p", gotten from dts,
>> >while the length of "p", if the devicetree node name of SSI is commonly set,
>> >would always be larger than 1 char size, so need a larger size for "name".
> Are you sure this isn't allowed for when the structure is allocated?
> Otherwise you also need to use strlcpy() as well.

Yes, this is already handled properly:

p = strrchr(np->full_name, '/') + 1;
ssi_private = kzalloc(sizeof(struct fsl_ssi_private) + strlen(p),
                       GFP_KERNEL);

Nicolin's patch is wrong.  Do not apply it.

-- 
Timur Tabi
